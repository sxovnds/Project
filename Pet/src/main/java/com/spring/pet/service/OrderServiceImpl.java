package com.spring.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.pet.dao.OrderDAO;
import com.spring.pet.dao.ProductDAO;
import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.OrderDto;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Inject
	private OrderDAO odao;
	
	@Inject
	private ProductDAO pdao;
	
	@Override
	@Transactional
	public void insert(OrderDto orderDto) {
		
		odao.insert(orderDto);
		pdao.minusProductStock(orderDto);
		pdao.plusSoldRate(orderDto);
		
		CartDto cartDto = new CartDto();
		cartDto.setUserId(orderDto.getUserId());
		cartDto.setProductId(orderDto.getProductId());
		
		odao.delFromCart(cartDto);
		
	}
	
	@Override
	public List<OrderDto> myOrderList(String userId) {
		
		return odao.myOrderList(userId);
	}
	
	@Override
	public boolean delFromCart(CartDto cartDto) {
		
		return odao.delFromCart(cartDto);
	}
	
	@Override
	public int orderCancel(OrderDto orderDto) {
		
		pdao.plusProductStock(orderDto);
		pdao.minusSoldRate(orderDto);
		return odao.orderCancel(orderDto);
	}
	
	@Override
	public List<OrderDto> selectByOrderId(String orderId) {
		
		return odao.selectByOrderId(orderId);
	}
	
	@Override
	public List<OrderDto> list() {
		
		return odao.list();
	}
	
	@Override
	public boolean updateDelSitu(OrderDto orderDto) {
		
		boolean result = odao.updateDelSitu(orderDto);
		return result;
	}

}
