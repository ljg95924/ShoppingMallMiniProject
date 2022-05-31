package com.bio11.admin.service;

import com.bio11.member.dto.MemberDTO;

import java.util.List;

public interface AdminMemberService {
	
	public List<MemberDTO> getMemberList();

	public MemberDTO findMember(String userId);

	public int updateMember(MemberDTO member);

	public int deleteMember(MemberDTO member);
}
