package com.bio11.mapper;

import com.bio11.member.dto.MemberDTO;

import java.util.List;

public interface AdminMemberMapper {

	public List<MemberDTO> findAll();

    MemberDTO findByUserId(String userId);

    int updateMember(MemberDTO member);

    int deleteMember(MemberDTO member);
}
