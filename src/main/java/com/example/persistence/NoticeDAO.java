package com.example.persistence;

import java.util.List;

import com.example.domain.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> list();
	public void insert(NoticeVO vo);
	public void delete(int nid);
	public int unReadCnt(String uid);
	public void readDateUpdate(String uid);
}
