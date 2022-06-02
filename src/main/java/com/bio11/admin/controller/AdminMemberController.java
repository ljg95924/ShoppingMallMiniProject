package com.bio11.admin.controller;

import com.bio11.member.dto.MemberDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bio11.admin.service.AdminMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Log4j
@RequestMapping("/admin/member/*")
@AllArgsConstructor
public class AdminMemberController {
	
	private AdminMemberService service;
	
	@GetMapping("/list")
	public String list(Model model
					    ,HttpServletRequest request
						,RedirectAttributes ra) {
		log.info("AdminController.list");
		HttpSession session = request.getSession();
		session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if(adminId == null) {
			log.info("session : adminId 없음!!");
			ra.addFlashAttribute("result", "잘못된 접근 입니다.");
			return "redirect:/product/list?productType=all";
		}else{
			log.info("session : adminId 존재!!");
			model.addAttribute("list", service.getMemberList());
			return "/admin/member/list";
		}

	}

	@GetMapping("/modify")
	public void modify(@RequestParam("userId") String userId, Model model) {
		log.info("AdminController.modify");
		model.addAttribute("member", service.findMember(userId));
	}

	@PostMapping("/modify")
	public String modify(MemberDTO member, RedirectAttributes rttr) {
		log.info("AdminMemberController.modify");
		if (service.updateMember(member) == 1) {
			log.info(member.getUserId() + "회원정보 수정 성공");
			rttr.addFlashAttribute("status",
					member.getUserId() + " 회원 정보가 수정되었습니다.");
		} else {
			log.warn("회원정보 수정 실패");
			rttr.addFlashAttribute("status",
					member.getUserId() + " 회원 정보 수정실패. 관리자 문의");
		}

		return "redirect:/admin/member/list";
	}

	@PostMapping("/remove")
	public String remove(MemberDTO member,  RedirectAttributes rttr) {
		log.info("AdminMemberController.remove");

		if (service.deleteMember(member) == 1) {
			log.info("회원정보 삭제 성공");
			rttr.addFlashAttribute("status",
					member.getUserId() + " 회원 정보가 삭제되었습니다.");
		} else {
			log.warn("회원정보 삭제 실패");
			rttr.addFlashAttribute("status",
					member.getUserId() + " 회원 정보가 삭제실패. 관리자 문의");
		}

		return "redirect:/admin/member/list";
	}

}
