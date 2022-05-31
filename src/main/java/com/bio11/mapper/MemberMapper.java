package com.bio11.mapper;


import com.bio11.member.dto.MemberDTO;


public interface MemberMapper {
	
	public void insert(MemberDTO memberDto);
	
	public void insertSelectKey(MemberDTO memberDto);

	public MemberDTO read(String userId);
	
	public int update(MemberDTO memberDto);
	
	public int delete(String userId);
	
	public String getUserIdByEmail(String email);

	//public List<MemberDTO>getList();
}
