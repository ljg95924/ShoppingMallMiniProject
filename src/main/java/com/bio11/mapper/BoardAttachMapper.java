package com.bio11.mapper;

import java.util.List;

import com.bio11.member.dto.FilesDTO;


public interface BoardAttachMapper {
	public void insert(FilesDTO dto);
	public List<FilesDTO> findByBno(Long boardId);
	public void deleteAll(Long boardId);
	public List<FilesDTO> getOldFiles();
}
