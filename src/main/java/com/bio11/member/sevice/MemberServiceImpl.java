package com.bio11.member.sevice;

import com.bio11.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.bio11.member.dto.MemberDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor //생성자에 의한 주입
public class MemberServiceImpl implements MemberService{

		private MemberMapper memberMapper;


		@Override
		public Boolean register(MemberDTO memberDto) {
			log.info("memberDto.getUser_id() : " + memberDto.getUserId());
			MemberDTO member = memberMapper.read(memberDto.getUserId());
			log.info("member");
			if(member == null) {
				memberMapper.insert(memberDto);
				return true;
			}else {
				log.info("id 중복 ");
				return false;
			}
		}

		@Override
		public MemberDTO get(String userId) {
			MemberDTO memberDto = memberMapper.read(userId);
			return memberDto;
		}

		@Override
		public boolean modify(MemberDTO memberDto) {

			return memberMapper.update(memberDto) == 1 ;
		}

		@Override
		public boolean remove(String userId) {

			return memberMapper.delete(userId) == 1 ;
		}

		@Override
		public MemberDTO login(String userId, String userPwd) {
			MemberDTO memberDto = this.get(userId);
			log.info("MemberServiceImpl_memberDto: "+ memberDto);
			if(memberDto == null) {
				//없는 아이디
				return null;
			}else {
				//비밀번호 검증
				if(memberDto.getUserPwd().equals(userPwd)){
					//로그인 성공
					return memberDto;
				}else {
					//비밀번호 불일치
					return null;
				}
			}
		}

		@Override
		public String getUserIdByEmail(String userEmail) {

			String userId = memberMapper.getUserIdByEmail(userEmail);
			if(userId !=  null) {
				return userId;
			}else {
				return null;
			}
		}

}
