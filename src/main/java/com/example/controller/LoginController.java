package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.persistence.NoticeDAO;

@Controller
public class LoginController {
	@Autowired
	NoticeDAO dao;
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String id, HttpServletRequest request, Model model) {
		System.out.println("Welcome " + id);
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		model.addAttribute("count", dao.unReadCnt(id));
		return "notice";
	}
}
