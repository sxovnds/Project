package com.spring.pet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.pet.dto.MemberDto;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject SqlSession sql;
	
	// 회원가입
	@Override
	public void register(MemberDto dto) throws Exception {
		sql.insert("member.register", dto);
	}
	
	//로그인
	@Override
	public MemberDto login(MemberDto dto) throws Exception {
		return sql.selectOne("member.login", dto);
	}
	
	//회원정보수정
	@Override
	public void memberUpdate(MemberDto dto) throws Exception {
		sql.update("member.memberUpdate", dto); 
	}
	
	// 회원 탈퇴
	@Override
	public void memberDelete(MemberDto dto) throws Exception {
		sql.delete("member.memberDelete", dto);
	}
	
	// 패스워드 체크
	@Override
	public int passChk(MemberDto dto) throws Exception {
		int result = sql.selectOne("member.passChk", dto);
		return result;
	}
	
	// 아이디 중복 체크
	@Override
	public int idChk(MemberDto dto) throws Exception {
		int result = sql.selectOne("member.idChk", dto);
		return result;
	}
	
	//관리자 페이지(회원목록)
	@Override
	public List<MemberDto> list() {
		
		return sql.selectList("member.list");
	}
	
	@Override
	public MemberDto read(String userId) {
		
		return sql.selectOne("member.read", userId);
	}
	
	//아이디찾기
	@Override
	public MemberDto findIdByNameAndEmail(MemberDto dto) {
		
		return sql.selectOne("member.findIdByNameAndEmail", dto);
	}
	
	//비밀번호찾기
	@Override
	public int findPw(MemberDto dto) throws Exception {
		int result = sql.selectOne("member.findPw", dto);
		return result;
	}
	
	@Override
    public boolean password_reset(String userId, String password) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("userPass", password);
            sql.update("member.password_reset", params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
