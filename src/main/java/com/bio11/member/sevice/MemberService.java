package com.bio11.member.sevice;


import com.bio11.member.dto.MemberDTO;

public interface MemberService {
	public Boolean register(MemberDTO memberDto);
	public MemberDTO get(String userId);
	public boolean modify(MemberDTO memberDto);
	public boolean remove(String userId);
	public MemberDTO login(String userId, String userPwd);
	public String getUserIdByEmail(String userEmail);
	
}
