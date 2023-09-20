package com.spring.pet.dao;

import java.util.List;

import com.spring.pet.dto.OrderDto;
import com.spring.pet.dto.ProductDto;

public interface ProductDAO {
	
	//상품리스트
	List<ProductDto> list();
	
	List<ProductDto> newProductList();
	
	//관리자 상품정보 확인
	ProductDto read(String productId);
	
	String getFilename(String productId);
	
	//상품수정
	void update(ProductDto dto);

	void deleteFilesByBno(String productId);

	void addAttach(String filename, String productId);
	
	List<String> getAttaches(String productId);
	
	void deleteFile(String filename);
	
	//상품삭제
	void delete(String productId);
	
	//상품등록
	void insert(ProductDto dto);
	
	void minusProductStock(OrderDto orderDto);

	void plusSoldRate(OrderDto orderDto);
	
	void plusProductStock(OrderDto orderDto);

	void minusSoldRate(OrderDto orderDto);

}
