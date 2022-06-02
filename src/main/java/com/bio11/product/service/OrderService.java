package com.bio11.product.service;

import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.OrderDetailDTOList;

import java.util.List;


public interface OrderService {
    public int orderOne(OrderDTO order);
    public OrderDTO getOrderOne(int orderId);
    int orderBasket(OrderDetailDTOList order,String userId);

    List<OrderDetailDTO> getOrderList(int orderId);
}
