package mpjt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
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

import com.google.gson.Gson;

import mpjt.common.JDBCConnect;
import mpjt.dao.CommentDAO;
//import mpjt.common.PageDTO;
import mpjt.dto.CommentDTO;

@WebServlet("*.co")
public class CommentController extends HttpServlet {
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
		System.out.println(uri);
		
		if(action.equals("/commentList.co")) { 
			String sFr_idx = request.getParameter("idx"); 
			int Fr_idx = Integer.parseInt(sFr_idx);
			System.out.println(Fr_idx);
			CommentDTO cdto = new CommentDTO();
			cdto.setFr_idx(Fr_idx);
			
			
			CommentDAO cdao = new CommentDAO();
			List<CommentDTO> commentList =  cdao.getComment(cdto);
	
			// json
			Gson gson = new Gson();
			String json = gson.toJson(commentList);
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
		}else if(action.equals("/commentInsert.co")) { 
				Connection conn = null;
			    PreparedStatement pstmt = null;  
			    int rs = 0;
			    
			    String sFr_idx = request.getParameter("idx");
		        String user_id = request.getParameter("user_id");
		        String cont = request.getParameter("cont");
		        int Fr_idx = Integer.parseInt(sFr_idx);
		        
		        CommentDTO cto = new CommentDTO();
		        cto.setFr_idx(Fr_idx);
		        cto.setUser_id(user_id);
		        cto.setFrc_cont(cont);
		        
		        CommentDAO cao = new CommentDAO();
		        List<CommentDTO> commentLists = cao.insertWrite(cto);
		        
		        // JSON 형식으로 응답 데이터 작성
		        Gson gson = new Gson();
				String json = gson.toJson(commentLists);

				response.setContentType("application/json; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print(json);
			}

	}

}

