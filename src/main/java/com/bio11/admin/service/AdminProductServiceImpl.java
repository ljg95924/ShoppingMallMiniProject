package com.bio11.admin.service;

import com.bio11.mapper.AdminProductMapper;
import com.bio11.product.dto.ProductDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class AdminProductServiceImpl implements AdminProductService {

    private AdminProductMapper mapper;

    @Override
    public List<ProductDTO> getProductList() {
        log.info("AdminProductServiceImpl.getProductList");
        return mapper.findAll();
    }

    @Override
    public ProductDTO findProduct(int productId) {
        log.info("AdminProductServiceImpl.findProduct");
        return mapper.findByProductId(productId);
    }

    @Override
    public int registerProduct(ProductDTO product) {
        log.info("AdminProductServiceImpl.registerProduct");
        return mapper.insertProduct(product);
    }

    @Override
    public int modifyProduct(ProductDTO product) {
        log.info("AdminProductServiceImpl.modifyProduct");
        return mapper.updateProduct(product);
    }
}
