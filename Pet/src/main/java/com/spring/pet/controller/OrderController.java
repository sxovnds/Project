package com.spring.pet.controller;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.MemberDto;
import com.spring.pet.dto.OrderDto;
import com.spring.pet.dto.ProductDto;
import com.spring.pet.service.CartService;
import com.spring.pet.service.MemberService;
import com.spring.pet.service.OrderService;
import com.spring.pet.service.ProductService;

@Controller
public class OrderController {
	
	@Inject
	CartService cservice;
	
	@Inject
	MemberService mservice;
	
	@Inject
	ProductService pservice;
	
	@Inject
	OrderService oservice;
	
	//상세페이지에서 장바구니담기
	@RequestMapping(value = "/order/cart/{productId}", method = RequestMethod.POST)
	public @ResponseBody String addGoodsInCart(@PathVariable("productId") String productId, HttpSession session) {
		
		MemberDto dto = (MemberDto) session.getAttribute("member");
		String userid = dto.getUserId();
		
		CartDto cartDto = new CartDto();
		
		cartDto.setUserId(userid);
		cartDto.setProductId(productId);
		
		boolean istAlreadyExisted = cservice.findCartGoods(cartDto);
		System.out.println("istAlreadyExisted : " + istAlreadyExisted);
		
		if (istAlreadyExisted) {
			return "already_existed";
		} else {
			cservice.addGoodsInCart(cartDto);
			return "add_success";
		}

	}
	
	//내 장바구니
	@RequestMapping(value = "/order/mycart/{userId}", method = RequestMethod.GET)
	public String myCart(@PathVariable("userId") String userId, Model model) {
		
		Map<String, List> cartMap = cservice.getMyCart(userId);
	
		model.addAttribute("cartMap", cartMap);
		
		return "order/mycart";
	}
	
	//주문
	@RequestMapping(value = "/order/insert", method = RequestMethod.POST)
	public String orderInsert(ProductDto productDto, HttpSession session, Model model,
			@ModelAttribute("selected_Opt") String selected_Opt, 
			@ModelAttribute("order_Qty") String order_Qty,
			@ModelAttribute("getPoint") String sGetPoint) {
		
		MemberDto dto = (MemberDto) session.getAttribute("member");
		dto = mservice.read(dto.getUserId());
		productDto = pservice.read(productDto.getProductId());
		
		model.addAttribute("memberInfo", dto);
		model.addAttribute("productInfo", productDto);
		model.addAttribute("order_Qty", order_Qty);
		model.addAttribute("selected_Opt", selected_Opt);
		
		return "order/orderconfirm";
	}
	
	//주문결과
	@RequestMapping(value = "/order/orderResult", method = RequestMethod.POST)
	public String order(ProductDto productDto,HttpSession session, Model model,
			@ModelAttribute("selected_Opt") String selected_Opt, 
			@ModelAttribute("order_Qty") String order_Qty,
			@ModelAttribute("deliver_msg") String deliver_msg,
			@ModelAttribute("totalAmount") String sTotalAmount,
			@ModelAttribute("cal_info") String cal_info,
			@ModelAttribute("detailAddress") String detailAddress,
			@ModelAttribute("tel") String  tel,
			@ModelAttribute("postcode") String postcode) {
		
		OrderDto orderDto = new OrderDto();
		
		MemberDto dto = (MemberDto) session.getAttribute("member");
		dto = mservice.read(dto.getUserId());
		productDto = pservice.read(productDto.getProductId());
		
		orderDto.setUserId(dto.getUserId());
		orderDto.setUsername(dto.getUserName());
		orderDto.setUseraddress(detailAddress);
		orderDto.setEmail(dto.getUserEmail());
		orderDto.setTel(tel);
		orderDto.setPostcode(postcode);
		
		orderDto.setProductId(productDto.getProductId());
		orderDto.setProductName(productDto.getProductName());
		orderDto.setPrice(productDto.getPrice());
		orderDto.setProductDist(productDto.getProductDist());
		orderDto.setProductInfo(productDto.getProductInfo());
		orderDto.setFullname(productDto.getFilename());
		orderDto.setStock(productDto.getStock());
		
		orderDto.setSelected_Opt(selected_Opt);
		orderDto.setOrder_Qty(order_Qty);
		orderDto.setDeliver_msg(deliver_msg);
		orderDto.setDeliver_situ(0);
		orderDto.setCal_info(cal_info);
		
		int totalAmount = Integer.parseInt(sTotalAmount);
		orderDto.setTotalAmount(totalAmount);

		
		oservice.insert(orderDto);
		model.addAttribute("orderDTO", orderDto);
	
		return "order/orderResult";

	}
	
