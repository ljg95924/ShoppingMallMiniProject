package com.bio11.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bio11.member.sevice.EmailService;
import com.bio11.member.sevice.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bio11.member.dto.MemberDTO;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
@AllArgsConstructor
public class MemberController {
	private MemberService memberService;
	private EmailService emailService;
	
	//Redirect처리
	//로그인 화면 요청처리
	@GetMapping("/login")
	public String login() {
		System.out.println("/login : GET요청 발생!");
		return "member/login-form";
	}
	
	//로그인 검증처리
	@PostMapping("/login")
	public String login(@RequestParam("userId") String id
						, @RequestParam("userPwd") String pw
						, RedirectAttributes ra
						, HttpServletRequest request
						, HttpServletResponse response) {
		
		//로그 확인
		log.info("/login : POST요청 발생!");
		log.info("ID: " + id);
		log.info("PW: " + pw);
		
		//입력하지 않은 경우 리턴
		if(id.equals("")) {
			ra.addFlashAttribute("result", "아이디는 필수값이에요!");
			return "redirect:/member/login";
		} 
		if(pw.equals("")) {
			ra.addFlashAttribute("result", "비밀번호는 필수값이에요!");
			return "redirect:/member/login";
		} 
		
		MemberDTO memberDto = memberService.login(id, pw);
		
		//관리자가 로그인한 경우
		if(id.equals("admin")) {
			if(pw.equals(memberDto.getUserPwd())) {
				HttpSession  session = request.getSession();
				session = request.getSession();
				session.setAttribute("isLogOn", true);
				session.setAttribute("adminId", memberDto.getUserId());
				ra.addFlashAttribute("result","관리자 로그인 성공!");
				return "admin/member/list"; //관리자 메인페이지
			};
		};
		
		//회원이 로그인한 경우
		if(memberDto != null) {
			HttpSession  session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberDto", memberDto);
			ra.addFlashAttribute("result","회원 로그인 성공!");
			return "redirect:/member/myPage"; //메인 페이지
		}else {
			ra.addFlashAttribute("result", "로그인 정보가 맞지 않습니다!");
			return "redirect:/member/login";
		}

	}

	
	//회원가입 화면 요청처리
	@GetMapping("/join")
	public String joinForm() {
		log.info("/join GetMapping 발생 ");
		return "/member/join-form";
	}
	
	//회원가입 데이터 등록 처리
	@PostMapping("/join")
	public String joinForm(MemberDTO memberDto,
							@RequestParam("year") String year,
							@RequestParam("month") String month,
							@RequestParam("day") String day,
							RedirectAttributes ra) {
		log.info("/join PostMapping 발생 ");
		memberDto.setUserBirth(year+month+day);
		log.info("memberDto : " + memberDto);
		boolean check = memberService.register(memberDto);
		if(check) {
			ra.addFlashAttribute("result", "회원가입 성공");
			return "redirect:/member/login";
		}else {
			ra.addFlashAttribute("result", "회원가입 실패 : 중복아이디 입니다.");
			return "redirect:/member/join";
		}
	}

	//회원정보수정 화면 요청
	@GetMapping("/update")
	public String memberUpdateForm(HttpServletRequest request,
									Model model) {
		log.info("/update GetMapping 발생 ");
		HttpSession  session = request.getSession();
		MemberDTO memberDto = (MemberDTO)session.getAttribute("memberDto");
		log.info("MemberController_memberUpdateForm_memberDto : " + memberDto);
		String year = memberDto.getUserBirth().substring(0,4);
		String month = memberDto.getUserBirth().substring(4,6);
		String day = memberDto.getUserBirth().substring(6,8);
		
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("day",day);
		model.addAttribute("memberDto", memberDto);
		
		return "/member/update-form";
	}

	//회원정보 데이터 수정 처리
	@PostMapping("/update")
	public String memberUpdateForm(MemberDTO memberDto,
							@RequestParam("year") String year,
							@RequestParam("month") String month,
							@RequestParam("day") String day,
							HttpServletRequest request,
							RedirectAttributes ra) {
		log.info("/update PostMapping 발생 ");
		memberDto.setUserBirth(year+month+day);
		log.info("Update_memberDto : " + memberDto);
		boolean check = memberService.modify(memberDto);
		if(check) {
			ra.addFlashAttribute("result", "회원수정 성공 : 다시 로그인해주세요.");
			HttpSession  session = request.getSession();
			session.invalidate();	
			return "redirect:/member/login";
		}else {
			ra.addFlashAttribute("result", "회원수정 실패 : 다시 입력해주세요.");
			return "redirect:/member/update";
		}
	}
	
	@GetMapping("/delete")
	public String deleteForm(HttpServletRequest request,
							RedirectAttributes ra) {
		log.info("/delete GetMapping 발생 ");
		//세션 삭제
		HttpSession session = request.getSession();
		MemberDTO memberDto = (MemberDTO)session.getAttribute("memberDto");
		
		if(memberService.remove(memberDto.getUserId())) {			
			session.invalidate();
			ra.addFlashAttribute("result", "회원 정보가 삭제 되었습니다.");
			return "redirect:/member/login";
		}else {
			ra.addFlashAttribute("result", "회원삭제 실패 : 다시 입력해주세요.");
			return "redirect:/member/myPage";
		}
	}
	
	//회원정보수정 화면 요청
	@GetMapping("/myPage")
	public String myPageForm(HttpServletRequest request,
									Model model) {
		log.info("/myPage GetMapping 발생 ");
		HttpSession  session = request.getSession();
		MemberDTO memberDto = (MemberDTO)session.getAttribute("memberDto");
		model.addAttribute("memberDto", memberDto);
		
		return "/member/myPage-form";
	}
	
	
	
	//id찾기 화면 요청처리
	@GetMapping("/findId")
	public String idForm() {
		log.info("/findId GetMapping 발생 ");
		return "/member/findId-form";
	}
	
	//email에 따른 id 반환처리 
	@PostMapping("/findId")
	public String idForm(@RequestParam("userEmail") String email,
										RedirectAttributes ra) {
		String userId = memberService.getUserIdByEmail(email);
		if(userId != null) {
			ra.addFlashAttribute("result", "Id는 " + userId + "입니다.");
			return "redirect:/member/login";
		}else {
			
			ra.addFlashAttribute("result", "해당 Email에 존재하는 ID가 없습니다.");
			return "redirect:/member/findId";
		}
	}
	
	//pw찾기 화면 요청처리
	@GetMapping("/findPw")
	public String pwForm() {
		log.info("/findId GetMapping 발생 ");
		return "/member/findPw-form";
	}
	
	//email 및 id에 따른 pw 검증 및 이메일 반환처리 
	@PostMapping("/findPw")
	public String pwForm(@RequestParam("userId") String id,
						@RequestParam("userEmail") String email,
										RedirectAttributes ra) {
		MemberDTO memberDto = memberService.get(id);
		if(memberDto != null && memberDto.getUserEmail().equals(email)) {
			
			emailService.sendMail(memberDto.getUserPwd(), email);
			ra.addFlashAttribute("result", "입력하신 email로 비밀번호가 전송되었습니다.");
			return "redirect:/member/login";
		}else {
			ra.addFlashAttribute("result", "PassWord 조회 실패");
			return "redirect:/member/findPw";
			
		}
	}
	
	

	
	
	
	
}
