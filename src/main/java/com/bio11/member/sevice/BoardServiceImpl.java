package com.bio11.member.sevice;



import java.util.List;

import com.bio11.mapper.BoardAttachMapper;
import com.bio11.mapper.BoardMapper;
import com.bio11.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bio11.member.dto.FilesDTO;
import com.bio11.member.dto.BoardDTO;
import com.bio11.member.dto.Criteria;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor //생성자에 의한 주입
public class BoardServiceImpl implements BoardService{
	
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;
	private ReplyMapper replyMapper;
	
	@Transactional //처리가 필요 ->2가지 insert가 묶음으로 이루어지기 위해서 사용, 시스템상 오류로 1개만 insert 되는 경우를 방지 
	@Override
	public void register(BoardDTO board) {
		log.info("register..." + board.getBoardId());
		mapper.insertSelectKey(board);
		if(board.getAttachList()== null || board.getAttachList().size()<=0) {
			return;
		}
		
		log.info("board.getBno()"+board.getBoardId());
		
		board.getAttachList().forEach(attach->{
			attach.setBoardId(board.getBoardId());
			attachMapper.insert(attach);
		});
	}

	//조회
	@Override
	public BoardDTO get(Long boardId) {
		log.info("get..." + boardId);
		return mapper.read(boardId);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardDTO board) {
		log.info("modify..." + board);
	
		//bno 따른 첨부파일 테이블 
		if(board.getAttachList()== null || board.getAttachList().size()<=0) {
			//bno에 따른 첨부파일 테이블을 모두 지운다
			attachMapper.deleteAll(board.getBoardId());
			return mapper.update(board) == 1;	//bno에 따른 보드 수정
		}else {
			//bno에 따른 첨부파일 테이블을 모두 지운다
			attachMapper.deleteAll(board.getBoardId());
			//새롭게 등록한다.
			board.getAttachList().forEach(attach->{
				attach.setBoardId(board.getBoardId());
				attachMapper.insert(attach);
			});
			return mapper.update(board) == 1;	//bno에 따른 보드 수정
		}


	}
	
	//삭제
	@Transactional
	@Override
	public boolean remove(Long boardId) {
		log.info("remove..." + boardId);
		attachMapper.deleteAll(boardId);
		replyMapper.deleteByBno(boardId);
		return mapper.delete(boardId) == 1;
	}

	@Override
	public List<BoardDTO> getListWithSearch(Criteria cri) {
		log.info("getListWithSearch.....");
		return mapper.getListWithSearch(cri);
	}
	
	public List<BoardDTO> getList() {
		log.info("getList.....");
		return mapper.getList();
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<FilesDTO> getAttachList(Long boardId) {
		log.info("get Attach list by bno" + boardId);
		return attachMapper.findByBno(boardId);
	}
	
}
