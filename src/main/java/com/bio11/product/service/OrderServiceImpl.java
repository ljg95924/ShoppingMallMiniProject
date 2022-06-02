package com.bio11.product.service;

import com.bio11.mapper.OrderMapper;
import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.OrderDetailDTOList;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
        public int orderBasket(OrderDetailDTOList order, String userId) {
        log.info("orderBasket..");
        int result = 0;
        OrderDTO orderDto= new OrderDTO();
        orderDto.setUserId(userId);
        mapper.orderBasket(orderDto);
        int orderId = orderDto.getOrderId();
        System.out.println("orderId!!!" + orderId);
        for (OrderDetailDTO orderDetail: order.getList()
             ) {
            orderDetail.setOrderId(orderId);
            result = mapper.insertOrderDetail(orderDetail);
            if(result != 1) return result;
        }
        return result;
    }

    @Override
    public List<OrderDetailDTO> getOrderList(int orderId) {
        log.info("????????????+"+mapper.getOrderList(orderId));
        return mapper.getOrderList(orderId);
    }


}
