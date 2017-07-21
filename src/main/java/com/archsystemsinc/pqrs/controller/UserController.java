package com.archsystemsinc.pqrs.controller;

import com.archsystemsinc.pqrs.model.User;
import com.archsystemsinc.pqrs.service.SecurityService;
import com.archsystemsinc.pqrs.service.UserService;
import com.archsystemsinc.pqrs.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
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
    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/welcome";
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
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }
    
}