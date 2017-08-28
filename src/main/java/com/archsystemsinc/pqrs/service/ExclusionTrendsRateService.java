package com.archsystemsinc.pqrs.service;

import java.util.List;

import com.archsystemsinc.pqrs.model.ExclusionTrendsRate;

/**
 * @author Venkat
 *
 */
public interface ExclusionTrendsRateService {
	
	List<ExclusionTrendsRate> findAll();
	ExclusionTrendsRate findById(final int id);
	ExclusionTrendsRate create(final ExclusionTrendsRate exclusionTrendsRate);
}
