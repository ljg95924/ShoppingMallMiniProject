package com.bio11.product.service;

import com.bio11.product.dto.OrderDTO;

public interface OrderService {
    public int orderOne(OrderDTO order);
    public OrderDTO getOrderOne(int orderId);
}
