<%@page import="mpjt.dao.UserDAO"%>
<%@page import="mpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// idcheck
String id = request.getParameter("user_id"); // user_id 값을 가져옴
UserDTO dto = new UserDTO();
dto.setUser_id(id); // 가져온 user_id 값을 UserDTO 객체에 설정

// id db
UserDAO dao = new UserDAO();
dto = dao.getUser(dto);

int rs = 0;
// 기존 회원이 없으면 0, 회원이 있으면 1 반환
if(dto != null){
    rs = 1;    
}
%>
{"rs":"<%=rs %>"}