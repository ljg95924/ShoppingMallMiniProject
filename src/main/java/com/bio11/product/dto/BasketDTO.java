package com.bio11.product.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class BasketDTO {
	private int cartId;
	private String userId;
	private int productId;
	private int productQuantity;
	
	private String productName;
	private int productPrice;
	private int totalPrice;

	private String productImg;
	private MultipartFile file;
	
}
