package com.bio11.member.sevice;


import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	private String from = "ybum1224@naver.com";//보내는사람
	private String subject = "비밀번호 찾기 결과"; //메일제목(생략가능)
	
	
	public void sendMail(String userPwd, String userEmail) {
		try {
			log.info("userPwd: " + userPwd);
			log.info("userEmail : " + userEmail);
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setTo(userEmail);
			messageHelper.setText("비밀번호는 <"+ userPwd +"> 입니다");
			messageHelper.setFrom(from);
			messageHelper.setSubject(subject); //메일 제목은 생략 가능 
			
			log.info("message : " + message);
			
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
}
}
