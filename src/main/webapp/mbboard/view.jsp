<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
BoardDTO dto = new BoardDTO();
dto.set(num);
%>    
<% // db - select
BoardDAO dao = new BoardDAO();

//1. visitcount update
dao.updateVisitcount(dto); // 5초

//2. view content
dto = dao.selectView(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/view.jsp</title>
<script>
	function del(num){
		const input = confirm("정말 삭제 할까요?");
		if(input){
			location.href = "<%=request.getContextPath()%>/board/DeleteProc?num="+num;
		}else{
			alert('삭제를 취소 했습니다.');
			return;
		}
		
	}
</script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<h2>글 상세보기 </h2>
<table border="1" width="90%">
	<tr>
	<td>Num</td><td><%=dto.getNum() %></td>
	<td>ID(Name)</td><td><%=dto.getId()%>(<%=dto.getName() %>)</td>	
	</tr>
	<tr>
	<td>PostDate</td><td><%=dto.getPostdate() %></td>
	<td>Visitcount</td><td><%=dto.getVisitcount() %></td>	
	</tr>
	<tr><td>Title</td><td colspan="3"><%=dto.getTitle() %></td></tr>
	<tr><td>Content</td><td colspan="3"><%=dto.getContent() %></td></tr>
	<tr><td colspan="4">
	<a href="list.jsp">[List]</a> |  
<%if(session.getAttribute("id") != null && session.getAttribute("id").equals(dto.getId())) {%>
	<a href="update.jsp?num=<%=num%>">[Update]</a> | 
	<a href="javascript:del('<%=num%>');">[Delete]</a>
<%} %>
	</td></tr>
	
</table>


</body>
</html>