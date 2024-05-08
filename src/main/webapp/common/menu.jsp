<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>
<ul>
<li>
<a href="<%=request.getContextPath()%>">Index</a> |
<% if(session.getAttribute("idx") == null) {%>
<a href="../userdao/join.jsp">Join</a> | 
<a href="../userdao/login.jsp">Login</a> 
<%}else{ %>
<%=session.getAttribute("id") %>(<%=session.getAttribute("name") %>) |
<a href="../userdao/update.jsp">Update(내정보수정)</a> | 
<a href="../userdao/delete.jsp">Delete(회원탈퇴)</a> |
<a href="../userdao/logout.jsp">LogOut</a> 
<%} %>
</li>
<li><a href="../userdao/userList.jsp">User List(Model1)</a></li>
<li><a href="../userdao/userListAjax.jsp">User List(Ajax)</a></li>
<li><a href="../board/list.jsp">Board List</a></li>
</ul>
</h3>