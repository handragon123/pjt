
<%@page import="mpjt.dto.RestDTO"%>
<%@page import="mpjt.dao.RestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/sessionCheck.jsp"%>      
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
RestDTO dto = new RestDTO();

dto.setRs_idx(num);

%>    
<% // db - select
RestDAO dao = new RestDAO();

// view content
dto = dao.selectView(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/update.jsp</title>
<script type="text/javascript">
function validateForm() {
	const form = document.writeForm;
	console.dir(form); // input
	if(form.name.value === ""){
		alert('title 필수값 입니다.');
		form.name.focus();
		return;
	}
	if(form.addr.value === ""){
		alert('content 필수값 입니다.');
		form.addr.focus();
		return;
	}
	
	form.submit();
}
</script>
</head>
<body>
<h2>글 수정하기 </h2>
<form name="writeForm" 
	action="<%=request.getContextPath() %>/Rest/UpdateController" 
	method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<table border="1" width="90%">
		<tr>

		<td>글번호</td><td><%=dto.getRs_idx() %></td>
		<td>작성자</td><td><%=dto.getUser_id() %></td>	
		</tr>
		<tr>
		<td>작성일자</td><td><%=dto.getRs_regd() %></td>
		<td>리뷰</td><td><%=dto.getRs_reviews() %></td>	
		</tr>
		<tr><td>전화번호</td><td colspan="3">
		<input type="text" name="tell" value="<%=dto.getRs_tell() %>" style="width:90%">
		</td></tr>
		<tr><td>위치</td><td colspan="3">
		<textarea name="addr" style="width:90%; height:100px"><%=dto.getRs_addr() %></textarea>
		</td></tr>
		<tr><td colspan="4">
		<a href="restmain.jsp">[List]</a> |  
		<a href="view.jsp?num=<%=num%>">[View]</a> |		
	<%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) {%>
		<a href="javascript:validateForm();">[Update]</a> 
	<%} %>
		</td></tr>		
	</table>
</form>

</body>
</html>