package com.bio11.product.controller;

import com.bio11.member.dto.MemberDTO;
import com.bio11.member.sevice.MemberService;
import com.bio11.product.dto.OrderDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bio11.product.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private MemberService memberService;
	@PostMapping ("orderOne")
	public String orderOne(OrderDTO order, HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
		order.setUserId(member.getUserId());
		order.setOrderName(member.getUserName());

		log.info("Controller - orderOne: " + order);
		int result = orderService.orderOne(order);
		if(result == 1){
			model.addAttribute("order", order);
		}else{
			model.addAttribute("order","fail");
		}
		return "order/orderResult";
	}
}
