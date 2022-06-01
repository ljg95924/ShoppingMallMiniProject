package com.bio11.product.service;

import java.util.List;

import com.bio11.product.dto.ProductDTO;
import org.springframework.stereotype.Service;

import com.bio11.mapper.ProductMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService{
//	@Setter(onMethod_= @Autowired)
	private ProductMapper mapper;

	@Override
	public List<ProductDTO> getList() {
		// TODO Auto-generated method stub
		log.info("getList....");
		return mapper.getList();
	}

	@Override
	public List<ProductDTO> getList(String productType) {
		log.info("getList....");
		return mapper.getListType(productType);
	}

	@Override
	public boolean modify(ProductDTO product) {
		// TODO Auto-generated method stub
		log.info("modify..."+product);
		return mapper.update(product)==1;
	}

	@Override
	public ProductDTO productDetail(int productId) {
		// TODO Auto-generated method stub
		log.info("productDetail..." + productId);
		return mapper.read(productId);
	}
	
}
