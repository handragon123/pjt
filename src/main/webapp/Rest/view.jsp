<%@page import="mpjt.dao.RestDAO"%>
<%@page import="mpjt.dto.RestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
RestDTO dto = new RestDTO();

dto.setRs_idx(num);
%>    
<% // db - select
RestDAO dao = new RestDAO();

//1. update visitnum
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
			location.href = "<%=request.getContextPath()%>/Rest/DeleteController?num="+num;
		}else{
			alert('삭제를 취소 했습니다.');
			return;
		}
		
	}
	
	 function like(num) {
	      const input = confirm("좋아하십니까?");
	      if(input) {
	         location.href = "<%=request.getContextPath()%>/Rest/likeUpdateController?num="+num;
	      }else {
	         alert("좋아요를 취소 했습니다.");
	         return;
	            }
	   }
</script>
</head>
<body>

<li><a href="restmain.jsp">게시판으로</a></li>
<h2>글 상세보기 </h2>
<table border="1" width="90%">
	<tr>
	<td>작성자</td><td><%=dto.getUser_id() %></td>	
	<td>리뷰</td><td><%=dto.getRs_reviews() %></td>	
	</tr>
	<tr>
	<td>작성일자</td><td><%=dto.getRs_regd() %></td>
	<td>글 번호</td><td><%=dto.getRs_idx() %></td>
	</tr>
	<tr>
	<td>제목</td><td><%=dto.getRs_name() %></td>
	<td>좋아요</td><td><%=dto.getRs_like() %></td>
	</tr>
	<tr><td>주소</td><td colspan="3"><%=dto.getRs_addr() %></td></tr>
	<tr><td>전화번호</td><td colspan="3"><%=dto.getRs_tell() %></td></tr>
	<tr><td colspan="4">
	<a href="restmain.jsp">[List]</a> |  
<%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) {%>

	<a href="update.jsp?num=<%=num%>">[Update]</a> | 
	<a href="javascript:like('<%=num%>');">[Like]</a>
	<a href="javascript:del('<%=num%>');">[Delete]</a>

<%} %>
	</td></tr>
	
</table>


</body>
</html>