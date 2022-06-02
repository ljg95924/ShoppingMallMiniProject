package com.bio11.mapper;

import java.util.List;

import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.OrderDetailDTOList;

public interface OrderMapper {
	public int orderOne(OrderDTO order);
	public List<OrderDetailDTO> getOrderList(int orderId);
	public OrderDTO getOrderOne(int orderId);

	void orderBasket(OrderDTO orderDto);

	int insertOrderDetail(OrderDetailDTO orderDetail);
}
