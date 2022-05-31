package com.bio11.member.sevice;

import java.util.List;

import com.bio11.member.dto.ReplyDTO;

public interface ReplyService {
	public int register(ReplyDTO reply);
	public ReplyDTO get(Long replyId);
	public int modify(ReplyDTO reply);
	public int remove(Long replyId);
	public List<ReplyDTO> getListByBno(Long boardId);
}
