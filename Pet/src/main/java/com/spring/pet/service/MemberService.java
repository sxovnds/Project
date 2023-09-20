package com.spring.pet.service;

import java.util.List;

import com.spring.pet.dto.MemberDto;

public interface MemberService {
	
	//회원가입
	public void register(MemberDto dto) throws Exception;
	
	//로그인
	public MemberDto login(MemberDto dto) throws Exception;
	
	//회원정보수정
	public void memberUpdate(MemberDto dto) throws Exception;
	
	//회원탈퇴
	public void memberDelete(MemberDto dto) throws Exception;
	
	//패스워트체크
	public int passChk (MemberDto dto) throws Exception;
	
	//아이디 중복 체크
	public int idChk(MemberDto dto) throws Exception;
	
	//관리자 페이지(회원목록)
	List<MemberDto> list();
	
	MemberDto read(String userId);
	
	//아이디찾기
	MemberDto findIdByNameAndEmail(MemberDto dto);
	
	//비밀번호찾기
	public int findPw(MemberDto dto) throws Exception;
	
	boolean password_reset(String userId,String password);

}
