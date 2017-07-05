/**
 * 
 */
package com.archsystemsinc.pqrs.service;

import java.util.List;

import com.archsystemsinc.pqrs.model.DataAnalysis;

/**
 * @author MurugarajKandaswam
 *
 */
public interface DataAnalysisService {

	List<DataAnalysis> findAll();
	
	DataAnalysis findById(final int id);
	
	DataAnalysis findByDataAnalysisName(final String dataAnalysisName);
}
