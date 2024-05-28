<%@page import="mpjt.dto.UserDTO"%>
<%@page import="mpjt.dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); 
UserDAO dao = new UserDAO();

// 아이디 검색 기능 
String searchId = request.getParameter("searchId");
List<UserDTO> userList;
if (searchId != null && !searchId.trim().isEmpty()) {
   // 검색할 아이디 dao에서 실행 후 userList에 대입, trim는 공백을 없애줌
    userList = dao.searchUsersById(searchId.trim());
} else {
    userList = dao.getUsers();
}

// 현재 로그인한 사용자 ID 가져오기
String loggedInUserId = (String) session.getAttribute("user_id");
UserDTO loggedInUser = null;
List<UserDTO> otherUsers = new ArrayList<>();

// 로그인한 사용자와 나머지 사용자 분리
for (UserDTO dto : userList) {
    if (loggedInUserId != null && loggedInUserId.equals(dto.getUser_id())) {
        loggedInUser = dto;
    } else {
        otherUsers.add(dto);
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User List</title>
<link rel="icon" href="../resources/images/favicon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css?v=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css?v=<%=System.currentTimeMillis()%>" />
</head>
<body>
   <%@ include file="../common/menu.jsp"%>
   <main id="container">
      <div class="user_list">
         <h2>회원 리스트</h2>
         <!-- 검색 폼 추가 name = searchId와 16번라인의 getParameter와 연결되어 있는 것임-->
         <form class="search-form"
            action="<%= request.getContextPath() %>/user/list.jsp" method="get">
            <input class="search-input" type="text" name="searchId"
               placeholder="ID 검색" value="<%= searchId != null ? searchId : "" %>">
            <button class="search-button" type="submit">검색</button>
         </form>
         <hr>
         <div class="board_list_wrap">
            <table>
               <thead>
                  <tr>
                     <th class="col1">IDX</th>
                     <th>ID</th>
                     <th>Role</th>
                     <th>Password</th>
                     <th>Name</th>
                     <th>Gender</th>
                     <th>Registration Date</th>
                     <th>Last Updated</th>
                     <th>Change role</th>
                  </tr>
               </thead>
               <tbody>
                  <!-- 현재 로그인한 관리자(사용자)를 우선 표시해줌  -->
                  <% if (loggedInUser != null) { %>
                  <tr>
                     <td><%= loggedInUser.getUser_idx() %></td>
                     <td><%= loggedInUser.getUser_id() %> <span style="font-weight: bold; color: green;"> [현재 로그인]</span></td>
                     <td><%= loggedInUser.getUser_role() %></td>
                     <td><%= loggedInUser.getUser_password() %></td>
                     <td><%= loggedInUser.getUser_name() %></td>
                     <td><%= loggedInUser.getUser_gen() %></td>
                     <td><%= loggedInUser.getUser_regd() %></td>
                     <td><%= loggedInUser.getUser_upd() %></td>
                     <td>
                        <form action="<%=request.getContextPath()%>/updateRole.do" method="post">
                           <input type="hidden" name="user_id" value="<%= loggedInUser.getUser_id() %>"> <select name="new_role">
                              <option value="일반 사용자"
                                 <%= loggedInUser.getUser_role().equals("일반 사용자") ? "selected" : "" %>>일반
                                 사용자</option>
                              <option value="관리자"
                                 <%= loggedInUser.getUser_role().equals("관리자") ? "selected" : "" %>>관리자</option>
                           </select>
                           <button type="submit">변경</button>
                        </form> <% String errorMessage = (String) request.getAttribute("errorMessage");
                   if (errorMessage != null) { %>
                        <div class="error-message">
                           <%= errorMessage %>
                        </div> <% } %>
                     </td>
                  </tr>
                  <% } %>
                  <!-- 나머지 유저 전부 표시 -->
                  <% for(UserDTO dto : otherUsers) { %>
                  <tr>
                     <td><%= dto.getUser_idx() %></td>
                     <td><%= dto.getUser_id() %></td>
                     <td><%= dto.getUser_role() %></td>
                     <td><%= dto.getUser_password() %></td>
                     <td><%= dto.getUser_name() %></td>
                     <td><%= dto.getUser_gen() %></td>
                     <td><%= dto.getUser_regd() %></td>
                     <td><%= dto.getUser_upd() %></td>
                     <td>
                        <form action="<%=request.getContextPath()%>/updateRole.do" method="post">
                           <input type="hidden" name="user_id" value="<%= dto.getUser_id() %>"> <select name="new_role">
                              <option value="일반 사용자"
                                 <%= dto.getUser_role().equals("일반 사용자") ? "selected" : "" %>>일반
                                 사용자</option>
                              <option value="관리자"
                                 <%= dto.getUser_role().equals("관리자") ? "selected" : "" %>>관리자</option>
                           </select>
                           <button type="submit">변경</button>
                        </form> <% String errorMessage = (String) request.getAttribute("errorMessage");
                   if (errorMessage != null) { %>
                        <div class="error-message">
                           <%= errorMessage %>
                        </div> <% } %>
                     </td>
                  </tr>
                  <% } %>
               </tbody>
            </table>
         </div>
      </div>
   </main>
</body>
</html>