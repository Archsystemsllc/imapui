/**
 * 
 */
package com.archsystemsinc.pqrs.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author Q
 *
 */
@Controller
public class CommonController {
	
	private static final Logger log = Logger.getLogger(CommonController.class);
	
	@Value("${imapservices.api}")
	String imapServicesApi;
	
	@RequestMapping("/home")
	public String home(){
		return "welcome";
	}
	@RequestMapping("/reportingHome")
	public String reportingHome(){
		return "reporting_home";
	}
	@RequestMapping(value="/imapServicesApi", method = RequestMethod.GET)
	public @ResponseBody String imapServicesApi(){
		log.debug("<--imapServicesApi-->:"+imapServicesApi);
		imapServicesApi = org.codehaus.jettison.json.JSONObject.quote(imapServicesApi);
		return imapServicesApi;
	}
}
