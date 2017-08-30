package com.archsystemsinc.pqrs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.archsystemsinc.pqrs.model.ExclusionTrendsRate;
import com.archsystemsinc.pqrs.repository.ExclusionTrendsRateRepository;
import com.archsystemsinc.pqrs.service.ExclusionTrendsRateService;

/**
 * @author Venkat Challa
 *
 */
@Service
public class ExclusionTrendsRateImpl implements ExclusionTrendsRateService{

	@Autowired
	private ExclusionTrendsRateRepository exclusionTrendsRateRepository;
	
	@Override
	public List<ExclusionTrendsRate> findAll() {		
		return exclusionTrendsRateRepository.findAll();
	}

	@Override
	public ExclusionTrendsRate findById(int id) {		
		return exclusionTrendsRateRepository.findById(id);
	}

	@Override
	public ExclusionTrendsRate create(ExclusionTrendsRate exclusionTrendsRate) {		
		return exclusionTrendsRateRepository.saveAndFlush(exclusionTrendsRate);
	}

}
