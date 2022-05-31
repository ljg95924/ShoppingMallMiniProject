package com.bio11.mapper;



import com.bio11.product.dto.ProductDTO;

import java.util.List;

public interface AdminProductMapper {

	public List<ProductDTO> findAll();

    ProductDTO findByProductId(int productId);

    int insertProduct(ProductDTO product);

    int updateProduct(ProductDTO product);

}
