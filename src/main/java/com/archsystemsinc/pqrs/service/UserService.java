package com.archsystemsinc.pqrs.service;

import java.util.List;

import com.archsystemsinc.pqrs.model.TemplateFile;
import com.archsystemsinc.pqrs.model.User;

/**
 * This is the Service interface for user database table.
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/19/2017
 * 
 */
public interface UserService {

	void save(User user);
	
	void update(User user);

	User findByUsername(String username);
	
	User findById(final Long id);
	
	List<User> findAll();
	
	void deleteById(final Long id);
}
