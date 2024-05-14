<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="mpjt.dto.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // param


BoardDTO dto = (BoardDTO)request.getAttribute("dto");



String user_id=null;
if(session.getAttribute("user_id")!=null){
	user_id=(String)session.getAttribute("user_id");
}
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/view.jsp</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script>

// 댓글
function getComment() {
	const idx = <%= dto.getFr_idx() %>;
	const param = { idx:idx };
    $.ajax({
        type: 'GET',
        url:'<%=request.getContextPath()%>/board/commentList.co',
        dataType:'json',
        data:param,
        success: function(response) {
        	 console.log(response);
             makeHtml(response);    
        },
        error: function (request, status, error) {
            console.log(request, status,error);
        }
    });
}
function makeHtml(data){
	let html = ''; 
	
    for(u of data){            	
		html += '<tr>';
    	html += '<td>' + u['frc_idx'] + '</td>';
    	html += '<td>' + u['user_id'] + '</td>';
    	html += '<td>' + u['frc_cont'] + '</td>';
    	html += '<td>' + u['frc_like'] + '</td>';
    	html += '<td>' + u['frc_regd'] + '</td>';
    	html += '</tr>\n';         
    }
    console.log(html);
    $('#comments').html(html);
}

$(function(){
	getComment();
});

// 삭제
	function del(num){
		const input = confirm("정말 삭제 할까요?");
		if(input){
			location.href = "<%=request.getContextPath()%>/board/deleteProc.bo?num="+num;
		}else{
			alert('삭제를 취소 했습니다.');
			return;
		}
		
	}

function like() {
    const idx = <%= dto.getFr_idx() %>; // JSP 표현식으로 변수 출력
    const param = { idx: idx }; // JavaScript 객체 생성
    $.ajax({
        type: 'POST',
        url:'<%=request.getContextPath()%>/board/likeBoard.bo',
        data:param,
        success: function(response) {
        	  // 서버로부터 받은 좋아요 수를 dto 객체의 fr_like에 반영
                 $('#likeCount').text(response.likes);
        },
        error: function(xhr, status, error) {
            console.error(xhr);
            makeHtml(response);
        }
    });
}

function commentInsert() {
	const idx = <%= dto.getFr_idx() %>;
	const user_id = "<%= user_id %>";
	const cont = document.querySelector('#content').value;
    const param = { idx:idx, user_id:user_id, cont: cont }; // JavaScript 객체 생성
    $.ajax({
        type: 'POST',
        url:'<%=request.getContextPath()%>/board/commentInsert.co',
        data:param,
        success: function(response) {
        	console.log(response);
        	getComment();
        	makeHtml(data);
        	
        },
        error: function(xhr, status, error) {
            console.error(xhr);
        }
    });
}

</script>

</head>
<body>

<%-- <%@ include file="../user/main.jsp" %> --%>
<li><a href="bbs.bo">게시판으로</a></li>
<h2>글 상세보기 </h2>
<table border="1" width="90%">
	<tr>
	<td>글 번호</td><td><%=dto.getFr_idx() %></td>
	<td>작성자</td><td><%=dto.getUser_id() %></td>	
	</tr>
	<tr>
	<td>작성일자</td><td><%=dto.getFr_regd() %></td>
	<td>조회수</td><td><%=dto.getFr_visitnum() %></td>	
	<td>좋아요 수</td><td id="likeCount"><%=dto.getFr_like() %></td>
	</tr>
	<tr><td>제목</td><td colspan="3"><%=dto.getFr_title() %></td></tr>
	<tr><td>내용</td><td colspan="3"><%=dto.getFr_cont() %></td></tr>
	<tr><td colspan="4">
	<a href="bbs.bo">[List]</a> |  
<%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) {%>

	<a href="update.bo?num=<%=dto.getFr_idx()%>">[Update]</a> | 
	<a href="javascript:del('<%=dto.getFr_idx()%>');">[Delete]</a>
<%} %>
<%-- <button onclick=<% dao.like(dto);%>>좋아요</button> --%>
 <button id="likeButton" onclick="like()">좋아요</button>
 <input type="button" value="좋아요" onclick="like();">
	</td></tr>

	
</table>
<table border="1">
<thead>
<tr><th>글번호</th><th>작성자</th><th>내용</th><th>좋아요</th><th>날짜</th></tr>
</thead>
<tbody id="comments">

</tbody>
</table>
<main id="container">
	<h2>댓글 작성하기</h2>
<form action="<%=request.getContextPath() %>/commentInsert.co" method="post">
	내용: <input type="text" name="content" id="content">
	<input type="button" value="댓글" onclick="commentInsert();"><br>
</form>
</main>

</body>
</html>