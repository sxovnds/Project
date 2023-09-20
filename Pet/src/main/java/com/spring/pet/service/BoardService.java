package com.spring.pet.service;

import java.util.List;

import com.spring.pet.dto.BoardDto;
import com.spring.pet.dto.SearchCriteria;

public interface BoardService {
	
	// 게시글 작성
	public void write(BoardDto boardDto) throws Exception;
	
	// 게시물 목록 조회
	public List<BoardDto> list(SearchCriteria scri) throws Exception;
	
	//게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 게시물 목록 조회
	public BoardDto read(int bno) throws Exception;
	
	// 게시물 수정
	public void update(BoardDto boardDto) throws Exception;
		
	// 게시물 삭제
	public void delete(int bno) throws Exception;

}
