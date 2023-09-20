package com.spring.pet.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.ReplyDto;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject SqlSession sql;
	
	//댓글조회
	@Override
	public List<ReplyDto> readReply(int bno) throws Exception {
		return sql.selectList("reply.readReply", bno);
	}
	
	//댓글작성
	@Override
	public void writeReply(ReplyDto dto) throws Exception {
		sql.insert("reply.writeReply",dto);
	}
	
	//댓글수정
	public void updateReply(ReplyDto dto) throws Exception {
		sql.update("reply.updateReply",dto);
	}
	
	//댓글삭제
	public void deleteReply(ReplyDto dto) throws Exception {
		sql.delete("reply.deleteReply",dto);
	}
	
	//선택된 댓글 조회
	public ReplyDto selectReply(int rno) throws Exception {
		return sql.selectOne("reply.selectReply",rno);
	}
	

}
