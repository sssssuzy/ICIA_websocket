package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class NoticeVO {
	private int nid;
	private String content;	
	@JsonFormat(pattern="yyyy-MM-dd hh:mm:ss", timezone="Asia/Seoul")
	private Date writeDate;

	public int getNid() {
		return nid;
	}

	public void setNid(int nid) {
		this.nid = nid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	@Override
	public String toString() {
		return "NoticeVO [nid=" + nid + ", content=" + content + ", writeDate=" + writeDate + "]";
	}
		
	
}
