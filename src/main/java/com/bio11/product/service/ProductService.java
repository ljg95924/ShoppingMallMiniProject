package com.bio11.product.service;

import com.bio11.product.dto.ProductDTO;

import java.util.List;



public interface ProductService {
	/*public boolean modify(ProductDTO product);*/
	public List<ProductDTO> getList();
	public List<ProductDTO> getList(String productType);

	public ProductDTO productDetail(int productId);
}
