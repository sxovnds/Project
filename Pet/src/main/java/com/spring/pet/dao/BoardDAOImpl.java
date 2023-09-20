package com.spring.pet.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.BoardDto;
import com.spring.pet.dto.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public void write(BoardDto boardDto) throws Exception {
		sqlSession.insert("board.insert", boardDto);
	}
	
	// 게시물 목록 조회
	@Override
	public List<BoardDto> list(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("board.listPage",scri);
	}
	
	//게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne("board.listCount",scri);
	}
	
	// 게시물 조회
	@Override
	public BoardDto read(int bno) throws Exception {	
		return sqlSession.selectOne("board.read", bno);
	}
	
	// 게시물 수정
	@Override
	public void update(BoardDto boardDto) throws Exception {		
		sqlSession.update("board.update", boardDto);
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {	
		sqlSession.delete("board.delete", bno);
	}
	
	//게시판 조회수
	@Override
	public void boardHit(int bno) throws Exception {
		sqlSession.update("board.boardHit", bno);
	}

}
