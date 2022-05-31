package com.bio11.admin.controller;

import com.bio11.config.RootConfig;
import com.bio11.config.ServletConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //WebApplicationContext를 이용하기 위함
@ContextConfiguration(classes={RootConfig.class, ServletConfig.class})
@Log4j
public class AdminProductControllerTest {

    @Autowired
    private WebApplicationContext ctx;

    private MockMvc mockMvc;

    @Before  //모든 테스트 전에 매번 실행
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void 상품리스트_조회() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders.get("/admin/product/list"))
                .andReturn().getModelAndView().getModelMap());
    }

    @Test
    public void 상품등록() throws Exception {

        String[] fileNames = {
                "desimone_apple.png",
                "desimone_baby.png",
                "desimone_blueberry.png",
                "desimone_capsule.png",
                "desimone_dualstick.png",
                "desimone_strawberry.png",
                "desimone4500.png"
        };

        MockMultipartFile image = null;
        int tmp = 0;
        int num = 0;

        for (String fileName : fileNames) {
            num += 1;
            image = new MockMultipartFile("file", fileName, "image/png", getImgByte(fileName));
            mockMvc.perform(MockMvcRequestBuilders.multipart("/admin/product/register")
                    .file(image)
                    .param("productName", "상품명0" + num)
                    .param("productType", "카테고리0" + num)
                    .param("productPrice", "10000")
                    .param("productStock", "10"));
        }



//        MockMultipartFile image = new MockMultipartFile("file", "desimone_baby.png", "image/png", getImgByte(sample));

//        String resultPage = mockMvc.perform(MockMvcRequestBuilders.multipart("/admin/product/register")
//                        .file(image)
//                        .param("productName", "상품명01")
//                        .param("productType", "카테고리01")
//                        .param("productPrice", "10000")
//                        .param("productStock", "10"))
//                .andReturn().getModelAndView().getViewName();
//        log.info(resultPage);

    }

    @Test
    public void testRegister() {
    }

    @Test
    public void detail() {
    }

    @Test
    public void modify() {
    }

    @Test
    public void getFile() {
    }

    public byte[] getImgByte(String fileName) {
       String filePath = "/Users/seotaesu/Desimone/img/";
//        String filePath = "/Users/bit/Desimone/img/";
        byte[] byteFile = null;

        try {
            byteFile = Files.readAllBytes(new File(filePath + fileName).toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return byteFile;
    }
}