package com.spring.pet.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.pet.dto.BoardDto;
import com.spring.pet.dto.PageMaker;
import com.spring.pet.dto.ReplyDto;
import com.spring.pet.dto.SearchCriteria;
import com.spring.pet.service.BoardService;
import com.spring.pet.service.ReplyService;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public void writeView(Model model,HttpSession session) throws Exception{
		logger.info("writeView");
		
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write(BoardDto boardDto) throws Exception{
		logger.info("write");
		
		service.write(boardDto);
		
		return "redirect:/board/list";  
	}
	
	// 게시판 목록 조회
	@RequestMapping(value = "/board/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list");
		model.addAttribute("list",service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "board/list";
	}
	
	// 게시판 조회
	@RequestMapping(value = "/board/readView", method = RequestMethod.GET)
	public String read(BoardDto boardDto,@ModelAttribute("scri") SearchCriteria scri ,Model model) throws Exception{
		logger.info("read");
		model.addAttribute("read", service.read(boardDto.getBno()));
		model.addAttribute("scri", scri);
		
		List<ReplyDto> replyList = replyService.readReply(boardDto.getBno());
		model.addAttribute("replyList", replyList);
				
		return "board/readView";
	}
	
	// 게시판 수정뷰
	@RequestMapping(value = "/board/updateView", method = RequestMethod.GET)
	public String updateView(BoardDto boardDto, Model model) throws Exception{
		logger.info("updateView");
		model.addAttribute("update", service.read(boardDto.getBno()));	
		return "board/updateView";
	}
		
	// 게시판 수정
	@RequestMapping(value = "/board/update", method = RequestMethod.POST)
	public String update(BoardDto boardDto) throws Exception{
		logger.info("update");	
		service.update(boardDto);
		return "redirect:/board/list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public String delete(BoardDto boardDto) throws Exception{
		logger.info("delete");
		service.delete(boardDto.getBno());
		return "redirect:/board/list";
	}
	
	//댓글 작성
	@RequestMapping(value="/board/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyDto dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.writeReply(dto);
			
		rttr.addAttribute("bno", dto.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		return "redirect:/board/readView";
	}
	
	//댓글 수정 GET
	@RequestMapping(value="/board/replyUpdateView", method = RequestMethod.GET)
	public String replyUpdateView(ReplyDto dto, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
			
		model.addAttribute("replyUpdate", replyService.selectReply(dto.getRno()));
		model.addAttribute("scri", scri);
			
		return "board/replyUpdateView";
	}
		
	//댓글 수정 POST
	@RequestMapping(value="/board/replyUpdate", method = RequestMethod.POST)
	public String replyUpdate(ReplyDto dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.updateReply(dto);
			
		rttr.addAttribute("bno", dto.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		return "redirect:/board/readView";
	}
	
	//댓글 삭제 GET
	@RequestMapping(value="/board/replyDeleteView", method = RequestMethod.GET)
	public String replyDeleteView(ReplyDto dto, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
			
		model.addAttribute("replyDelete", replyService.selectReply(dto.getRno()));
		model.addAttribute("scri", scri);
			

		return "board/replyDeleteView";
	}
		
	//댓글 삭제
	@RequestMapping(value="/board/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyDto dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.deleteReply(dto);
			
		rttr.addAttribute("bno", dto.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		return "redirect:/board/readView";
	}

}
