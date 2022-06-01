package com.bio11.product.service;

import com.bio11.mapper.OrderMapper;
import com.bio11.product.dto.OrderDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService{
    private OrderMapper mapper;
    @Override
    public int orderOne(OrderDTO order) {
        log.info("orderOne...");
        return mapper.orderOne(order);
    }

    @Override
    public OrderDTO getOrderOne(int orderId) {
        log.info("getOrder..");
        return mapper.getOrderOne(orderId);
    }


}
