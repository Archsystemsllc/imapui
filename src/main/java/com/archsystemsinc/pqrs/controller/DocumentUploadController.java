package com.archsystemsinc.pqrs.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.archsystemsinc.pqrs.model.CategoryLookup;
import com.archsystemsinc.pqrs.model.DocumentUpload;
import com.archsystemsinc.pqrs.model.MeasureLookup;
import com.archsystemsinc.pqrs.model.MeasureWiseExclusionRate;
import com.archsystemsinc.pqrs.model.ProviderHypothesis;
import com.archsystemsinc.pqrs.model.Speciality;
import com.archsystemsinc.pqrs.model.StatewiseStatistic;
import com.archsystemsinc.pqrs.service.CategoryLookupService;
import com.archsystemsinc.pqrs.service.DataAnalysisService;
import com.archsystemsinc.pqrs.service.MeasureLookupService;
import com.archsystemsinc.pqrs.service.MeasureWiseExclusionRateService;
import com.archsystemsinc.pqrs.service.ParameterLookUpService;
import com.archsystemsinc.pqrs.service.ProviderHypothesisService;
import com.archsystemsinc.pqrs.service.ReportingOptionLookUpService;
import com.archsystemsinc.pqrs.service.SpecialityService;
import com.archsystemsinc.pqrs.service.StatewiseStatisticService;
import com.archsystemsinc.pqrs.service.SubDataAnalysisService;
import com.archsystemsinc.pqrs.service.YearLookUpService;

/**
 * controller class for file upload and insert functionality of provider hypothesis, 
 * state wise statistics, and specialty data
 * 
 * @author Grmahun Redda
 * @since 6/20/2017
 */
@Controller
public class DocumentUploadController {
	
	@Autowired
	private ProviderHypothesisService providerHypothesisService;
	
	@Autowired
	private ParameterLookUpService parameterLookUpService;
	
	@Autowired
	private ReportingOptionLookUpService reportingOptionLookUpService;
	
	@Autowired
	private YearLookUpService yearLookUpService;
	
	@Autowired
	private SpecialityService specialtyService;
	
	@Autowired
	private StatewiseStatisticService statewiseStatisticService;
	
	@Autowired
	private DataAnalysisService dataAnalysisService;
	
	@Autowired
	private SubDataAnalysisService subDataAnalysisService;
	
	@Autowired
	private MeasureLookupService measureLookupService;
	
	@Autowired
	private CategoryLookupService categoryLookupService;
	
	@Autowired
	private MeasureWiseExclusionRateService measureWiseExclusionRateService;
	
	@RequestMapping(value = "/admin/documentupload", method = RequestMethod.GET)
	public String documentUploadGet(final Model model, HttpSession session) {		
		
		model.addAttribute("documentFileUpload", new DocumentUpload());
		model.addAttribute("dataAnalysisCategories", dataAnalysisService.findAll());
		model.addAttribute("subDataAnalysisCategories", subDataAnalysisService.findAll());
		
		return "uploadform";
	}
	
	@RequestMapping(value = "/admin/documentupload", method = RequestMethod.POST)
	public String documentUploadPost(
			@Valid@ModelAttribute("documentFileUpload") final DocumentUpload documentFileUpload, final Principal principal,
			final BindingResult result, final HttpServletRequest request, final RedirectAttributes redirectAttributes) throws InvalidFormatException {		
		
		try {
			//
			//documentUploadProvider(documentFileUpload);
			boolean fileEmpty = false;
			
			if(documentFileUpload.getProvider().getSize() > 0){
				documentFileUpload.setDocumentTypeId(1L);
				documentUploadProvider(documentFileUpload);
			}else if(documentFileUpload.getSpecialty().getSize() > 0){
				documentFileUpload.setDocumentTypeId(2L);
				specialtyDocUpload(documentFileUpload);
			}else if(documentFileUpload.getStatewise().getSize() > 0){
				documentFileUpload.setDocumentTypeId(3L);
				stateWiseStatistics(documentFileUpload);
			}else if(documentFileUpload.getMeasureWiseExclusionRate().getSize() > 0){
				documentFileUpload.setDocumentTypeId(4L);
				documentUploadMeasureWiseExclusionRate(documentFileUpload);
			}else {
				fileEmpty = true;
			}
			
			if(fileEmpty) {
				redirectAttributes.addFlashAttribute("documentuploaderror", "error.file.empty");
			} else {
				redirectAttributes.addFlashAttribute("documentuploadsuccess", "success.import.document");
			}
            
		} catch(InvalidFormatException ife) {
			ife.printStackTrace();
			redirectAttributes.addFlashAttribute("documentuploaderror", ife.getMessage());
		} catch (Exception e) {
			System.out.println("Exception in Documents Upload page: " + e.getMessage());	
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("documentuploaderror","error.import.document");			
		}			
		
		return "redirect:/admin/documentupload";		
	}

	
   
