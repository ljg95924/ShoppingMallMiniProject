package com.bio11.member.controller;

import java.util.List;

import com.bio11.member.sevice.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bio11.member.dto.ReplyDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	
	@PostMapping(value="/new",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyDTO reply){
		log.info("ReplyVO : "+ reply);
		int insertCount = service.register(reply);
		log.info("Reply INSERT COUNT :  "+ insertCount);
		return insertCount == 1?
			new ResponseEntity<>("success", HttpStatus.OK):
			new  ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value= "/pages/{boardId}/{page}",
			produces=
			{MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<ReplyDTO>> getList(
			@PathVariable("page")int page, //게시글 번호로 조회한다는 더미 
			@PathVariable("boardId")Long boardId){
		log.info("getList...");
		return new ResponseEntity<> (service.getListByBno(boardId),HttpStatus.OK);
			};
			
	@GetMapping(value= "/{replyId}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyDTO> get(@PathVariable("replyId")Long replyId){
		log.info("get: " + replyId);
		return new ResponseEntity<>(service.get(replyId), HttpStatus.OK);
		}
	
	@DeleteMapping(value= "/{replyId}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("replyId") Long replyId){
		log.info("remove : " + replyId );
		return service.remove(replyId) == 1 ?
		new ResponseEntity<>("success", HttpStatus.OK):
		new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value= "/{replyId}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyDTO reply, @PathVariable("replyId")Long replyId){
		reply.setReplyId(replyId);
		log.info("replyId : " + replyId);
		log.info("modify : " + reply);
		return service.modify(reply) == 1?
				new ResponseEntity<>("success", HttpStatus.OK):
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
			
	
}
