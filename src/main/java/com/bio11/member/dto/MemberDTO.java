package com.bio11.member.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {
	private String userId;
	private String userPwd;
	private String userName;
	private String userAddress;
	private String userBirth;
	private String userGender;
	private String userEmail;
	private String userPhone;
	private Date userRegdate;	
}
