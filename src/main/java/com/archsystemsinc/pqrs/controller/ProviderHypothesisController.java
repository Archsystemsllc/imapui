package com.archsystemsinc.pqrs.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.archsystemsinc.pqrs.model.ProviderHypothesis;
import com.archsystemsinc.pqrs.service.ProviderHypothesisService;

/**
 * This is the Spring Controller Class for Bar and Line Chart Implementation.
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/19/2017
 */
@RestController
@RequestMapping("/api")
public class ProviderHypothesisController {
	
	@Autowired
	private ProviderHypothesisService providerHypothesisService;

	/**
	 * 
	 * This method returns the JSON Object that has the details for Bar Chart Display.
	 * 
	 * @param dataAnalysisName
	 * @param subdataAnalysisName
	 * @param year
	 * @param reportingOption
	 * @param request
	 * @param currentUser
	 * @param model
	 * @return
	 */
	@RequestMapping("/barChart/dataAnalysisId/{dataAnalysisId}/subDataAnalysisId/{subDataAnalysisId}/yearId/{yearId}/reportingOptionId/{reportingOptionId}")
    public Map barChartDisplay(@PathVariable("dataAnalysisId") int dataAnalysisId, @PathVariable("subDataAnalysisId") int subDataAnalysisId, @PathVariable("yearId") int yearId, @PathVariable("reportingOptionId") int reportingOptionId, HttpServletRequest request, Principal currentUser, Model model) {

		model.addAttribute("yearId", yearId);
		model.addAttribute("reportingOptionId", reportingOptionId);
		String dataAvailable = "NO";
		
		Map barChartDataMap = new HashMap();
	
		final List<ProviderHypothesis> providerHypothesisList = providerHypothesisService.findByDataAnalysisAndSubDataAnalysisAndYearLookupAndReportingOptionLookup(dataAnalysisId, subDataAnalysisId, yearId, reportingOptionId);
		
		// Preparing Parameter String Array
		List<String> parameters = new ArrayList<String>();
		List<Double> yesPercents = new ArrayList<Double>();
		List<Double> noPercents = new ArrayList<Double>();
		List<String> yesCountValues = new ArrayList<String>();
		List<String> noCountValues = new ArrayList<String>();
		
		for (ProviderHypothesis providerHypothesis : providerHypothesisList){
			parameters.add(providerHypothesis.getParameterLookup().getParameterName());
			yesPercents.add(providerHypothesis.getYesPercent());
			noPercents.add(providerHypothesis.getNoPercent());
			yesCountValues.add(providerHypothesis.getYesCount()+"");
			noCountValues.add(providerHypothesis.getNoCount()+"");
			dataAvailable = "YES";
		}
		
		// Setting barChartData in the Map to be returned back to View....
		barChartDataMap.put("parameters", parameters);
		barChartDataMap.put("yesPercents", yesPercents);
		barChartDataMap.put("noPercents", noPercents);
		barChartDataMap.put("dataAvailable", dataAvailable);
		barChartDataMap.put("yesCountValues",yesCountValues);
		barChartDataMap.put("noCountValues",noCountValues);
		
        return barChartDataMap;
    }
	
	/**
	 * 
	 * This method returns the JSON Object that has the details for Line Chart Display.
	 * 
	 * @param dataAnalysisName
	 * @param subdataAnalysisName
	 * @param parameterName
	 * @param request
	 * @param currentUser
	 * @param model
	 * @return
	 */
	@RequestMapping("/lineChart/dataAnalysisId/{dataAnalysisId}/subDataAnalysisId/{subDataAnalysisId}/parameterId/{parameterId}")
    public Map lineChartDisplay(@PathVariable("dataAnalysisId") int dataAnalysisId, @PathVariable("subDataAnalysisId") int subDataAnalysisId, @PathVariable("parameterId") int parameterId, HttpServletRequest request, Principal currentUser, Model model) {

		model.addAttribute("parameterId", parameterId);
		Map lineChartDataMap = new HashMap();
		String dataAvailable = "NO";
		
		final List<ProviderHypothesis> providerHypothesisList = providerHypothesisService.findByDataAnalysisAndSubDataAnalysisAndParameterLookup(dataAnalysisId, subDataAnalysisId, parameterId);
		
		if (providerHypothesisList != null && providerHypothesisList.size()>0){
			dataAvailable = "YES";
		}
		
		List<String> uniqueYears = providerHypothesisService.getUniqueYearsForLineChart();
		List<Double> claimsPercents = new ArrayList<Double>();
		List<Double> ehrPercents = new ArrayList<Double>();
		List<Double> registryPercents = new ArrayList<Double>();
		List<Double> gprowiPercents = new ArrayList<Double>();
		List<Double> qcdrPercents = new ArrayList<Double>();
		
		providerHypothesisService.setRPPercentValue(providerHypothesisList, claimsPercents, ehrPercents, registryPercents, gprowiPercents, qcdrPercents);
		
		lineChartDataMap.put("uniqueYears", uniqueYears);
		lineChartDataMap.put("claimsPercents", claimsPercents);
		lineChartDataMap.put("ehrPercents", ehrPercents);
		lineChartDataMap.put("registryPercents", registryPercents);
		lineChartDataMap.put("gprowiPercents", gprowiPercents);
		lineChartDataMap.put("qcdrPercents", qcdrPercents);
		lineChartDataMap.put("dataAvailable", dataAvailable);
		
		return lineChartDataMap;
    }

}