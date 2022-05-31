package com.bio11.member.sevice;

import java.util.List;

import com.bio11.mapper.ReplyMapper;
import org.springframework.stereotype.Service;

import com.bio11.member.dto.ReplyDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor //생성자에 의한 주입
public class ReplyServiceImpl implements ReplyService{
	
	private ReplyMapper mapper;

	@Override
	public int register(ReplyDTO reply) {
		log.info("register..." + reply);
		return mapper.insert(reply);
	}

	@Override
	public ReplyDTO get(Long replyId) {
		log.info("get..." + replyId);
		return mapper.read(replyId);
	}

	@Override
	public int modify(ReplyDTO reply) {
		log.info("modify..." + reply);
		return mapper.update(reply);
	}

	@Override
	public int remove(Long replyId) {
		log.info("remove..." + replyId);
		return mapper.delete(replyId);
	}

	@Override
	public List<ReplyDTO> getListByBno(Long boardId) {
		log.info("get Reply List of a Board..." + boardId);
		return mapper.getListByBno(boardId);
	}

}
