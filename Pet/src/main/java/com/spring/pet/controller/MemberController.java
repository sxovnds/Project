package com.spring.pet.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.pet.dto.MemberDto;
import com.spring.pet.dto.OrderDto;
import com.spring.pet.service.MemberService;
import com.spring.pet.service.OrderService;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
		@Inject
		MemberService service;
		
		@Inject
		OrderService oservice;
		
		@Inject
		BCryptPasswordEncoder pwdEncoder;
		
		//마이페이지
		@RequestMapping(value = "/member/mypage/{userId}", method = RequestMethod.GET)
		public String mypage(@PathVariable("userId") String userId, Model model) {
			
			List<OrderDto> orderList = oservice.myOrderList(userId);
			model.addAttribute("orderList", orderList);
			
			return "member/mypage";
		}
	
		// 회원가입 get
		@RequestMapping(value = "/member/register", method = RequestMethod.GET)
		public void getRegister() throws Exception {
			logger.info("get register");
		}
		
		// 아이디 중복 체크
		@ResponseBody
		@RequestMapping(value="/member/idChk", method = RequestMethod.POST)
		public int idChk(MemberDto dto) throws Exception {
			int result = service.idChk(dto);
			return result;
		}
		
		// 회원가입 post
		@RequestMapping(value = "/member/register", method = RequestMethod.POST)
		public String postRegister(MemberDto dto) throws Exception {
			logger.info("post register");
			int result = service.idChk(dto);
			try {
				if(result == 1) {
					return "/member/register";
				}else if(result == 0) {
					String inputPass = dto.getUserPass();
					String pwd = pwdEncoder.encode(inputPass);
					dto.setUserPass(pwd);
					
					service.register(dto);
				}
				// 요기에서~ 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기 
				// 존재하지 않는다면 -> register
			} catch (Exception e) {
				throw new RuntimeException();
			}
			return "redirect:/";
		}
		
		// 로그인 get
		@RequestMapping(value = "/member/login", method = RequestMethod.GET)
		public void getLogin() throws Exception {
			logger.info("get login");
		}
		
		//로그인 POST
		@RequestMapping(value = "/member/login", method = RequestMethod.POST)
		public String postLogin(Model model, MemberDto dto, HttpSession session) throws Exception{
			logger.info("post login");
					
			session.getAttribute("member");
			MemberDto login = service.login(dto);
			boolean pwdMatch = pwdEncoder.matches(dto.getUserPass(), login.getUserPass());
					
			if(login != null && pwdMatch == true) {
				session.setAttribute("member", login);
			}else {
				model.addAttribute("check", 1);
				model.addAttribute("message", "로그인 실패!!!! 아이디와 비밀번호를 확인해주세요.");
				return "member/login";
			}
					
			return "redirect:/";
		}
		
		//로그아웃
		@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
		public String logout(HttpSession session) throws Exception{
			
			session.invalidate();
			
			return "redirect:/";
		}
		
		//회원정보수정
		@RequestMapping(value="/member/memberUpdateView", method = RequestMethod.GET)
		public String registerUpdateView() throws Exception{
			
			return "member/memberUpdateView";
		}
		
		//회원정보수정
		@RequestMapping(value="/member/memberUpdate", method = RequestMethod.POST)
		public String registerUpdate(MemberDto dto, HttpSession session) throws Exception{
			
			service.memberUpdate(dto);
			session.invalidate();
			
			return "redirect:/";
		}
		
		// 회원 탈퇴 get
		@RequestMapping(value="/member/memberDeleteView", method = RequestMethod.GET)
		public String memberDeleteView() throws Exception{
			return "member/memberDeleteView";
		}
		
		// 회원 탈퇴 post
		@RequestMapping(value="/member/memberDelete", method = RequestMethod.POST)
		public String memberDelete(MemberDto dto, HttpSession session, RedirectAttributes rttr) throws Exception{
			service.memberDelete(dto);
			session.invalidate();
			return "redirect:/";
		}
		
		// 패스워드 체크
		@ResponseBody
		@RequestMapping(value="/member/passChk", method = RequestMethod.POST)
		public boolean passChk(MemberDto dto) throws Exception {
			MemberDto login = service.login(dto);
			boolean pwdChk = pwdEncoder.matches(dto.getUserPass(), login.getUserPass());
			return pwdChk;
		}
		
		//아이디,비번 찾기 get
		@RequestMapping(value = "/member/search", method = RequestMethod.GET)
		public void search() throws Exception {
			
		}
		
		//아이디 찾기
		@ResponseBody
		@RequestMapping(value = "/member/findId", method = RequestMethod.POST)
		public String findId(MemberDto dto) {
			
			dto = service.findIdByNameAndEmail(dto);
			if (dto != null) {
				return dto.getUserId();
			} else {
				return null;
			}
		}
		 
		//비밀번호 수정을 위한 정보확인
		@ResponseBody
		@RequestMapping(value="/member/findPw", method = RequestMethod.POST)
		public int findPw(MemberDto dto) throws Exception {
			int result = service.findPw(dto);
			return result;
		}
		
		//비밀번호 수정 get
		@RequestMapping(value="/member/password_resetView", method = RequestMethod.GET)
		public String password_reset(Model model, String userId) throws Exception{
			service.read(userId);
		    model.addAttribute("vo", service.read(userId));
			
			return "member/password_reset";
		}
		
		//비밀번호 수정 post
		@RequestMapping(value="/member/password_reset", method = RequestMethod.POST)
		@ResponseBody
		public String password_reset(@RequestParam("userId") String userId,@RequestParam("userPass") String userPass) {
		    // 비밀번호를 사용하여 데이터베이스에서 비밀번호를 수정합니다.
			String password = pwdEncoder.encode(userPass);
		    boolean success = service.password_reset(userId,password);

		    if (success) {
		        return "success"; // 성공적으로 변경되면 "success"를 반환합니다.
		    } else {
		        return "failure"; // 변경 실패 시 "failure"를 반환합니다.
		    }
		}

}
