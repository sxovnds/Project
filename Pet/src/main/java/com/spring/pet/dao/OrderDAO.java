package com.spring.pet.dao;

import java.util.List;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.OrderDto;

public interface OrderDAO {
	
	void insert(OrderDto orderDto);
	
	boolean delFromCart(CartDto cartDto);
	
	List<OrderDto> myOrderList(String userId);
	
	int orderCancel(OrderDto orderDto);
	
	List<OrderDto> selectByOrderId(String orderId);
	
	List<OrderDto> list();
	
	boolean updateDelSitu(OrderDto orderDto);

}
