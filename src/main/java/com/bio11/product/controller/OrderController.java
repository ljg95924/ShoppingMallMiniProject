package com.bio11.product.controller;

import com.bio11.member.dto.MemberDTO;
import com.bio11.member.sevice.MemberService;
import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.ProductDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bio11.product.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	@Autowired
	private OrderService orderService;
//	@PostMapping ("orderOne")
//	@ResponseBody
//	public String orderOne(OrderDTO order, HttpServletRequest request, RedirectAttributes rttr, Model model){
//		HttpSession session = request.getSession();
//		MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
//		order.setUserId(member.getUserId());
//		order.setOrderName(member.getUserName());
//
//		int result = orderService.orderOne(order);
//		log.info("result : " + result);
//		if(result == 1){
//			rttr.addAttribute("order", order.toString());
//			log.info("오니?");
//			model.addAttribute("order", order);
//			log.info("오니?????");
//			log.info("Controller - orderOne Result: " + order);
//			return "redirect:/order/orderResult";
//		}else{
//			log.info("Controller--sss---");
//			model.addAttribute("order","fail");
//			return "/product/productDetail";
//		}
//
//	}


	@PostMapping (value = "orderOne",  produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<OrderDTO> orderOne(OrderDTO order, HttpServletRequest request){
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
		order.setUserId(member.getUserId());
		order.setOrderName(member.getUserName());

		int result = orderService.orderOne(order);
		log.info("result : " + result);
		if(result == 1){
//			rttr.addAttribute("order", order.toString());
			log.info("오니?");
//			model.addAttribute("order", order);
			log.info("오니?????");
			log.info("Controller - orderOne Result: " + order);
			return new ResponseEntity<>(order, HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.NO_CONTENT);

	}

	@PostMapping("/orderResult")
	public String get(ProductDTO product, RedirectAttributes rttr) {
		return "tewst";
	}


}
