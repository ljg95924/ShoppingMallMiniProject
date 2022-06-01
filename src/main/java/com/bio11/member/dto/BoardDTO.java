package com.bio11.member.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {
//	private Long bno;
//	private String title;
//	private String content;
//	private String userId;
//	private Date regDate;
//	private Date updateDate;
//	private List<BoardAttachDTO> attachList;
	private Long boardId;
	private String boardTitle;
	private String boardContent;
	private String userId;
	private Date boardRegDate;
	private Date boardUpdateDate;
	private List<FilesDTO> attachList;
}
