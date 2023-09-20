package com.spring.pet.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.CartDto;
import com.spring.pet.dto.ProductDto;

@Repository
public class CartDAOImpl implements CartDAO{
	
	@Inject
	private SqlSession sql;
	
	@Override
	public boolean findCartGoods(CartDto cartDto) {
		
		String result = sql.selectOne("cart.findCartGoods", cartDto);
		return Boolean.parseBoolean(result);
	}

	@Override
	public void addGoodsInCart(CartDto cartDto) {

		sql.insert("cart.addGoodsInCart", cartDto);
	}
	
	@Override
	public List<CartDto> getMyCartProductId(String userId) {
		
		return sql.selectList("cart.getMyCartProductId", userId);
	}

	@Override
	public List<ProductDto> getMyCartList(List<CartDto> cartlist) {
		
		return sql.selectList("cart.getMyCartList", cartlist);
	}

}
