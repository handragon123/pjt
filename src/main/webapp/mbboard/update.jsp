<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/sessionCheck.jsp"%>
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
BoardDTO dto = new BoardDTO();

dto.setFr_idx(num);

%>    
<% // db - select
BoardDAO dao = new BoardDAO();

// view content
dto = dao.selectView(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/update.jsp</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css?v=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css?v=<%=System.currentTimeMillis()%>" />
<script type="text/javascript">
function validateForm() {
    const form = document.writeForm;
    console.dir(form); // input
    if(form.title.value === ""){
        alert('title 필수값 입니다.');
        form.title.focus();
        return;
    }
    if(form.content.value === ""){
        alert('content 필수값 입니다.');
        form.content.focus();
        return;
    }
    
    form.submit();
}
</script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<main id="container">
<section class="update">
<div class="inner">

<div class="update_wrap">
    <h2>게시글 수정하기</h2>
    <form name="writeForm" action="<%=request.getContextPath() %>/board/UpdateProc.bo?num=<%= dto.getFr_idx() %>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="num" value="<%=num%>">
        <table>
            <tr>
                <td>게시글 번호</td>
                <td><%=dto.getFr_idx() %></td>
                <td>작성자 ID</td>
                <td><%=dto.getUser_id() %></td>    
            </tr>
            <tr>
                <td>작성한 일자</td>
                <td><%=dto.getFr_regd() %></td>
                <td>조회수</td>
                <td><%=dto.getFr_visitnum() %></td>    
            </tr>
            <tr>
                <td>제목</td>
                <td colspan="3">
                    <input type="text" name="title" value="<%=dto.getFr_title() %>" class="form-control">
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3">
                    <textarea name="content" class="form-control"><%=dto.getFr_cont() %></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="action-buttons">
                    <a href="bbs.bo" class="btn btn-secondary">목록보기</a> |  
                    <a href="view.bo?num=<%=num%>" class="btn btn-secondary">게시글로 이동</a> |        
                <% if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) { %>
                    <a href="javascript:validateForm();" class="btn btn-primary">수정하기</a> 
                <% } %>
                </td>
            </tr>        
        </table>
    </form>
</div>
</div>
</section>
</main>
</body>
</html>