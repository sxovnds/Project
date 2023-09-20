package com.spring.pet.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.pet.dao.CartDAO;
import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.ProductDto;

@Service
public class CartServiceImpl implements CartService{
	
	@Inject
	private CartDAO dao;

	@Override
	public boolean findCartGoods(CartDto cartDto) {
		
		return dao.findCartGoods(cartDto);
	}

	@Override
	public void addGoodsInCart(CartDto cartDto) {
		
		dao.addGoodsInCart(cartDto);
		
	}
	
	@Override
	public Map<String, List> getMyCart(String userId) {
		
		Map<String, List> cartMap = new HashMap<String, List>();
		
		List<CartDto> cartList = dao.getMyCartProductId(userId);
		if (cartList.size() == 0) {
			return null;
		}
		
		List<ProductDto> productList = dao.getMyCartList(cartList);
		
		cartMap.put("cartList", cartList);
		cartMap.put("productList", productList);
		
		return cartMap;
	}

}
