package com.spring.pet.service;

import java.util.List;

import com.spring.pet.dto.ProductDto;

public interface ProductService {
	
	//상품리스트
	List<ProductDto> list();
	
	List<ProductDto> newProductList();
	
	//관리자 상품정보 확인
	ProductDto read(String productId);
	
	//상품수정
	ProductDto updateUI(String productId);
	
	//상품수정
	void update(ProductDto dto);
	
	List<String> getAttaches(String productId);
	
	void deleteFile(String filename);
	
	//상품삭제
	void delete(String productId);
	
	//상품등록
	void insert(ProductDto dto);

}
