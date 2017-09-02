package com.archsystemsinc.pqrs.controller;

import com.archsystemsinc.pqrs.model.User;
import com.archsystemsinc.pqrs.service.SecurityService;
import com.archsystemsinc.pqrs.service.UserService;
import com.archsystemsinc.pqrs.validator.UserValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * This is the Spring Controller Class for User Login Functionality.
 * 
 * This class provides the functionalities for 1. User Registration,
 * 2. Re-directing to the welcome Page, and 3. The Login Page.
 * 
 * @author Murugaraj Kandaswamy
 * @since 6/19/2017
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    /**
     * This method provides the functionalities for the User Registration.
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }
    
    /**
     * This method provides the functionalities for listing users.
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAll());

        return "users";
    }
    
    /**
     * 
     * This method provides the functionalities for the user to re-direct to the welcome
     * page after successful login.
     * 
     * @param userForm
     * @param bindingResult
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/edit-user", method = RequestMethod.POST)
    public String editUser(@ModelAttribute("user") User userForm, BindingResult bindingResult, Model model) {
//        userValidator.validate(userForm, bindingResult);

        userService.update(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:../users";
    }
    
    @RequestMapping(value = "/admin/edit-user/{id}", method = RequestMethod.GET)
	public String editUser(@PathVariable("id") final Long id,
			final Model model, User user) {
		final User userByID = userService.findById(id);
		
		model.addAttribute("user", userByID);
		return "useredit";
	}
    
    /**
     * 
     * This method provides the functionalities for the user to re-direct to the welcome
     * page after successful login.
     * 
     * @param userForm
     * @param bindingResult
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/delete-user", method = RequestMethod.POST)
    public String deleteUser(@ModelAttribute("user") User userForm, BindingResult bindingResult, Model model) {
        userService.deleteById(userForm.getId());

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "users";
    }
    
    /**
     * 
     * This method provides the functionalities for the user to re-direct to the welcome
     * page after successful login.
     * 
     * @param userForm
     * @param bindingResult
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:../users";
    }

    /**
     * 
     *  This method provides the functionalities for the User to login to the application.
     * 
     * @param model
     * @param error
     * @param logout
     * @return
     */
    @RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String login(Model model, String error) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");
/*
        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");*/

        return "login";
    }
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logout (HttpServletRequest request, HttpServletResponse response) {
        org.springframework.security.core.Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){    
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
} 
}