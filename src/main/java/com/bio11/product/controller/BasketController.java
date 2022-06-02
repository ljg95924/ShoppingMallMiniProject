package com.bio11.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.bio11.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bio11.product.dto.BasketDTO;
import com.bio11.product.service.BasketService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/basket/*")
@AllArgsConstructor
public class BasketController {
	@Autowired
	private BasketService service;
	
	@PostMapping("addBasket")
	@ResponseBody
	public String addBasket(BasketDTO basket, HttpServletRequest request) {
		
		log.info("Controller Basket : " + basket);
		HttpSession session = request.getSession();
		// 로그인 체크
		MemberDTO member = (MemberDTO)session.getAttribute("memberDto"); if(member == null) {
			return "5";}

		// 카트 등록
		int result = service.addBasket(basket);
		
		return result + "";
	}
	@GetMapping("/getBasketList/{userId}")
	public String getBasketList(@PathVariable("userId") String userId, Model model) {
		log.info("getBasketList: "+userId);
		List<BasketDTO> basketList = service.getBasketList(userId);
		model.addAttribute("totalPrice",addProductPrice(basketList));
		model.addAttribute("basketInfo",basketList);
		return "basket/getBasketList";
	}
	@PostMapping("/update")
	public String updateBasket(BasketDTO basket){
		log.info("updateBasket: " + basket);
		service.modifyCount(basket);
		return "redirect:/basket/getBasketList/"+basket.getUserId();
	}

	@PostMapping("/delete")
	public String deleteBasket(BasketDTO basket, HttpServletRequest request){
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
		basket.setUserId(member.getUserId());
		log.info("deleteBasket: " + basket);
		service.deleteBasket(basket.getCartId());
		return "redirect:/basket/getBasketList/"+basket.getUserId();
	}

	public int addProductPrice(List<BasketDTO> basketList) {
		int totalPrice = 0;
		for (BasketDTO basket : basketList) {
			totalPrice += basket.getProductPrice() * basket.getProductQuantity();
		}
		return totalPrice;
	}
}
