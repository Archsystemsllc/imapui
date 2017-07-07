/**
 * 
 */
package com.archsystemsinc.pqrs.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.archsystemsinc.pqrs.constant.ChartNameEnum;
import com.archsystemsinc.pqrs.model.ParameterLookup;
import com.archsystemsinc.pqrs.model.ReportingOptionLookup;
import com.archsystemsinc.pqrs.model.YearLookup;
import com.archsystemsinc.pqrs.service.ParameterLookUpService;
import com.archsystemsinc.pqrs.service.ReportingOptionLookUpService;
import com.archsystemsinc.pqrs.service.YearLookUpService;

/**
 * This is the Spring Controller Class for Hypothesis Screen(Map and Chart) Functionality
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/19/2017
 */
@Controller
public class MapAndChartDisplayController {

	@Autowired
	private YearLookUpService yearLookUpService;
	
	
	@Autowired
	private ParameterLookUpService parameterLookUpService;
	
	@Autowired
	private ReportingOptionLookUpService reportingOptionLookUpService;
	
	/**
	 * 
	 * This is the controller method for Map and Chart Display screen and it provides the information to be displayed in that screen.
	 * 
	 * @param dataanalysis
	 * @param subdataanalysis
	 * @param request
	 * @param currentUser
	 * @param model
	 * @return
	 */
	@RequestMapping("/mapandchartdisplay/dataAnalysisId/{dataAnalysisId}/subDataAnalysisId/{subDataAnalysisId}")
	public String mapAndChartScreen(@PathVariable("dataAnalysisId") int dataAnalysisId, @PathVariable("subDataAnalysisId") int subDataAnalysisId, HttpServletRequest request, Principal currentUser, Model model ) {
		
		model.addAttribute("dataAnalysisId", dataAnalysisId);
		model.addAttribute("subDataAnalysisId", subDataAnalysisId);
		
		final List<YearLookup> yearLookups = yearLookUpService.findAll();			
		model.addAttribute("yearLookups", yearLookups);
		
		final List<ReportingOptionLookup> reportingOptionLookups = reportingOptionLookUpService.findAll();			
		model.addAttribute("reportingOptionLookups", reportingOptionLookups);
		
		final List<ParameterLookup> parameterLookups = parameterLookUpService.findAll();			
		model.addAttribute("parameterLookups", parameterLookups);
		
		List<String> reportTypes = new ArrayList<String>();
		for (ChartNameEnum chartName : ChartNameEnum.values()) {
			reportTypes.add(chartName.getChartName());
		}
		
		model.addAttribute("reportTypes", reportTypes);
		
		return "mapandchartdisplay";
		
	}
		
}
