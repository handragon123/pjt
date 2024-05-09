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


@WebServlet("/Rest/UpdateController")
public class UpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		
		// 1. 값 받기
		request.setCharacterEncoding("utf-8");
		String sNum = request.getParameter("num");
		int num = Integer.parseInt(sNum);
		String tell = request.getParameter("tell");
		String addr = request.getParameter("addr");		
		
		// 2. 값 출력
		//System.out.println(num);
		//System.out.println(title);
		//System.out.println(content);
		
		// 3. DTO
		RestDTO dto = new RestDTO();		

		dto.setRs_idx(num);;
		dto.setRs_tell(tell);;
		dto.setRs_addr(addr);;

		
		// 4. DAO 
		RestDAO dao = new RestDAO();
		dao.updateWrite(dto);
		
		// 5. move
		String path = request.getContextPath() + "/Rest/view.jsp?num="+num;

		response.sendRedirect(path);
	}

}
