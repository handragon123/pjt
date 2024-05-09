package mpjt.service.rest;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mpjt.dao.RestDAO;
import mpjt.dto.RestDTO;

@WebServlet("/WriteController")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		
		// 1. 값 받기
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");
		String tell = request.getParameter("tell");
		String hour = request.getParameter("hour");
		String type = request.getParameter("type");
		String reviews = request.getParameter("reviews");
		
		HttpSession session = request.getSession();		
		String id = (String)session.getAttribute("user_id");
		
		// 2. 값 출력
		//System.out.println(title);
		//System.out.println(content);
		
		
		// 3. DTO
		RestDTO dto = new RestDTO(name, addr, tell, hour, type, reviews, id);
		
		// 4. DAO 
		RestDAO dao = new RestDAO();
		dao.insertWrite(dto);
		
		// 5. move
		String path = request.getContextPath() + "/Rest/restmain.jsp";
		response.sendRedirect(path);
	}

}
