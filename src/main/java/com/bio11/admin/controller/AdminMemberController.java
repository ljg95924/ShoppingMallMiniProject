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

@Controller
@Log4j
@RequestMapping("/admin/member/*")
@AllArgsConstructor
public class AdminMemberController {
	
	private AdminMemberService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("AdminController.list");
		model.addAttribute("list", service.getMemberList());
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