	public void documentUploadProvider(
			final DocumentUpload documentFileUpload) throws InvalidFormatException, EncryptedDocumentException, IOException {
		
		int totalNumberOfRows = 0;
		int totalProRowsCreatedOrUpdated = 0;
		ArrayList<Object> returnObjects = null;
		
		//try {
			
			if (documentFileUpload.getProvider() != null) {
				
				Workbook providersFileWorkbook = null;
				try {
					providersFileWorkbook = WorkbookFactory.create(documentFileUpload.getProvider().getInputStream());
				}catch(InvalidFormatException ife) {
					System.out.println("Invalid format Exception in Documents Upload page: " + ife.getMessage());	
					ife.printStackTrace();
					throw new InvalidFormatException("error.file.format");
				}
						
				Sheet providersFileSheet = providersFileWorkbook.getSheetAt(0);
				Iterator<Row> providersFileRowIterator = providersFileSheet.rowIterator();
                int providersFileRowCount = providersFileSheet.getPhysicalNumberOfRows();
				totalNumberOfRows = providersFileRowCount - 1;
				String stringResult = "";

				while (providersFileRowIterator.hasNext()) 
				{
					Row providersFileRow = (Row) providersFileRowIterator.next();
					
					returnObjects = new ArrayList<Object>();
					
					if (providersFileRow.getRowNum() >= 0 && providersFileRow.getRowNum() <= providersFileRowCount)
					{
						System.out.println("ROW - " + providersFileRow.getRowNum());
						Iterator<Cell> iterator = providersFileRow.cellIterator();
						ProviderHypothesis provider = new ProviderHypothesis();
						
						
						while (iterator.hasNext()) 
						{
							Cell hssfCell = iterator.next();
							int cellIndex = hssfCell.getColumnIndex();
							
							if(providersFileRow.getRowNum()==0){
								if(cellIndex == 0 && !hssfCell.getStringCellValue().equals("id")
									|| cellIndex == 1 && !hssfCell.getStringCellValue().equals("year")
									|| cellIndex == 2 && !hssfCell.getStringCellValue().equals("reporting_option")
									|| cellIndex == 3 && !hssfCell.getStringCellValue().equals("parameter")
								    || cellIndex == 4 && !hssfCell.getStringCellValue().equals("yes_value")
									|| cellIndex == 5 && !hssfCell.getStringCellValue().equals("no_value")
									|| cellIndex == 6 && !hssfCell.getStringCellValue().equals("yes_count")
									|| cellIndex == 7 && !hssfCell.getStringCellValue().equals("no_count")
									|| cellIndex == 8 && !hssfCell.getStringCellValue().equals("yes_percent")
									|| cellIndex == 9 && !hssfCell.getStringCellValue().equals("no_percent")
									|| cellIndex == 10 && !hssfCell.getStringCellValue().equals("total_sum")
									|| cellIndex == 11 && !hssfCell.getStringCellValue().equals("rpPercent")
										){
									throw new InvalidFormatException("error.columns.format.mismatch");
								}else{
									continue;
								}
							}
							
							switch (cellIndex) 
							{
							
							case 1:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:					                	
				                    stringResult=hssfCell.getStringCellValue();
				                    provider.setYearLookup(yearLookUpService.findByYearName(stringResult));
				                    System.out.println("Year name: " + stringResult);
				                  
				                    break;
								
								}
								break;								
							case 2:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	
				                    stringResult=hssfCell.getStringCellValue();
				                    System.out.println("Reporting option: " + stringResult);
				                    provider.setReportingOptionLookup(reportingOptionLookUpService.findByReportingOptionName(stringResult));
				                    //System.out.println("Reporting option: " + reportingOptionLookUpService.findByReportingOptionName(stringResult).getReportingOptionName());
				                    break;	
								
								}
								break;
	
							case 3:
								switch (hssfCell.getCellType()) 
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	
				                    stringResult=hssfCell.getStringCellValue();
				                    provider.setParameterLookup(parameterLookUpService.findByParameterName(stringResult));				                   
				                    break;
								
								}
								break;
							case 4:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                    provider.setYesValue((int)hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 5:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                    provider.setNoValue((int)hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 6:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setYesCount(BigInteger.valueOf((int)hssfCell.getNumericCellValue()));				                   
				                    break;								
								}
								break;
							case 7:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setNoCount(BigInteger.valueOf((int)hssfCell.getNumericCellValue()));
				                    break;								
								}
								break;
							case 8:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setYesPercent(hssfCell.getNumericCellValue()*100);
				                    break;								
								}
								break;
							case 9:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setNoPercent(hssfCell.getNumericCellValue()*100);
				                    break;								
								}
								break;
							case 10:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setTotalSum(BigInteger.valueOf((int)hssfCell.getNumericCellValue()));				                					                    
				                    break;								
								}
								break;
							case 11:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	provider.setRpPercent(hssfCell.getNumericCellValue()*100);
				                	provider.setDataAnalysis(dataAnalysisService.findById(documentFileUpload.getProviderHypId()));
				                	provider.setSubDataAnalysis(subDataAnalysisService.findById(documentFileUpload.getProviderSubHypId()));
				                	//System.out.println("hyp ID: " + documentFileUpload.getProviderHypId());
				                	//System.out.println("Sub ID: " + documentFileUpload.getProviderSubHypId());
				                	providerHypothesisService.create(provider);				                    
				                    break;								
								}
								break;		
							}


						}
						
						
					}
 
				}
			}			

	}
	
	
	public void stateWiseStatistics(
			final DocumentUpload documentFileUpload) throws InvalidFormatException, EncryptedDocumentException, IOException {
		int totalNumberOfRows = 0;
		int totalProRowsCreatedOrUpdated = 0;
		ArrayList<Object> returnObjects = null;
		
		
			
			if (documentFileUpload.getStatewise() != null) {
				
				Workbook stateStatFileWorkbook = WorkbookFactory.create(documentFileUpload.getStatewise().getInputStream());
				Sheet stateStatFileSheet = stateStatFileWorkbook.getSheetAt(0);
				Iterator<Row> stateStatFileRowIterator = stateStatFileSheet.rowIterator();
                int stateStatFileRowCount = stateStatFileSheet.getPhysicalNumberOfRows();
				totalNumberOfRows = stateStatFileRowCount - 1;
				String stringResult = "";				 
				
				//long yearId =  2;

				while (stateStatFileRowIterator.hasNext()) 
				{
					Row stateStatFileRow = (Row) stateStatFileRowIterator.next();
					
					returnObjects = new ArrayList<Object>();
					
					if (stateStatFileRow.getRowNum() >= 0 && stateStatFileRow.getRowNum() <= stateStatFileRowCount)
					{
						System.out.println("ROW - " + stateStatFileRow.getRowNum());
						Iterator<Cell> iterator = stateStatFileRow.cellIterator();
						StatewiseStatistic statewiseStatistic = new StatewiseStatistic();
						
						
						while (iterator.hasNext()) 
						{
							Cell hssfCell = (Cell) iterator.next();
							int cellIndex = hssfCell.getColumnIndex();
							
							if(stateStatFileRow.getRowNum()==0){
								if(cellIndex == 0 && !hssfCell.getStringCellValue().equals("STATE")
									|| cellIndex == 1 && !hssfCell.getStringCellValue().equals("YEAR")
									|| cellIndex == 2 && !hssfCell.getStringCellValue().equals("EP or GPRO")
									|| cellIndex == 3 && !hssfCell.getStringCellValue().equals("RURAL or URBAN")
								    || cellIndex == 4 && !hssfCell.getStringCellValue().equals("YES or NO")
									|| cellIndex == 5 && !hssfCell.getStringCellValue().equals("Report_O")
									|| cellIndex == 6 && !hssfCell.getStringCellValue().equals("COUNT")
								){
									throw new InvalidFormatException("Row column informaion isn't in the correct format");
								}else{
									continue;
								}
							}
							
							switch (cellIndex) 
							{
							
							case 0:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:					                	
				                    stringResult=hssfCell.getStringCellValue();
				                    statewiseStatistic.setState(stringResult); 
				                    System.out.println("State: " + stringResult);
				                  
				                    break;
								
								}
								break;								
							case 1:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:
				                	stringResult=hssfCell.getStringCellValue();
				                	statewiseStatistic.setYearLookup(yearLookUpService.findByYearName(stringResult));				                   
				                    break;	
								
								}
								break;
	
							case 2:
								switch (hssfCell.getCellType()) 
								{
								
								case Cell.CELL_TYPE_NUMERIC:
				                    statewiseStatistic.setEpOrGpro((int)hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 3:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_NUMERIC:
				                    statewiseStatistic.setRuralUrban((int)hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 4:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_NUMERIC:
				                    statewiseStatistic.setYesOrNooption((int)hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 5:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_STRING:
									stringResult=hssfCell.getStringCellValue();									
				                    statewiseStatistic.setReportingOptionLookup(reportingOptionLookUpService.findByReportingOptionName(stringResult));
				                    break;								
								}
								break;
							case 6:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_NUMERIC:
									System.out.println("start");
				                    statewiseStatistic.setCount(BigInteger.valueOf((int)hssfCell.getNumericCellValue()));
				                    System.out.println("Count" + hssfCell.getNumericCellValue());
				                    statewiseStatistic.setDataAnalysis(dataAnalysisService.findById(documentFileUpload.getProviderHypId()));
				                    statewiseStatistic.setSubDataAnalysis(subDataAnalysisService.findById(documentFileUpload.getProviderSubHypId()));
				                    statewiseStatisticService.create(statewiseStatistic);
				                    System.out.println("stop");
				                    break;								
								}
								break;
							default:
								break;
							
							}


						}
						
						
					}
 
				}

			}			

	}
	
	
	public void specialtyDocUpload(
			final DocumentUpload documentFileUpload) throws InvalidFormatException, EncryptedDocumentException, IOException {
		int totalNumberOfRows = 0;
		int totalProRowsCreatedOrUpdated = 0;
		ArrayList<Object> returnObjects = null;
		
		
			
			if (documentFileUpload.getSpecialty() != null) {
				
				Workbook specialtyFileWorkbook = WorkbookFactory.create(documentFileUpload.getSpecialty().getInputStream());
				Sheet specialtyFileSheet = specialtyFileWorkbook.getSheetAt(0);
				Iterator<Row> specialtyFileRowIterator = specialtyFileSheet.rowIterator();
                int specialtyFileRowCount = specialtyFileSheet.getPhysicalNumberOfRows();
				totalNumberOfRows = specialtyFileRowCount - 1;
				String stringResult = "";				 
				
				//long yearId =  2;

				while (specialtyFileRowIterator.hasNext()) 
				{
					Row specialtyFileRow = (Row) specialtyFileRowIterator.next();
					
					returnObjects = new ArrayList<Object>();
					
					if (specialtyFileRow.getRowNum() > 0 && specialtyFileRow.getRowNum() <= specialtyFileRowCount)
					{
						System.out.println("ROW - " + specialtyFileRow.getRowNum());
						Iterator<Cell> iterator = specialtyFileRow.cellIterator();
						Speciality specialty = new Speciality();
						
						
						while (iterator.hasNext()) 
						{
							Cell hssfCell = (Cell) iterator.next();
							int cellIndex = hssfCell.getColumnIndex();
							
							switch (cellIndex) 
							{
							
							case 1:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:					                	
				                    stringResult=hssfCell.getStringCellValue();
				                    specialty.setPrimarySpeciality(stringResult);
				                    System.out.println("Primary Spec: " + stringResult);
				                  
				                    break;
								
								}
								break;								
							case 2:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:
				                	specialty.setCount(BigInteger.valueOf((int)hssfCell.getNumericCellValue()));
				                    break;	
								
								}
								break;
	
							case 3:
								switch (hssfCell.getCellType()) 
								{
								
								case Cell.CELL_TYPE_NUMERIC:
									specialty.setPercent(hssfCell.getNumericCellValue());
				                    break;
								
								}
								break;
							case 4:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_STRING:
									stringResult=hssfCell.getStringCellValue();										
									specialty.setYearLookup(yearLookUpService.findByYearName(stringResult));									
				                    break;
								
								}
								break;							
							case 5:
								switch (hssfCell.getCellType())
								{								
								case Cell.CELL_TYPE_STRING:									
									stringResult=hssfCell.getStringCellValue();									
									specialty.setReportingOptionLookup(reportingOptionLookUpService.findByReportingOptionName(stringResult));
									specialtyService.create(specialty);
				                    break;								
								}
								break;
							default:
								break;
							
							}


						}
						
						
					}
 
				}

			}			
	}
	
	public void documentUploadMeasureWiseExclusionRate(
			final DocumentUpload documentFileUpload) throws InvalidFormatException, EncryptedDocumentException, IOException {
		int totalNumberOfRows = 0;
		int totalProRowsCreatedOrUpdated = 0;
		ArrayList<Object> returnObjects = null;		
				
		if (documentFileUpload.getMeasureWiseExclusionRate() != null) {
				
				Workbook measureWiseExclusionRateFileWorkbook = WorkbookFactory.create(documentFileUpload.getMeasureWiseExclusionRate().getInputStream());
				Sheet measureWiseExclusionRateFileSheet = measureWiseExclusionRateFileWorkbook.getSheetAt(0);
				Iterator<Row> measureWiseExclusionRateFileRowIterator = measureWiseExclusionRateFileSheet.rowIterator();
                int measureWiseExclusionRateFileRowCount = measureWiseExclusionRateFileSheet.getPhysicalNumberOfRows();
				totalNumberOfRows = measureWiseExclusionRateFileRowCount - 1;
				String stringResult = "";

				while (measureWiseExclusionRateFileRowIterator.hasNext()) 
				{
					Row measureWiseExclusionRateFileRow = (Row) measureWiseExclusionRateFileRowIterator.next();
					
					returnObjects = new ArrayList<Object>();
					
					if (measureWiseExclusionRateFileRow.getRowNum() >= 0 && measureWiseExclusionRateFileRow.getRowNum() <= measureWiseExclusionRateFileRowCount)
					{
						System.out.println("ROW - " + measureWiseExclusionRateFileRow.getRowNum());
						Iterator<Cell> iterator = measureWiseExclusionRateFileRow.cellIterator();
						MeasureWiseExclusionRate measureWiseExclusionRate = new MeasureWiseExclusionRate();
						MeasureLookup measureLookup = new MeasureLookup();
						CategoryLookup category = new CategoryLookup();
						String measureId = null;
						String reportingOptions = "";
						
						while (iterator.hasNext()) 
						{
							Cell hssfCell = iterator.next();
							int cellIndex = hssfCell.getColumnIndex();
							
							
							if(measureWiseExclusionRateFileRow.getRowNum()==0){
								if(cellIndex == 0 && !hssfCell.getStringCellValue().equals("ID")
									|| cellIndex == 1 && !hssfCell.getStringCellValue().equals("Actual_Measure_ID")
									|| cellIndex == 2 && !hssfCell.getStringCellValue().equals("Measure_Name")
									|| cellIndex == 3 && !hssfCell.getStringCellValue().equals("Year")
								    || cellIndex == 4 && !hssfCell.getStringCellValue().equals("Rep_option1")
									|| cellIndex == 5 && !hssfCell.getStringCellValue().equals("Rep_option2")
									|| cellIndex == 6 && !hssfCell.getStringCellValue().equals("Rep_option3")
									|| cellIndex == 7 && !hssfCell.getStringCellValue().equals("Rep_option4")
									|| cellIndex == 8 && !hssfCell.getStringCellValue().equals("Rep_option5")
									|| cellIndex == 9 && !hssfCell.getStringCellValue().equals("mean_exclusion_rate")
									|| cellIndex == 10 && !hssfCell.getStringCellValue().equals("Frequency")
									|| cellIndex == 11 && !hssfCell.getStringCellValue().equals("allowable_exclusion")
									|| cellIndex == 12 && !hssfCell.getStringCellValue().equals("category_name")
									|| cellIndex == 13 && !hssfCell.getStringCellValue().equals("data_analysis_name")
									|| cellIndex == 14 && !hssfCell.getStringCellValue().equals("sub_data_analysis_name")
										){
									throw new InvalidFormatException("Row column informaion isn't in the correct format");
								}else{
									continue;
								}
							}
							
							stringResult = "";
							
							switch (cellIndex) 
							{
							
							case 1:							
								switch (hssfCell.getCellType())
								{								
				                case Cell.CELL_TYPE_STRING:					                	
				                    stringResult=hssfCell.getStringCellValue();
				                    break;
				                case Cell.CELL_TYPE_NUMERIC:
				                	stringResult=Integer.toString((int)hssfCell.getNumericCellValue());				                	
				                	break;
								}
							
								    if(measureLookupService.findByMeasureId(stringResult) == null){
				                    	measureId = stringResult;
				                    }else{
				                    	measureWiseExclusionRate.setMeasureLookup(measureLookupService.findByMeasureId(stringResult));
				                    }
			                    	System.out.println("measureId: " + stringResult);	
								break;								
							case 2:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	
				                    stringResult=hssfCell.getStringCellValue();
				                    System.out.println("Measure Name: " + stringResult);
				                    if(measureId != null){
				                    	measureLookup.setMeasureId(measureId);
				                    	measureLookup.setMeasureName(stringResult);
				                    	measureLookupService.Save(measureLookup);
				                    	measureWiseExclusionRate.setMeasureLookup(measureLookupService.Save(measureLookup));
				                    	//measureId = null;
				                    	System.out.println("New Measure: " + stringResult);
				                    }				                    
				                    System.out.println("Measure Name: " + stringResult);
				                    break;
								}
								break;
	
							case 3:
								switch (hssfCell.getCellType()) 
								{
								
				                case Cell.CELL_TYPE_STRING:					                	
				                    stringResult = hssfCell.getStringCellValue();
				                    measureWiseExclusionRate.setYearLookup(yearLookUpService.findByYearName(stringResult));				                    				                   
				                    break;								
								}
								break;
							case 4:
							case 5:
							case 6:
							case 7:
							case 8:
								
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	stringResult = hssfCell.getStringCellValue();
				                	reportingOptions += Integer.toString(reportingOptionLookUpService.findByReportingOptionName(stringResult).getId()) + ",";
				                	System.out.println("stringResult: " + stringResult);				                    
				                    break;								
								}
								if(cellIndex == 8){
			                    	//reportingOptions += Integer.toString(reportingOptionLookUpService.findByReportingOptionName(stringResult).getId());
			                    	measureWiseExclusionRate.setReportingOptions(reportingOptions.substring(0,reportingOptions.length()-1));
			                    	System.out.println("Reporting Options: " + reportingOptions);
			                    }//else{
			                    	//reportingOptions += Integer.toString(reportingOptionLookUpService.findByReportingOptionName(stringResult).getId()) + ",";
			                    //}
								break;
							case 9:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	measureWiseExclusionRate.setMeanExclusionRate(hssfCell.getNumericCellValue());				                    
				                    break;								
								}
								break;
							case 10:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_NUMERIC:	
				                	measureWiseExclusionRate.setFrequencies((int)hssfCell.getNumericCellValue());				                					                   
				                    break;								
								}
								break;
							case 11:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	stringResult = hssfCell.getStringCellValue();
				                	measureWiseExclusionRate.setExclusionDecisions(stringResult);				                	
				                    break;								
								}
								break;
							case 12:
								switch (hssfCell.getCellType())
								{
								
				                case Cell.CELL_TYPE_STRING:	
				                	stringResult = hssfCell.getStringCellValue();				                	
				                	measureWiseExclusionRate.setCategoryLookup(categoryLookupService.findByName(stringResult));
				                    break;								
								}
								break;
							case 13:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_STRING:	
				                	stringResult = hssfCell.getStringCellValue();				                	
				                	measureWiseExclusionRate.setDataAnalysis(dataAnalysisService.findByDataAnalysisName(stringResult));
				                    break;									
								}
								break;
							case 14:
								switch (hssfCell.getCellType())
								{
								
								case Cell.CELL_TYPE_STRING:	
				                	stringResult = hssfCell.getStringCellValue();				                	
				                	measureWiseExclusionRate.setSubDataAnalysis(subDataAnalysisService.findBySubDataAnalysisName(stringResult));
				                	measureWiseExclusionRate.setRecordStatus(1);
				                	measureWiseExclusionRateService.create(measureWiseExclusionRate);
				                	break;									
								}
								break;							
							}


						}
						
						
					}
 
				}
		 }			
	}

}
