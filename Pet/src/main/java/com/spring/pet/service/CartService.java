package com.spring.pet.service;

import java.util.List;
import java.util.Map;

import com.spring.pet.dto.CartDto;

public interface CartService {
	
	boolean findCartGoods(CartDto cartDto);

	void addGoodsInCart(CartDto cartDto);
	
	Map<String, List> getMyCart(String userId);

}
