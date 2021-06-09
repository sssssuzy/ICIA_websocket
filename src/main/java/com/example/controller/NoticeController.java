package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.NoticeVO;
import com.example.persistence.NoticeDAO;

@Controller
public class NoticeController {
	@Autowired
	NoticeDAO dao;
	
	@RequestMapping("list.json")
	@ResponseBody
	public List<NoticeVO> list(String uid){
		dao.readDateUpdate(uid);
		return dao.list();
	}
	
	@RequestMapping("insert")
	@ResponseBody
	public void insert(NoticeVO vo){
		dao.insert(vo);
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public void delete(int nid){
		dao.delete(nid);
	}
	
	@RequestMapping("readDateUpdate")
	@ResponseBody
	public void readDateUpdate(String uid){
		dao.readDateUpdate(uid);
	}
}
