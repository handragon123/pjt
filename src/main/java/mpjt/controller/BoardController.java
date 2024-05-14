package mpjt.controller;

import java.io.IOException;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mpjt.common.JDBCConnect;
import mpjt.common.PageDTO;
import mpjt.dao.BoardDAO;
import mpjt.dao.UserDAO;
import mpjt.dto.BoardDTO;
import mpjt.dto.UserDTO;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // 한글처리

		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));

		// bbs.bo 요청이 들어오면 전처리 후 bbs.jsp로 보냄
		 if(action.equals("/bbs.bo")) {

				String searchField = request.getParameter("searchField");
				String searchWord = request.getParameter("searchWord");

				Map<String, String> map = new HashMap<>();
				map.put("searchField", searchField);
				map.put("searchWord", searchWord);

				// paging info
				int amount = 10;
				int pageNum = 1;
				
				String sPageNum = request.getParameter("pageNum");
				if(sPageNum != null) pageNum = Integer.parseInt(sPageNum);
				int offset = (pageNum-1) * amount;

				map.put("offset", offset+"");
				map.put("amount", amount+"");
				
				BoardDAO dao = new BoardDAO();
				
				List<BoardDTO> boardLists = dao.selectList(map);
				int totalCount = dao.selectCount(map);

				// Paging
				PageDTO paging = new PageDTO(pageNum, amount, totalCount);
				
				request.setAttribute("boardLists", boardLists);
				request.setAttribute("paging", paging);

				
				// forward
				String path =  "./bbs.jsp"; // 1
				request.getRequestDispatcher(path).forward(request, response);
		}else if(action.equals("/view.bo")) { // 게시글 보기

			request.setCharacterEncoding("utf-8");
			// num이라는(Fr_idx) 이름으로 전달된 값을 sNum으로 받음 (문자형으로 날라오기 때문에 String으로 받아줌)
			String sNum = request.getParameter("num"); 
			// Fr_idx는 int형 정수형으로 변환해줌 
			int num = Integer.parseInt(sNum);
			BoardDTO dto = new BoardDTO();
			// Fr_idx에 num값 세팅
			dto.setFr_idx(num);

			BoardDAO dao = new BoardDAO();

			//1. 조회수 카운트 함수 실행
			dao.updateVisitcount(dto); // 5초

			//2.  dto에 selectView 함수로 나온 데이터 저장
			dto = dao.selectView(dto);

			// dto라는 이름에 dto에 있는 데이터 셋팅
			request.setAttribute("dto", dto);

			//3. forward로 보냄
			String path =  "./view.jsp"; // 1
			request.getRequestDispatcher(path).forward(request, response);
		}else if(action.equals("/likeBoard.bo")) { 
			Connection conn = null;
			PreparedStatement pstmt = null;  
			int rs = 0;

			String sidx = request.getParameter("idx");
			int idx = Integer.parseInt(sidx);

			BoardDTO dto = new BoardDTO();
			dto.setFr_idx(idx);

			BoardDAO dao = new BoardDAO();
			int likes = dao.like(dto);
			request.setAttribute("likes", likes);

			// 증가된 좋아요 수를 JSON 형식으로 응답
			Map<String, Integer> responseData = new HashMap<>();
			responseData.put("likes", likes);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(new com.google.gson.Gson().toJson(responseData));
		}
		else if(action.equals("/deleteProc.bo")) {
			request.setCharacterEncoding("utf-8");
			String sNum = request.getParameter("num");
			int num = Integer.parseInt(sNum);

			BoardDTO dto = new BoardDTO();		
			dto.setFr_idx(num);

			BoardDAO dao = new BoardDAO();
			dao.deleteWrite(dto);

			String path = request.getContextPath() + "/mbboard/bbs.bo";
			response.sendRedirect(path);
		}else if(action.equals("/write.bo")) {
			String path = request.getContextPath() + "/mbboard/write.jsp";
			response.sendRedirect(path);
		}else if(action.equals("/WriteProc.bo")) {
			request.setCharacterEncoding("utf-8");
			String title = request.getParameter("title");
			String content = request.getParameter("content");

			HttpSession session = request.getSession();		
			String id = (String)session.getAttribute("user_id");

			BoardDTO dto = new BoardDTO(title, content, id);

			BoardDAO dao = new BoardDAO();
			dao.insertWrite(dto);

			String path = request.getContextPath() + "/mbboard/bbs.bo";
			System.out.println(path);
			response.sendRedirect(path);
		}else if(action.equals("/UpdateProc.bo")) {
			request.setCharacterEncoding("utf-8");
			String sNum = request.getParameter("num");
			int num = Integer.parseInt(sNum);
			String title = request.getParameter("title");
			String content = request.getParameter("content");		

			BoardDTO dto = new BoardDTO();		
			dto.setFr_idx(num);
			dto.setFr_title(title);
			dto.setFr_cont(content);

			BoardDAO dao = new BoardDAO();
			dao.updateWrite(dto);

			String path = request.getContextPath() + "/mbboard/view.bo?num="+num;
			response.sendRedirect(path);
		}else if(action.equals("/update.bo")) {
			System.out.println(action);

			request.setCharacterEncoding("utf-8");
			String sNum = request.getParameter("num"); 
			int num = Integer.parseInt(sNum);
			BoardDTO dto = new BoardDTO();
			dto.setFr_idx(num);

			BoardDAO dao = new BoardDAO();

			dto = dao.selectView(dto);

			request.setAttribute("dto", dto);

			String path =  "./update.jsp"; // 1
			request.getRequestDispatcher(path).forward(request, response);
		}else if(action.equals("/deleteProc.bo")) {
			request.setCharacterEncoding("utf-8");
			String sNum = request.getParameter("num");
			int num = Integer.parseInt(sNum);

			BoardDTO dto = new BoardDTO();		
			dto.setFr_idx(num);

			BoardDAO dao = new BoardDAO();
			dao.deleteWrite(dto);

			String path = request.getContextPath() + "/mbboard/bbs.bo";
			response.sendRedirect(path);
		}
	}

}

