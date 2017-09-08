package com.archsystemsinc.pqrs.service;

import java.util.List;

import com.archsystemsinc.pqrs.model.ExclusionTrendsRate;

/**
 * This is the Service interface for exclusion_trends database table.
 * 
 * @author Venkat
 * @since 8/23/2017
 * 
 */
public interface ExclusionTrendsRateService {
	
	List<ExclusionTrendsRate> findAll();
	ExclusionTrendsRate findById(final int id);
	ExclusionTrendsRate create(final ExclusionTrendsRate exclusionTrendsRate);
}
