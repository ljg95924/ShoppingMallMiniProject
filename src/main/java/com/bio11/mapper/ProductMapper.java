package com.bio11.mapper;

import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.ProductDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;



public interface ProductMapper {
	//@Select("select * from tbl_board where bno > 0")
	public List<ProductDTO> getList();
	public List<ProductDTO> getListType(String productType);
	public int update(ProductDTO product);
	public ProductDTO read(int productId);
	int updateQuantity(@Param("productStock") int productStock, @Param("productId") int productId);

}
