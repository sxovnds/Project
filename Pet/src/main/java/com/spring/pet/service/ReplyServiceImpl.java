package com.spring.pet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.pet.dao.ReplyDAO;
import com.spring.pet.dto.ReplyDto;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO dao;
	
	//댓글조회
	@Override
	public List<ReplyDto> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}
	
	//댓글작성
	@Override
	public void writeReply(ReplyDto dto) throws Exception {
		dao.writeReply(dto);
	}
	
	//댓글수정
	@Override
	public void updateReply(ReplyDto dto) throws Exception {
		dao.updateReply(dto);
	}
		
	//댓글삭제
	@Override
	public void deleteReply(ReplyDto dto) throws Exception {
		dao.deleteReply(dto);
	}
		
	//선택된 댓글 조회
	@Override
	public ReplyDto selectReply(int rno) throws Exception {
		return dao.selectReply(rno);
	}

}
