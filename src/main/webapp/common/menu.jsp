<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = null;
	if (session.getAttribute("user_id") != null) {
		user_id = (String) session.getAttribute("user_id");
	}
	%>
	<div id="wrap">
		<header id="header">
			<div class="inner">
				<h1 class="logo">
					<a href="<%=request.getContextPath()%>/user/main.jsp"> <span
						class="blind">뭐먹을끼니?</span>
					</a>
				</h1>
				<nav class="gnb_wrap">
					<ul class="gnb">
						<li><a href="../mbboard/bbs.bo">자유게시판</a></li>
						<li><a href="../mbboard/bbs.bo">맛집게시판</a></li>
						<li><a href="../mbboard/qna.jsp">QnA</a></li>
					</ul>
					<div class="login_area">
						<ul class="login_wrap">
							<%
							if (user_id == null) {
							%>
							<li><a href="../user/login.jsp">로그인</a></li>
							<li><a href="../user/join.jsp">회원가입</a>
							</li>
								<%
								} else {
								%>
							<li><a href="<%=request.getContextPath()%>/user/userSetting.jsp">회원관리</a></li>
							<li><a href="../user/logout.jsp">로그아웃</a></li>
							<%
							}
							%>
						</ul>
					</div>
				</nav>
			</div>
		</header>
	</div>