		//장바구니 주문
		@RequestMapping(value = "/order/cartOrder", method = RequestMethod.POST)
		public String cartOrder(
		    @RequestParam(value = "selectedItems", required = false) String[] selectedItems,
		    HttpSession session, Model model,
		    @ModelAttribute("selected_Opt") String selected_Opt, 
			@ModelAttribute("order_Qty") String order_Qty) {
			
		    if (selectedItems == null || selectedItems.length == 0) {
		        // 선택한 상품이 없는 경우, 장바구니로 이동하거나 에러 메시지를 표시
		        // 이 부분은 상황에 따라 다르게 처리할 수 있습니다.
		        return "redirect:/order/mycart/{userId}"; // 장바구니 페이지로 이동
		    }

		    MemberDto memberDto = (MemberDto) session.getAttribute("member");
		    memberDto = mservice.read(memberDto.getUserId());

		    List<ProductDto> selectedProducts = new ArrayList<>();
		    Set<String> uniqueProductIds = new HashSet<>(); // 중복 상품을 제거하기 위한 Set

		    for (String productId : selectedItems) {
		        if (uniqueProductIds.add(productId)) { // 상품 ID를 Set에 추가하고, 이미 존재하는 경우는 무시
		            ProductDto productDto = pservice.read(productId);
		            selectedProducts.add(productDto);
		        }
		    }

		    model.addAttribute("memberInfo", memberDto);
		    model.addAttribute("selectedProducts", selectedProducts);
		    model.addAttribute("order_Qty", order_Qty);
			model.addAttribute("selected_Opt", selected_Opt);

		    return "order/cartorder";
		}
		
		//장바구니 주문 결과
		@RequestMapping(value = "/order/cartorderResult", method = RequestMethod.POST)
		public String order(HttpServletRequest request, HttpSession session, Model model) {
		    MemberDto dto = (MemberDto) session.getAttribute("member");
		    dto = mservice.read(dto.getUserId());

		    // Check if any items were selected
		    String[] selectedItems = request.getParameterValues("selectedItems");
		    if (selectedItems != null && selectedItems.length > 0) {
		        // Process selected items
		        List<OrderDto> orderList = new ArrayList<>();

		        // Get shared order information (common for all selected items)
		        String username = request.getParameter("username");
		        String useraddress = request.getParameter("useraddress");
		        String email = request.getParameter("email");
		        String tel = request.getParameter("tel");
		        String postcode = request.getParameter("postcode");
		        String deliverMsg = request.getParameter("deliver_msg");
		        String calInfo = request.getParameter("cal_info");
		        int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));

		        for (int i = 0; i < selectedItems.length; i++) {
		            String productId = selectedItems[i];
		            ProductDto productDto = pservice.read(productId);

		            // Create an OrderDto and populate it with product and order information
		            OrderDto orderDto = new OrderDto();
		            orderDto.setUserId(dto.getUserId());
		            orderDto.setUsername(username);
		            orderDto.setUseraddress(useraddress);
		            orderDto.setEmail(email);
		            orderDto.setTel(tel);
		            orderDto.setPostcode(postcode);
		            orderDto.setProductId(productDto.getProductId());
		            orderDto.setProductName(productDto.getProductName());
		            orderDto.setPrice(productDto.getPrice());
		            orderDto.setProductDist(productDto.getProductDist());
		            orderDto.setProductInfo(productDto.getProductInfo());
		            orderDto.setFullname(productDto.getFilename());
		            orderDto.setStock(productDto.getStock());
		            orderDto.setSelected_Opt(request.getParameter("selected_Opt"));
		            orderDto.setOrder_Qty(request.getParameter("order_Qty"));
		            orderDto.setDeliver_msg(deliverMsg);
		            orderDto.setDeliver_situ(0);
		            orderDto.setCal_info(calInfo);
		            orderDto.setTotalAmount(totalAmount);

		            // Add the order to the list
		            orderList.add(orderDto);
		            oservice.insert(orderDto);
		        }

		        // Add the order list to the model
		        model.addAttribute("orderList", orderList);
		    }

		    return "redirect:/";
		}

	
	//장바구니 페이지 상품삭제
	@ResponseBody
	@RequestMapping(value = "/order/delFromCart", method = RequestMethod.POST)
	public String delFromCart(CartDto cartDto) {
		
		boolean result = oservice.delFromCart(cartDto);
		if (result) {
			return "ok";
		} else {
			return "no";
		}
	}
	
	//마이페이지 상품 취소
	@ResponseBody
	@RequestMapping(value = "/order/cancel", method = RequestMethod.POST)
	public int orderCancel(OrderDto orderDto) {
		
		int result = oservice.orderCancel(orderDto);
		return result;
	}

}
