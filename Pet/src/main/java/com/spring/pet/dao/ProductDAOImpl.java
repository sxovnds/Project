package com.spring.pet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.OrderDto;
import com.spring.pet.dto.ProductDto;

@Repository
public class ProductDAOImpl implements ProductDAO{
	
	@Inject
	private SqlSession sql;
	
	//상품리스트
	@Override
	public List<ProductDto> list() {	
		return sql.selectList("product.list");
	}
	
	@Override
	public List<ProductDto> newProductList() {
		
		return sql.selectList("product.newProductList");
	}
	
	//관리자 상품정보 확인
	@Override
	public ProductDto read(String productId) {
		
		return sql.selectOne("product.read", productId);
	}
	
	@Override
	public String getFilename(String productId) {
		
		return sql.selectOne("product.getFilename", productId);
	}
	
	//상품수정
	@Override
	public void update(ProductDto dto) {
		sql.update("product.update", dto);
	}

	@Override
	public void deleteFilesByBno(String productId) {
		sql.delete("product.deleteFilesByBno", productId);
	}

	@Override
	public void addAttach(String filename, String productId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("fullname", filename);
		map.put("productId", productId);
		System.out.println(filename);
		System.out.println(productId);
		
		sql.insert("product.addAttach", map);
	}
	
	@Override
	public List<String> getAttaches(String productId) {
		return sql.selectList("product.getAttaches", productId);
	}
	
	@Override
	public void deleteFile(String filename) {
		sql.delete("product.deleteFile", filename);
	}
	
	//상품삭제
	@Override
	public void delete(String productId) {
		sql.delete("product.delete", productId);
	}
	
	//상품등록
	@Override
	public void insert(ProductDto dto) {
		sql.insert("product.insert", dto);
	}
	
	@Override
	public void minusProductStock(OrderDto orderDto) {
		
		sql.update("product.minusProductStock", orderDto);
	}

	@Override
	public void plusSoldRate(OrderDto orderDto) {
		sql.update("product.plusSoldRate", orderDto);
	}
	
	@Override
	public void plusProductStock(OrderDto orderDto) {
		sql.update("product.plusProductStock", orderDto);
	}

	@Override
	public void minusSoldRate(OrderDto orderDto) {
		sql.update("product.minusSoldRate", orderDto);
	}
}
