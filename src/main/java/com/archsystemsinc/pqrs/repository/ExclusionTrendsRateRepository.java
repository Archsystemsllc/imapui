package com.archsystemsinc.pqrs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.archsystemsinc.pqrs.model.ExclusionTrendsRate;

/**
 * @author Venkat Challa
 *
 */
public interface ExclusionTrendsRateRepository extends JpaRepository<ExclusionTrendsRate, Long>{
	ExclusionTrendsRate findById(final int id);
}
