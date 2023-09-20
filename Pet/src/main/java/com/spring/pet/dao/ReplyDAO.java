package com.spring.pet.dao;

import java.util.List;

import com.spring.pet.dto.ReplyDto;

public interface ReplyDAO {
	
	//댓글조회
	public List<ReplyDto> readReply(int bno) throws Exception;
	
	//댓글작성
	public void writeReply(ReplyDto dto) throws Exception;
	
	//댓글수정
	public void updateReply(ReplyDto dto) throws Exception;
	
	//댓글삭제
	public void deleteReply(ReplyDto dto) throws Exception;
	
	//선택된 댓글 조회
	public ReplyDto selectReply(int rno) throws Exception;

}
