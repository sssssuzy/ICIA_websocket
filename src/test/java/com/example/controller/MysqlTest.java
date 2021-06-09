package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.domain.NoticeVO;
import com.example.mapper.MysqlMapper;
import com.example.persistence.NoticeDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})

public class MysqlTest {
	 @Autowired
	 private NoticeDAO dao;
	 
	 @Test
	 public void insert() { 
		 NoticeVO vo = new NoticeVO();
		 vo.setContent("공지합니다~");
		 dao.insert(vo);
	 }
	 @Test
	 public void list() { 
		 dao.list();
	 }
	}
