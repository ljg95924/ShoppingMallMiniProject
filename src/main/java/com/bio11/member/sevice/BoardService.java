package com.bio11.member.sevice;

import java.util.List;

import com.bio11.member.dto.FilesDTO;
import com.bio11.member.dto.BoardDTO;
import com.bio11.member.dto.Criteria;
import com.bio11.member.dto.ReplyDTO;


public interface BoardService {
	public void register(BoardDTO boadrd);
	public BoardDTO get(Long boardId);
	public boolean modify(BoardDTO board);
	public boolean remove(Long boardId);
	public List<BoardDTO> getListWithSearch(Criteria cri);
	public List<BoardDTO> getList();
	public int getTotal(Criteria cri);
	public List<FilesDTO> getAttachList(Long boardId);

	public List<ReplyDTO> getReplyList(Long boardId);
}
