package com.archsystemsinc.pqrs.service.impl;

import com.archsystemsinc.pqrs.model.TemplateFile;
import com.archsystemsinc.pqrs.model.User;
import com.archsystemsinc.pqrs.repository.RoleRepository;
import com.archsystemsinc.pqrs.repository.UserRepository;
import com.archsystemsinc.pqrs.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;

/**
 * This is the implementation class of the Service interface for user database table.
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/19/2017
 * 
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(new HashSet<>(roleRepository.findAll()));
        userRepository.save(user);
    }
    
    @Override
    public void update(User user) {
        user.setRoles(new HashSet<>(roleRepository.findAll()));
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
    @Override
	public User findById(Long id) {		
		return userRepository.findOne(id);
	}
    
    @Override
	public List<User> findAll() {
		return userRepository.findAll();
	}
    
    @Override
	public void deleteById(Long id) {		
    	userRepository.delete(id);
	}
}