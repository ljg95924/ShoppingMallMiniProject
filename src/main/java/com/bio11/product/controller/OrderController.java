package com.bio11.product.controller;

import com.bio11.member.dto.MemberDTO;
import com.bio11.product.dto.BasketDTO;
import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.OrderDetailDTOList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.bio11.product.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
    @Autowired
    private OrderService orderService;

    @PostMapping(value = "orderOne", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Integer> orderOne(OrderDTO order, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
        order.setUserId(member.getUserId());
        order.setOrderName(member.getUserName());
        int result = orderService.orderOne(order);
        log.info("result : " + result);
        if (result == 1) {
            log.info("Controller - orderOne Result: " + order);
            return new ResponseEntity<>(order.getOrderId(), HttpStatus.OK);
        }

        return new ResponseEntity<>(HttpStatus.NOT_FOUND);

    }

    @GetMapping("/orderResult")
    public void orderResult(@RequestParam("orderId") String orderId, Model model) {
        log.info("OrderController.get");
        log.info("orderId : " + orderId);
        List<OrderDetailDTO> orderList = orderService.getOrderList((Integer.parseInt(orderId)));
        model.addAttribute("totalPrice", addProductPrice(orderList));
        model.addAttribute("order", orderService.getOrderOne(Integer.parseInt(orderId)));
        model.addAttribute("orderList", orderList);
    }

    @PostMapping("/orderBasket")
    public String orderBasket(OrderDetailDTOList list, Model model, HttpServletRequest request) {
        log.info("orderBasket: " + list);
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("memberDto");
        int result = orderService.orderBasket(list, member.getUserId());
        log.info("orderBasket result: " + result);

        if (result != 1) {
            model.addAttribute("result", "상품 주문 fail");
            return "redirect:/getBasketList/" + member.getUserId();
        }
        return "redirect:/order/orderResult?orderId=" + list.getList().get(0).getOrderId();
    }

    public int addProductPrice(List<OrderDetailDTO> orderList) {
        int totalPrice = 0;
        for (OrderDetailDTO orderDetailDTO : orderList) {
            totalPrice += orderDetailDTO.getOrderProductQuantity() * orderDetailDTO.getOrderProductPrice();
        }
        return totalPrice;
    }


}
