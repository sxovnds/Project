package com.spring.pet.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.OrderDto;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Inject
	private SqlSession sql;
	
	@Override
	public void insert(OrderDto orderDto) {
		
		int orderId = sql.selectOne("order.countOrderId");
		orderDto.setOrderId(orderId);
		
		sql.insert("order.insert", orderDto);
	}
	
	@Override
	public boolean delFromCart(CartDto cartDto) {
		
		int result = sql.delete("order.delFromCart", cartDto);
		if (result == 1) {
			return true;
		} else {
			return false;
		}		
	}
	
	@Override
	public List<OrderDto> myOrderList(String userId) {

		List<OrderDto> myOrderList = sql.selectList("order.myOrderList", userId);
		
		if (myOrderList.size() == 0) {	
			return null;
		} else {
			return myOrderList;
		}

	}
	
	@Override
	public int orderCancel(OrderDto orderDto) {
		
		return sql.delete("order.orderCancel", orderDto);
	}
	
	@Override
	public List<OrderDto> selectByOrderId(String orderId) {
		
		return sql.selectList("order.selectByOrderId", orderId);
	}
	
	@Override
	public List<OrderDto> list() {
		
		return sql.selectList("order.list");
	}
	
	@Override
	public boolean updateDelSitu(OrderDto orderDto) {
		
		int result = sql.update("order.updateDelSitu", orderDto);
		if (result == 1) {
			
			return true;
		} else {
			return false;
		}
		
	}

}
