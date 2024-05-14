<%@page import="mpjt.common.PageDTO"%>
<%@page import="mpjt.dto.CommentDTO"%>
<%@page import="mpjt.dao.CommentDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<%
List<BoardDTO> boardLists = (List<BoardDTO>)request.getAttribute("boardLists");
PageDTO p = (PageDTO)request.getAttribute("paging");
%>
<<script type="text/javascript">
</script>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
<style>
    /* hover 시 밑줄 효과 */
    table a:hover {
        text-decoration: underline;
        color: #32CD32;
    }
</style>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<main id="container">
    <div class="row">
        <h2>Board List</h2>
        <Form name="searchForm" action="<%=request.getContextPath() %>/mbboard/bbs.bo" method="post">
            <table border="1" width="90%">
                <tr>
                    <td><select name="searchField">
                            <option value="fr_title">제목</option>
                            <option value="fr_cont">내용</option>
                    </select> <input type="text" name="searchWord"> <input
                        type="submit" value="Search"></td>
                </tr>
            </table>
        </form>
        <table border="1" width="90%">
       <tr><td colspan="5">&nbsp;<b>전체 : <%=p.getPageNum() %> /<%=p.getTotal() %></b></td></tr>
            <tr>
                <th width="5%">번호</th>
                <th width="5%">작성자</th>
                <th width="20%">제목</th>
                <th width="20%">내용</th>
                <th width="10%">조회수</th>
                <th width="10%">좋아요</th>
                <th width="30%">등록일</th>
                <th width="30%">파일첨부</th>
            </tr>
            <%
            if (boardLists.isEmpty()) {
            %>
            <tr>
                <td colspan="5">&nbsp;<b>Data Not Found!!</b></td>
            </tr>
            <%
            } else {
                // boardLists를 번호를 기준으로 오름차순으로 정렬
                Collections.sort(boardLists, new Comparator<BoardDTO>() {
                    @Override
                    public int compare(BoardDTO b1, BoardDTO b2) {
                        return Integer.compare(b1.getFr_idx(), b2.getFr_idx());
                    }
                });
            %>
            <%
            for (BoardDTO bbs : boardLists) {
            %>
      <tr align="center" onclick="redirectToView('<%=bbs.getFr_idx()%>', '<%=bbs.getUser_id()%>')" >

               <td width="10%"><%=bbs.getFr_idx()%></td>
               <td width="10%"><%=bbs.getUser_id()%></td>
               <td width="20%"><%=bbs.getFr_title()%></td>
               <td width="20%"><%=bbs.getFr_cont()%></td>
               <td width="10%"><%=bbs.getFr_visitnum()%></td>
               <td width="10%"><%=bbs.getFr_like()%></td>
               <td width="20%"><%=bbs.getFr_regd()%></td>
               <td width="20%"><%=bbs.getFr_file()%></td>
            </tr>
            <%
            }
            %>
            <%
            }
            %>
            <tr>
<td colspan="5">
<%if(p.isPrev()) {%><a href="bbs.bo?pageNum=<%=p.getStartPage()-1%>">[Prev]</a><%} %>
<%for(int i=p.getStartPage(); i<= p.getEndPage(); i++) {%>
	<%if(i == p.getPageNum()){%>
		<b>[<%=i %>]</b>
	<%}else{ %>
	<a href="bbs.bo?pageNum=<%=i%>">[<%=i %>]</a>
	<%} %>
<%} %>
<%if(p.isNext()){%><a href="bbs.bo?pageNum=<%=p.getEndPage()+1%>">[Next]</a><%} %>
</td>
</tr>
        </table>
	
        <a href="write.bo" class="btn btn-primary pull-right">글쓰기 </a>
    </div>
</main>


<script
    src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
    crossorigin="anonymous"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
    integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
    crossorigin="anonymous"></script>
    <script>
function redirectToView(id, userId) {
    // 현재 사용자 ID 가져오기
    var currentUser = '<%= (String) session.getAttribute("user_id") %>';
    
    if (userId !== currentUser) {
        alert("다른 사용자가 작성한 글을 클릭할 수 없습니다!");
        return false;
    }
    
    window.location.href = 'view.bo?num=' + id;
}
</script>
</body>
</html>