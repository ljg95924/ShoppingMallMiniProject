package com.bio11.product.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDetailDTO {

	private int orderDetailId;
	private int orderId;//
	private int productId;//
	private String productName;//
	private int productQuantity;//
	private int productPrice;//

	private String userId;

	private Date orderTime;

	private int cartId;

}
