package com.spring.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.pet.dao.BoardDAO;
import com.spring.pet.dto.BoardDto;
import com.spring.pet.dto.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	// 게시글 작성
	@Override
	public void write(BoardDto boardDto) throws Exception {
		dao.write(boardDto);
	}
	
	// 게시물 목록 조회
	@Override
	public List<BoardDto> list(SearchCriteria scri) throws Exception {
		return dao.list(scri);
	}
	
	//게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return dao.listCount(scri);
	}
	
	// 게시물 조회
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardDto read(int bno) throws Exception {
		dao.boardHit(bno);
		return dao.read(bno);
	}
	
	//게시글 수정
	@Override
	public void update(BoardDto boardDto) throws Exception {
		dao.update(boardDto);
	}

	//게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		dao.delete(bno);
	}

}