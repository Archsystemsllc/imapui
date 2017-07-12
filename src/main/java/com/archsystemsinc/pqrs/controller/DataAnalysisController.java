package com.archsystemsinc.pqrs.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.archsystemsinc.pqrs.model.DataAnalysis;
import com.archsystemsinc.pqrs.service.DataAnalysisService;

/**
 * This is the Spring Controller Class for the Hypothesis Screen.
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/26/2017
 */
@Controller
public class DataAnalysisController {
	
	@Autowired
	private DataAnalysisService dataAnalysisService;

	/**
	 * This is the controller method for the DataAnalysis Screen.
	 * 
	 * @param request
	 * @param currentUser
	 * @param model
	 * @return
	 */
	@RequestMapping("admin/dashboard")
    public String adminDataAnalysisScreen(HttpServletRequest request, Principal currentUser, Model model) {
		
		final List<DataAnalysis> dataAnalysisList = dataAnalysisService.findAll();
		
		model.addAttribute("dataAnalysisList", dataAnalysisList);

        return "adminDataAnalysis";
    }
	
	/**
	 * This is the controller method for the DataAnalysis Screen.
	 * 
	 * @param request
	 * @param currentUser
	 * @param model
	 * @return
	 */
	@RequestMapping("user/dashboard")
    public String userDataAnalysisScreen(HttpServletRequest request, Principal currentUser, Model model) {
		
		final List<DataAnalysis> dataAnalysisList = dataAnalysisService.findAll();
		
		model.addAttribute("dataAnalysisList", dataAnalysisList);

        return "dataanalysis";
    }


}