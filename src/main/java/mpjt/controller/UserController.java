package mpjt.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import mpjt.common.PageDTO;
import mpjt.dao.UserDAO;
import mpjt.dto.UserDTO;

@WebServlet("*.do")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/// join.jsp? login.jsp? joinProc?
		System.out.println("doProcess");
		request.setCharacterEncoding("utf-8"); // 한글처리

		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri);
//		if(action.equals("/join.do")) {
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			String path = request.getContextPath() + "/user/join.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/main.do")) { // main.jsp
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			String path = request.getContextPath() + "/user/main.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/login.do")) { // main.jsp
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			String path = request.getContextPath() + "/user/login.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/delete.do")) { // main.jsp
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			String path = request.getContextPath() + "/user/delete.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/deleteAjax.do")) { // main.jsp
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			String path = request.getContextPath() + "/user/deleteAjax.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/logout.do")) { // main.jsp
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//			HttpSession session = request.getSession();
//			session.invalidate();
//			String path = request.getContextPath() + "/user/main.jsp";
//			response.sendRedirect(path);
//		}else if(action.equals("/userList.do")) { // main.jsp
//			
//			// service : dao
//			UserDAO dao = new UserDAO();
//			List<UserDTO> userList =  dao.getUsers();
//
//			request.setAttribute("userList", userList);
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//
//			String path =  "./userList.jsp"; // 1
//			//String path =  "./user/userList.jsp"; // 2
//			//			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
//			//			dispatcher.forward(request, response);
//			request.getRequestDispatcher(path).forward(request, response);
//
//			//response.sendRedirect(path);userList.do
//
//		}else if(action.equals("/userListPage.do")) { // main.jsp
//			
//			// paging info
//			int amount = 10;
//			int pageNum = 1;
//			
//			String sPageNum = request.getParameter("pageNum");
//			if(sPageNum != null) pageNum = Integer.parseInt(sPageNum);
//
//			// service : dao
//			UserDAO dao = new UserDAO();
//			int offset = (pageNum-1) * amount;
//			List<UserDTO> userList =  dao.getUsers(amount, offset);
//			
//			// totalcount
//			int totalCount = dao.getUsers().size();
//			
//			// Paging
//			PageDTO paging = new PageDTO(pageNum, amount, totalCount);			
//			
//			request.setAttribute("userList", userList);
//			request.setAttribute("paging", paging);
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//
//			String path =  "./userListPage.jsp"; // 1
//			request.getRequestDispatcher(path).forward(request, response);
//
//
//		}
//		else if(action.equals("/joinProc.do")) { // main.jsp
//
//			// 1. 값을 받음
//			request.setCharacterEncoding("utf-8");
//			String id = request.getParameter("id");
//			String password = request.getParameter("password");
//			String name = request.getParameter("name");
//			String role = request.getParameter("role");
//
//			// 2. 받은 값 찍어보기
//			//System.out.printf("%s,%s,%s,%s",id,password,name,role);
//
//			// 3. db 처리
//			UserDAO dao = new UserDAO();
//			UserDTO dto = new UserDTO(id, password, name, role);
//			dao.insertUser(dto);
//
//			// 4. move
//			String path = request.getContextPath() +"/user/login.do";
//			response.sendRedirect(path);
//
//
//		}else if(action.equals("/loginProc.do")) { // 
//
//			// 1. 값을 받고 찍어 본다. 꼭~~
//			request.setCharacterEncoding("utf-8"); // 한글 처리
//			String id = request.getParameter("id");
//			String password = request.getParameter("password");
//
//			int idx = 0;
//			String name="";
//			String role="";
//			boolean isLogin = false;
//
//			// 2. DB 처리를 한다.
//			UserDAO dao = new UserDAO();
//			UserDTO dto = new UserDTO();
//			dto.setId(id);
//			dto = dao.getUser(dto);
//			if(dto != null) {
//				if(password.equals(dto.getPassword())) {
//					isLogin = true;
//				}
//			}		
//
//			String jspFile = "";
//			if (isLogin){ // 꼭 써야하는거 
//
//				HttpSession session =  request.getSession();
//				session.setAttribute("idx", dto.getIdx());
//				session.setAttribute("id", id);
//				session.setAttribute("name", dto.getName());
//				session.setAttribute("role", dto.getRole());
//				jspFile = "main.do";
//			}else {
//				jspFile = "login.do";
//			}
//
//			// 3. move
//			String path = request.getContextPath() +"/user/" + jspFile;
//			response.sendRedirect(path);
//		}else if(action.equals("/update.do")) { // dto -> update.jsp
//
//			// 값 - dto - id 값
//			HttpSession session = request.getSession();
//			String id = (String)session.getAttribute("id");
//
//			UserDTO dto = new UserDTO();
//			dto.setId(id);
//
//			// service : dao
//			UserDAO dao = new UserDAO();
//			UserDTO user =  dao.getUser(dto);
//
//			request.setAttribute("user", user);
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//
//			String path =  "./update.jsp"; // 1
//			request.getRequestDispatcher(path).forward(request, response);
//
//			//response.sendRedirect(path);userList.do
//		}else if(action.equals("/updateProc.do")) { // main.jsp
//
//			// 1. 값고 찍어본다 받는다. 꼭 !! 
//
//			HttpSession session = request.getSession();
//
//			request.setCharacterEncoding("utf-8"); // 한글 처리
//			String id = (String)session.getAttribute("id");
//			String password = request.getParameter("password");
//			String name = request.getParameter("name");
//			String role = request.getParameter("role");
//
//			// 2. DB 처리를 한다.
//			UserDAO dao = new UserDAO();
//			UserDTO dto = new UserDTO(id, password, name, role);
//			int rs = dao.update(dto);
//
//			session.setAttribute("name",name);
//
//			// 4. move ? get-> .do  / forward -> jsp
//
//			String path = request.getContextPath() +"/user/update.do";
//			response.sendRedirect(path);
//		}else if(action.equals("/deleteProc.do")) { // main.jsp
//			// 1. 값고 찍어본다 받는다. 꼭 !! 
//
//			HttpSession session = request.getSession();
//
//			request.setCharacterEncoding("utf-8"); // 한글 처리
//			String id = (String)session.getAttribute("id");
//			String password = request.getParameter("password");
//			int rs = 0;
//			boolean isCheck = false;
//			
//			// 2. DB 처리를 한다.			
//			UserDAO dao = new UserDAO();
//			UserDTO dto = new UserDTO();
//			dto.setId(id);
//			dto = dao.getUser(dto);
//			
//			if(dto != null) {
//				// pass 확인
//				if(password.equals(dto.getPassword())) {
//					rs = dao.delete(dto);
//					isCheck = true;
//				}
//			}
//			
//			// 4. move ? get-> .do  / forward -> jsp	
//			String path = "";
//			if(isCheck) {
//				session.invalidate();
//				path = request.getContextPath() +"/user/main.do";
//			}else {
//				path = request.getContextPath() +"/user/delete.do";				
//			}
//			
//			response.sendRedirect(path);
//		}else if(action.equals("/updateAjax.do")) { // dto -> update.jsp
//
//			// 값 - dto - id 값
//			HttpSession session = request.getSession();
//			String id = (String)session.getAttribute("id");
//
//			UserDTO dto = new UserDTO();
//			dto.setId(id);
//
//			// service : dao
//			UserDAO dao = new UserDAO();
//			UserDTO user =  dao.getUser(dto);
//
//			request.setAttribute("user", user);
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//
//			String path =  "./updateAjax.jsp"; // 1
//			request.getRequestDispatcher(path).forward(request, response);
//
//			//response.sendRedirect(path);userList.do
//		}else if(action.equals("/userListJstl.do")) { // main.jsp
//
//			// service : dao
//			UserDAO dao = new UserDAO();
//			List<UserDTO> userList =  dao.getUsers();
//
//			request.setAttribute("userList", userList);
//			// move. get, 2. forward - reqeust.setAttribute("v","o")
//
//			String path =  "./userListJstl.jsp"; // 1
//			request.getRequestDispatcher(path).forward(request, response);
//		}
	}

}

