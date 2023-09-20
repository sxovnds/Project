package com.spring.pet.service;

import java.util.List;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.OrderDto;

public interface OrderService {
	
	void insert(OrderDto orderDto);
	
	List<OrderDto> myOrderList(String userId);
	
	boolean delFromCart(CartDto cartDto);
	
	int orderCancel(OrderDto orderDto);
	
	List<OrderDto> selectByOrderId(String orderId);
	
	List<OrderDto> list();
	
	boolean updateDelSitu(OrderDto orderDto);

}
