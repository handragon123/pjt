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



@WebServlet("/Rest/DeleteController")
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		
		// 1. 값 받기
		request.setCharacterEncoding("utf-8");
		String sNum = request.getParameter("num");
		int num = Integer.parseInt(sNum);
		
		// 2. 값 출력
		//System.out.println(num);
		
		// 3. DTO
		RestDTO dto = new RestDTO();		

		dto.setRs_idx(num);

		
		// 4. DAO 
		RestDAO dao = new RestDAO();
		dao.deleteWrite(dto);
		
		// 5. move
		String path = request.getContextPath() + "/Rest/restmain.jsp";

		response.sendRedirect(path);
	}

}
