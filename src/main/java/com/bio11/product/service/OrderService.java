package com.bio11.product.service;

import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTOList;


public interface OrderService {
    public int orderOne(OrderDTO order);
    public OrderDTO getOrderOne(int orderId);
    int orderBasket(OrderDetailDTOList order,String userId);
}
