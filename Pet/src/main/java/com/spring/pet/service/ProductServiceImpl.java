package com.spring.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.pet.dao.ProductDAO;
import com.spring.pet.dto.ProductDto;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Inject
	private ProductDAO dao;
	
	//상품리스트
	@Override
	public List<ProductDto> list() {
		return dao.list();
	}
	
	@Override
	public List<ProductDto> newProductList() {
		
		return dao.newProductList();
	}
	
	//관리자 상품정보 확인
	@Override
	public ProductDto read(String productId) {
		
		ProductDto dto = null;
		
		String filename = dao.getFilename(productId);
		dto = dao.read(productId);
		dto.setFilename(filename);

		return dto;
	}
	
	//상품수정
	@Override
	public ProductDto updateUI(String productId) {
		
		return dao.read(productId);
	}
	
	//상품수정
	@Override
	public void update(ProductDto dto) {
		
		dao.update(dto);
		
		String[] arr = dto.getFiles();

		if (arr == null) {
			return;
		}
		
		dao.deleteFilesByBno(dto.getProductId());
		
		for(String filename : arr) {
			
			dao.addAttach(filename, dto.getProductId());
		}
	}
	
	@Override
	public List<String> getAttaches(String productId) {
		return dao.getAttaches(productId);
	}
	
	@Override
	public void deleteFile(String filename) {
		dao.deleteFile(filename);
	}
	
	//상품삭제
	@Override
	public void delete(String productId) {
		dao.delete(productId);
	}
	
	//상품등록
	@Override
	public void insert(ProductDto dto) {
		dao.insert(dto);
		String[] arr = dto.getFiles();
		if (arr == null) {
			return;
		}
		
		for(String filename : arr) {	
			dao.addAttach(filename, dto.getProductId());
		}
	}
	
}
