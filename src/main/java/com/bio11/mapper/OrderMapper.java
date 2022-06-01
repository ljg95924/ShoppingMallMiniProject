package com.bio11.mapper;

import java.util.List;

import com.bio11.product.dto.OrderDTO;

public interface OrderMapper {
	public int orderOne(OrderDTO order);
	public List<OrderDTO> getOrderList(String memberId);
	public OrderDTO getOrderOne(int orderId);

}
