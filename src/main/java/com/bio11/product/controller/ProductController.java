package com.bio11.product.controller;

import com.bio11.product.dto.ProductDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.bio11.product.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@Controller
@Log4j
@RequestMapping("/product/*")
@AllArgsConstructor
public class ProductController {
	@Autowired
	private ProductService service;
	
	/*@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}*/
	// list?productType=all
	@GetMapping("/list")
	public void list(String productType, Model model) {
		log.info("listProductType: " + productType);
		if(productType.equals("all")){
			model.addAttribute("list", service.getList());
		}else{
			model.addAttribute("list", service.getList(productType));

		}
	}
	
	@PostMapping("/modify")
	public String get(ProductDTO product, RedirectAttributes rttr) {
		log.info("modify: " + product);
		if(service.modify(product)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
	@GetMapping("/productDetail")
	public void productDetail(@RequestParam("productId") int productId, Model model) {
		log.info("productDetail: " + productId);
		model.addAttribute("product",service.productDetail(productId));
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

}
