package com.bio11.mapper;

import com.bio11.product.dto.ProductDTO;

import java.util.List;



public interface ProductMapper {
	//@Select("select * from tbl_board where bno > 0")
	public List<ProductDTO> getList();
	public int update(ProductDTO product);
	public ProductDTO read(int productId);
}
