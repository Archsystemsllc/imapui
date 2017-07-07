/**
 * 
 */
package com.archsystemsinc.pqrs.service;

import java.util.List;

import com.archsystemsinc.pqrs.model.DataAnalysis;

/**
 * This is the Service interface for data_analysis database table.
 * 
 * @author Murugaraj Kandaswamy
 *
 */
public interface DataAnalysisService {

	List<DataAnalysis> findAll();
	
	DataAnalysis findById(final int id);
	
	DataAnalysis findByDataAnalysisName(final String dataAnalysisName);
}
