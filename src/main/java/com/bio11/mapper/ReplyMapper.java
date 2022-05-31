package com.bio11.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bio11.member.dto.ReplyDTO;

public interface ReplyMapper {

	public int insert(ReplyDTO reply);	
	public ReplyDTO read(Long replyId);
	public int delete(Long replyId);
	public int update(ReplyDTO reply);
	public List<ReplyDTO> getListByBno(@Param("boardId") Long boardId); //넘겨줄 데이터가 여러개일 경우 @Param을 사용해야한다.
	public void deleteByBno(Long boardId);
}
