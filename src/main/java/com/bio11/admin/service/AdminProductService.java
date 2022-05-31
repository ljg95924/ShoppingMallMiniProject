package com.bio11.admin.service;



import com.bio11.product.dto.ProductDTO;

import java.util.List;

public interface AdminProductService {
	
	public List<ProductDTO> getProductList();

	public ProductDTO findProduct(int productId);

	public int registerProduct(ProductDTO product);

	public int modifyProduct(ProductDTO product);
}
