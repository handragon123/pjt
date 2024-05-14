<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
for(int i=10; i<133; i++){
	String user_id = "hong"+i;
	String Fr_title = "1111";
	String Fr_cont = "홍길동"+i;
	int Fr_visitcount = 0;
	int Fr_like = 0;
	
	BoardDTO dto = new BoardDTO(user_id, Fr_title, Fr_cont, Fr_visitcount, Fr_like);
	BoardDAO dao = new BoardDAO();
	dao.insertWrite(dto);
}
%>
End!!