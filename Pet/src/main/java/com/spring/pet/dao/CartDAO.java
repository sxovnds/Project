package com.spring.pet.dao;

import java.util.List;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.ProductDto;

public interface CartDAO {
	
	boolean findCartGoods(CartDto cartDto);

	void addGoodsInCart(CartDto cartDto);
	
	List<CartDto> getMyCartProductId(String userId);

	List<ProductDto> getMyCartList(List<CartDto> cartlist);

}
