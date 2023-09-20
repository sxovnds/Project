package com.spring.pet.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.dto.MemberDto;
import com.spring.pet.dto.OrderDto;
import com.spring.pet.dto.ProductDto;
import com.spring.pet.service.MemberService;
import com.spring.pet.service.OrderService;
import com.spring.pet.service.ProductService;

@Controller
public class AdminController {
	
	@Inject
	MemberService service;
	@Inject
	ProductService pservice;
	@Inject
	OrderService oservice;
	
	@RequestMapping(value = "/admin/main", method = RequestMethod.GET)
	public String main() {
		
		return "admin/main";
	}
	
	//애견상품페이지
	@RequestMapping(value = "/admin/petshop", method = RequestMethod.GET)
	public String petshop() {
		
		return "admin/product/petshop";
	}
	
	//썸네일(애견상품)
	@ResponseBody
	@RequestMapping(value = "/admin/productList", method = RequestMethod.GET)
	public List<ProductDto> productList() {
		
		List<ProductDto> list = pservice.list();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/newProducts", method = RequestMethod.GET)
	public List<ProductDto> newProducts() {
		
		List<ProductDto> list = pservice.newProductList();
		
		return list;
	}
	
	//멤버조회
	@RequestMapping(value = "/admin/list", method = RequestMethod.GET)
	public void list(Model model) {
		
		List<MemberDto> list = service.list();
		model.addAttribute("list", list);
	}
	
	//상품조회
	@RequestMapping(value = "/admin/product/list", method = RequestMethod.GET)
	public void productlist(Model model) {
		
		List<ProductDto> list = pservice.list();
		model.addAttribute("productList", list);
	}
	
	//상품읽기
	@RequestMapping(value = "/admin/product/read/{productId}", method = RequestMethod.GET)
	public String productRead(@PathVariable("productId") String productId ,Model model) {
		
		ProductDto productDto = pservice.read(productId);
		model.addAttribute("productInfo", productDto);

		return "admin/product/read";
	}
	
	
	//상품 수정
	@RequestMapping(value = "/admin/product/update", method = RequestMethod.POST)
	public String productUpdate(ProductDto dto) {
		
		pservice.update(dto);

		StringBuffer sb = new StringBuffer();
		sb.append("redirect:");
		sb.append("/admin");
		sb.append("/product");
		sb.append("/read/");
		sb.append(dto.getProductId());
		
		String path = sb.toString();

		return path;
	}
	
	//상품수정
	@RequestMapping(value = "/admin/product/update/{productId}", method = RequestMethod.GET)
	public String productUpdate(@PathVariable("productId") String productId, Model model) {
		
		ProductDto dto = pservice.updateUI(productId);
		model.addAttribute("productInfo", dto);

		return "admin/product/update"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/product/getAttaches/{productId}")
	public List<String> getAttaches(@PathVariable("productId") String productId) {

		return pservice.getAttaches(productId);
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/product/deleteFile", method = RequestMethod.POST)
	public String deleteFile(String filename) {
		
		pservice.deleteFile(filename);
		return filename;
	}
	
	//상품삭제
	@RequestMapping(value = "/admin/product/delete/{productId}", method = RequestMethod.GET)
	public String delete(@PathVariable("productId") String productId) {
		
		pservice.delete(productId);
		return "redirect:/admin/product/list";
	}
	
	//상품등록
	@RequestMapping(value = "/admin/product/insert", method = RequestMethod.GET)
	public String insert() {
		
		return "admin/product/insert";
	}
	
	//상품등록
	@RequestMapping(value = "/admin/product/insert", method = RequestMethod.POST)
	public String insert(ProductDto dto) {

		String[] files = dto.getFiles();
		String filename = files[0];
		System.out.println(filename);
		dto.setFilename(filename);
		

		pservice.insert(dto);
		
		return "redirect:/admin/product/list";
	}
	
	//주문현황(주문아이디 클릭)
	@RequestMapping(value = "/admin/aboutOrder/{orderId}", method = RequestMethod.GET)
	public String aboutOrder(@PathVariable("orderId") String orderId, Model model) {
		
		List<OrderDto> list = oservice.selectByOrderId(orderId);
		model.addAttribute("list", list);

		return "admin/aboutOrder";
	}
	
	//주문현황
	@RequestMapping(value = "/admin/orderedlist", method = RequestMethod.GET)
	public String orderedlist(Model model) {

		List<OrderDto> list = oservice.list();
		model.addAttribute("list", list);
		
		return "admin/orderedlist";
	}
	
	//배송정보 수정
	@ResponseBody
	@RequestMapping(value = "/admin/updateDelSitu", method = RequestMethod.POST)
	public int updateDelSitu(OrderDto orderDto) {
		
		boolean result = oservice.updateDelSitu(orderDto);
		
		if (result) {
			return 1;
		} else {
			return 0;
		}
	}

}
