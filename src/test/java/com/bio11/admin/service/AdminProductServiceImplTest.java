package com.bio11.admin.service;

import com.bio11.config.RootConfig;
import com.bio11.product.dto.ProductDTO;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;



import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class AdminProductServiceImplTest {

    @Autowired
    private AdminProductService service;

    @Test
    public void 상품리스트() {
        service.getProductList().forEach(product -> log.info(product));
    }

    @Test
    public void 상품조회() {
        log.info(service.findProduct(1));
    }

    @Test
    public void 상품등록() {
//        service.registerProduct();
    }

    @Test
    public void 상품수정() {
        ProductDTO modifyProduct = new ProductDTO();
        modifyProduct.setProductId(1);
        modifyProduct.setProductName("테스트코드_이름");
        modifyProduct.setProductType("테스트코드_타입");
        modifyProduct.setProductPrice(9999);
        modifyProduct.setProductStock(8888);

        ProductDTO product = service.findProduct(1);
        int result = service.modifyProduct(modifyProduct);

        assertEquals(result, 1);

    }
}