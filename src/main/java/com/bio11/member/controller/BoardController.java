package com.bio11.member.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.bio11.member.dto.MemberDTO;
import com.bio11.member.sevice.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bio11.member.dto.FilesDTO;
import com.bio11.member.dto.BoardDTO;
import com.bio11.member.dto.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	
	@GetMapping("/register")
	public String register(HttpServletRequest request
							, RedirectAttributes ra) {
		log.info("register getMapping 요청 들어옴");
		HttpSession session = request.getSession();
		session = request.getSession();
		MemberDTO memberDto = (MemberDTO) session.getAttribute("memberDto");
		if(memberDto != null){
			return "board/register";
		}else{
			log.info("로그인 안된 상태로 게시판 글쓰기 접근");
			ra.addFlashAttribute("noLogin", "로그인 후 이용해 주세요");
			return "redirect:/board/list";
		}

	}
	
	@PostMapping("/register")
	public String register(BoardDTO board, RedirectAttributes rttr ) {
		log.info("register : " + board);
		if(board.getAttachList() != null){
			board.getAttachList().forEach(attach->log.info("register Attach :" + attach));
		}
		service.register(board);
		rttr.addFlashAttribute("result", board.getBoardId()); //addFlashAttribute는 딱 한번 보여주고 사라진다.
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void list(Model model,  Criteria cri) {
		log.info("list");
		model.addAttribute("list", service.getListWithSearch(cri));
		model.addAttribute("count", service.getTotal(cri));
		log.info("count : >>>>>>>>>>" + service.getTotal(cri));
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("boardId") Long boardId, Model model) {
		log.info("/get");
		model.addAttribute("board", service.get(boardId));
		model.addAttribute("replyList", service.getReplyList(boardId));
	}

	@GetMapping( "/modify")
	public void modify(@RequestParam("boardId") Long boardId, Model model) {
		log.info("/modify");
		model.addAttribute("board", service.get(boardId));
		model.addAttribute("replyList", service.getReplyList(boardId));
	}
	
	@PostMapping("/modify")
	public String get(BoardDTO board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		if(board.getAttachList() != null){
			board.getAttachList().forEach(attach->log.info("Modify Attach : " + attach));
		}
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("boardId")Long boardId, RedirectAttributes rttr) {
		log.info("remove....postMapping 요청됨" + boardId);
		List<FilesDTO> attachList = service.getAttachList(boardId);
		if(service.remove(boardId)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	 @GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_VALUE)
	 @ResponseBody
	 public ResponseEntity<List<FilesDTO>> getAttachList(Long boardId){
		 log.info("getAttachList" + boardId);
		 return new ResponseEntity<>(service.getAttachList(boardId), HttpStatus.OK);
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 

	 private void deleteFiles(List<FilesDTO> attachList) {
		 if(attachList == null || attachList.size() == 0 ) {
			 return;
		 }
		 log.info("delete attach files...........");
		 log.info(attachList);
		 attachList.forEach(attach->{
			 try {
				 Path file = Paths.get("/Users/soyoonbeom/Spring_STS3_workspace/upload" + attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName());
				 Files.deleteIfExists(file);
				 if(Files.probeContentType(file).startsWith("image")) {
					 Path thumbNail = Paths.get("/Users/soyoonbeom/Spring_STS3_workspace/upload" + attach.getUploadPath()+"/s_"+ attach.getUuid()+"_" + attach.getFileName());
					 Files.delete(thumbNail);
				 }
			 }catch(Exception e) { log.error("delete file error : " + e.getMessage());}
		 });//forEach 
	}
		 
}
