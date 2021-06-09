package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO{
	
	String namespace="com.example.mapper.NoticeMapper";
	@Autowired
	SqlSession session;

	@Override
	public List<NoticeVO> list() {
		return session.selectList(namespace+".list");
	}

	@Override
	public void insert(NoticeVO vo) {
		session.insert(namespace+".insert",vo);
		
	}

	@Override
	public void delete(int nid) {
		session.delete(namespace+".delete",nid);
		
	}

	@Override
	public int unReadCnt(String uid) {
		return session.selectOne(namespace+".unReadCnt",uid);
	}

	@Override
	public void readDateUpdate(String uid) {
		session.update(namespace+".readDateUpdate", uid);
		
	}

}
