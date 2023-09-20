package com.spring.pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HospitalController {
	
	@RequestMapping(value = "/hospital/petmap", method = RequestMethod.GET)
	public String hospital(Model model) {
		
		return "hospital/map";
	}

}
