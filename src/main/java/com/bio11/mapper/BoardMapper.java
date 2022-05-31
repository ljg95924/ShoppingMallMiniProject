package com.bio11.mapper;

import java.util.List;

import com.bio11.member.dto.BoardDTO;
import com.bio11.member.dto.Criteria;



public interface BoardMapper {
//	@Select("SELECT * FROM tbl_board where bno > 0")
	public List<BoardDTO>getListWithSearch(Criteria cir);
	
	public List<BoardDTO>getList();
	
	public void insert(BoardDTO board);
	
	public void insertSelectKey(BoardDTO board);

	public BoardDTO read(long boardId);
	
	public int update(BoardDTO board);
	
	public int delete(long boardId);
	
	public int getTotalCount(Criteria cir);
}
