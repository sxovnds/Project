package com.spring.pet.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.pet.dto.ProductDto;
import com.spring.pet.service.ProductService;

@Controller
public class ProductController {
	
	@Inject
	ProductService pservice;
	
	@RequestMapping(value = "/product/show/{productId}", method = RequestMethod.GET)
	public String showProductInfo(@PathVariable("productId") String productId, Model model) {
		
		ProductDto dto = pservice.read(productId);
		model.addAttribute("productInfo", dto);
		return "product/show";
		
	}

}
