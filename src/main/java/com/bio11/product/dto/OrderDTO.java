package com.bio11.product.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private int orderId;
	private String userId;
	private String orderName;
	private Date orderTime; 
}
