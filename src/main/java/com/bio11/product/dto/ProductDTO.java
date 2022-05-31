package com.bio11.product.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
public class ProductDTO {
	private int productId;
	private String productName;
	private String productType;
	private int productStock;
	private int productPrice;
	private String productImg;
	private MultipartFile file;
}
