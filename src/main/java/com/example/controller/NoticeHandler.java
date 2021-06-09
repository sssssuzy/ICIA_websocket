package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.persistence.NoticeDAO;

public class NoticeHandler extends TextWebSocketHandler {
	
	@Autowired
	NoticeDAO dao;
	
	List<WebSocketSession> sessionList = new ArrayList<>();
	Map<String,String> sessionUser = new HashMap<>();
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);		
		System.out.println("연결이 끊김" + session);
		super.afterConnectionClosed(session, status);
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);		
		
		Map<String,Object>httpSession = session.getAttributes();
		String userId = (String) httpSession.get("id");
		sessionUser.put(session.getId(), userId);	
		
		System.out.println("sessionId:"+session.getId() + "\t" + "userId:" + userId);
		
		super.afterConnectionEstablished(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage = message.getPayload(); //매니저가 보낸 메세지
		System.out.println("Message:" + strMessage);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String strDate=sdf.format(new Date());
		
		for(WebSocketSession web:sessionList){ //세션리스트(지금접속자)
			String userId = sessionUser.get(web.getId());
			int count = dao.unReadCnt(userId);
			String newMessage = userId + "|" + strMessage + "|" + count + "|" + strDate;
			System.out.println("....................." + newMessage);
			web.sendMessage(new TextMessage(newMessage));
		}
		super.handleTextMessage(session, message);
	}

}
