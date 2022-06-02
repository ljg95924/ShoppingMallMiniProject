package com.bio11.admin.controller;


import com.bio11.admin.service.AdminProductService;
import com.bio11.product.dto.ProductDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;

@Controller
@Log4j
@RequestMapping("/admin/product/*")
@AllArgsConstructor
public class AdminProductController {

    private AdminProductService service;

    @GetMapping("/list")
    public String list(Model model, HttpServletRequest request
            , RedirectAttributes ra) {
        log.info("AdminProductController.list");

		HttpSession session = request.getSession();
		session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");

		if(adminId == null) {
			log.info("session : adminId 없음!!");
			ra.addFlashAttribute("result", "잘못된 접근 입니다.");
			return "redirect:/product/list?productType=all";
		}else{
			model.addAttribute("list", service.getProductList());
			log.info("session : adminId 존재!!");
			return "list";
		}

    }

    @GetMapping("/register")
    public void register() {
    }

    @PostMapping("/register")
    public String register(ProductDTO product, RedirectAttributes rttr) {
        log.info("AdminProductController.register");

        log.info(product);
        MultipartFile uploadFile = product.getFile();

        String uploadFolder = "/Users/seotaesu/Desimone/FileUpload/";
        File uploadPath = new File(uploadFolder);
        log.info("upload Path: " + uploadPath);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        String uploadFileName = uploadFile.getOriginalFilename();
        log.info("uploadFileName: " + uploadFileName);

        product.setProductImg(uploadFileName);

        File saveFile = new File(uploadPath, uploadFileName);
        try {
            uploadFile.transferTo(saveFile);
            if (checkImageType(saveFile)) {
                FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
                Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 70, 70);
                thumbnail.close();
            }
        } catch (IOException e) {
            log.error(e.getMessage());
            rttr.addFlashAttribute("status",
                    product.getProductId() + " 상품 등록 실패. 관리자 문의");
        }

        if (service.registerProduct(product) == 1) {
            rttr.addFlashAttribute("status",
                    product.getProductId() + " 상품 등록 성공");
        } else {
            rttr.addFlashAttribute("status",
                    product.getProductId() + " 상품 등록 실패. 관리자 문의");
        }


        return "redirect:/admin/product/list";
    }

    @GetMapping("detail")
    public void detail(@RequestParam("productId") int productId, Model model) {
        log.info("AdminProductController.detail");
        model.addAttribute("product", service.findProduct(productId));
    }

    @PostMapping("/modify")
    public String modify(ProductDTO product, RedirectAttributes rttr) {
        log.info("AdminProductController.modify");
        log.info(product);

        if (service.modifyProduct(product) == 1) {
            rttr.addFlashAttribute("status",
                    product.getProductId() + " 상품 수정 성공");
        } else {
            rttr.addFlashAttribute("status",
                    product.getProductId() + " 상품 수정 실패");
        }

        return "redirect:/admin/product/list";
    }

    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) {
        log.info("fileName: " + fileName);
        File file = new File("/Users/seotaesu/Desimone/FileUpload/" + fileName);
        log.info("file : " + file);

        ResponseEntity<byte[]> result = null;
        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            log.error(e.getMessage());
        }

        return result;
    }

    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

}
