<%@page import="mpjt.dao.UserDAO"%>
<%@page import="mpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
for(int i=10; i<133; i++){
	String user_id = "hong"+i;
	String user_password = "1111";
	String user_name = "홍길동"+i;
	String user_gen = "남자";
	String user_role = "user";
	
	UserDTO dto = new UserDTO(user_id, user_password, user_name, user_gen);
	UserDAO dao = new UserDAO();
	dao.join(dto);
}
%>
End!!