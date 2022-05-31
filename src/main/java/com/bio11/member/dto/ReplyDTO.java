package com.bio11.member.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	
//	private Long rno;
//	private Long bno;
//	private String reply;
//	private String replyer;
//	private Date replyDate;
//	private Date updateDate;
	private Long replyId;
	private Long boardId;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date replyUpdateDate;
	
}
