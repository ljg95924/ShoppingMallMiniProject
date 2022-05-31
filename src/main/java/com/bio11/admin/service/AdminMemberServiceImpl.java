package com.bio11.admin.service;

import java.util.List;


import com.bio11.member.dto.MemberDTO;
import org.springframework.stereotype.Service;

import com.bio11.mapper.AdminMemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService {
	
	private AdminMemberMapper mapper;

	@Override
	public List<MemberDTO> getMemberList() {
		log.info("AdminMemberServiceImpl.getMemberList");
		return mapper.findAll();
	}

	@Override
	public MemberDTO findMember(String userId) {
		log.info("AdminMemberServiceImpl.findMember");
		return mapper.findByUserId(userId);
	}

	@Override
	public int updateMember(MemberDTO member) {
		log.info("AdminMemberServiceImpl.updateMember");
		return mapper.updateMember(member);
	}

	@Override
	public int deleteMember(MemberDTO member) {
		log.info("AdminMemberServiceImpl.deleteMember");
		return mapper.deleteMember(member);
	}

}
