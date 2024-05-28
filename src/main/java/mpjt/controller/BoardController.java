package mpjt.controller;

import java.io.File;
import java.io.IOException;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;

import mpjt.common.PageDTO;
import mpjt.dao.BoardDAO;
import mpjt.dto.BoardDTO;

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

         String path =  "./bbs.jsp"; // 1
         request.getRequestDispatcher(path).forward(request, response);
      }else if(action.equals("/searchList.bo")) {

         String searchField = request.getParameter("searchField");
         String searchWord = request.getParameter("searchWord");
         String sPageNum = (request.getParameter("page"));

         System.out.println(searchField);
         System.out.println(searchWord);

         Map<String, String> posts = new HashMap<>();
         posts.put("searchField", searchField);
         posts.put("searchWord", searchWord);

         // paging info
         int amount = 10;
         int pageNum = 1;

         //         String sPageNum = request.getParameter("pageNum");
         if(sPageNum != null) pageNum = Integer.parseInt(sPageNum);
         int offset = (pageNum-1) * amount;

         System.out.println(offset);
         System.out.println(amount);

         posts.put("offset", offset+"");
         posts.put("amount", amount+"");

         BoardDAO dao = new BoardDAO();

         List<BoardDTO> boardLists = dao.selectList(posts);
         int totalCount = dao.selectCount(posts);

         // Paging
         PageDTO paging = new PageDTO(pageNum, amount, totalCount);


         request.setAttribute("boardLists", boardLists);
         request.setAttribute("paging", paging);

         Map<String, Object> result = new HashMap<>();
         result.put("posts", boardLists);
         result.put("paging", paging);
         result.put("totalCount", totalCount);

         // json
         Gson gson = new Gson();
         String json = gson.toJson(result);
         response.setContentType("application/json; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.print(json);

      }else if(action.equals("/view.bo")) { // 게시글 보기
         request.setCharacterEncoding("utf-8");

         // num이라는(Fr_idx) 이름으로 전달된 값을 sNum으로 받음 (문자형으로 날라오기 때문에 String으로 받아줌)
         String sNum = request.getParameter("num");
         System.out.println(sNum);

         // Fr_idx는 int형 정수형으로 변환해줌 
         int num = Integer.parseInt(sNum);
         BoardDTO dto = new BoardDTO();

         // Fr_idx에 num값 세팅
         dto.setFr_idx(num);

         BoardDAO dao = new BoardDAO();

         // 1. 조회수 카운트 함수 실행
         dao.updateVisitcount(dto);

         // 2. dto에 selectView 함수로 나온 데이터 저장
         dto = dao.selectView(dto);

         // dto라는 이름에 dto에 있는 데이터 셋팅
         request.setAttribute("dto", dto);

         // 3. forward로 보냄
         String path = "./view.jsp";
         request.getRequestDispatcher(path).forward(request, response);

      } else if(action.equals("/likeBoard.bo")) { 
            String sidx = request.getParameter("idx");
            String user_id = request.getParameter("user_id");
            int idx = Integer.parseInt(sidx);

            System.out.println(idx);
            System.out.println(user_id);

            BoardDTO dto = new BoardDTO();
            dto.setFr_idx(idx);
            dto.setUser_id(user_id);
            BoardDAO dao = new BoardDAO();
            boolean userLiked = dao.toggleLike(idx, user_id);  // 좋아요 토글 함수
            int likes = dao.getLikes(idx);  // 좋아요 수 조회 함수

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("likes", likes);
            result.put("userLiked", userLiked);

            // 증가된 좋아요 수를 JSON 형식으로 응답
            // json
            Gson gson = new Gson();
            String json = gson.toJson(result);
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
         }
         else if(action.equals("/checkLikeStatus.bo")) { 
            String sidx = request.getParameter("idx");
            String user_id = request.getParameter("user_id");
            int idx = Integer.parseInt(sidx);

            System.out.println(idx);
            System.out.println(user_id);

            BoardDTO dto = new BoardDTO();
            dto.setFr_idx(idx);
            dto.setUser_id(user_id);
            BoardDAO dao = new BoardDAO();
            boolean userLiked = dao.checkLikeStatus(idx, user_id);  // 좋아요 토글 함수

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("userLiked", userLiked);

            // 증가된 좋아요 수를 JSON 형식으로 응답
            // json
            Gson gson = new Gson();
            String json = gson.toJson(result);
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
         }   else if(action.equals("/deleteProc.bo")) {
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
         // 1. 값 받기
         request.setCharacterEncoding("utf-8");
         // eclips 용 경로
         //         ServletContext application = request.getServletContext();
         //         String saveDirectory = application.getRealPath("/Uploads");
         String saveDirectory = "C:\\Users\\박성현\\Documents\\카카오톡 받은 파일\\firstpjt0524\\firstpjt0524\\firstpjt00\\src\\main\\webapp\\Uploads";
         System.out.println(saveDirectory);
         String encoding = "UTF-8";
         int maxPostSize = 1024 * 1000 * 10; // 1000kb -> 1M > 10M

         MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);

         String fileName = mr.getFilesystemName("attachedFile");
         String newFileName = null;

         if(fileName != null) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
            newFileName = now + ext;
            System.out.println(fileName);
            System.out.println(newFileName);

            File oldFile = new File(saveDirectory + File.separator + fileName); 
            File newFile = new File(saveDirectory + File.separator + newFileName); 
            oldFile.renameTo(newFile);
         }

         String title = mr.getParameter("title");
         String content = mr.getParameter("content");

         HttpSession session = request.getSession();      
         String id = (String)session.getAttribute("user_id");


         BoardDTO dto = new BoardDTO(title, content, id);
         dto.setFr_ofile(fileName);
         dto.setFr_sfile(newFileName);
         //         
         //         // 4. DAO 
         BoardDAO dao = new BoardDAO();
         dao.insertWrite(dto);
         //         // 5. move
         String path = request.getContextPath() + "/mbboard/bbs.bo";
         response.sendRedirect(path);
      }else if(action.equals("/UpdateProc.bo")) {
          // 1. 값 받기
          request.setCharacterEncoding("utf-8");
          
       
          // eclips 용 경로
          //         ServletContext application = request.getServletContext();
          //         String saveDirectory = application.getRealPath("/Uploads");
          String saveDirectory = "C:/kdigital/jsp/jspws/firstpjtS/src/main/webapp/Uploads";
          System.out.println(saveDirectory);
          String encoding = "UTF-8";
          int maxPostSize = 1024 * 1000 * 10; // 1000kb -> 1M > 10M

          MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);

          String fileName = mr.getFilesystemName("attachedFile");
          String newFileName = null;

          if(fileName != null) {
             String ext = fileName.substring(fileName.lastIndexOf("."));
             String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
             newFileName = now + ext;
             System.out.println(fileName);
             System.out.println(newFileName);

             File oldFile = new File(saveDirectory + File.separator + fileName); 
             File newFile = new File(saveDirectory + File.separator + newFileName); 
             oldFile.renameTo(newFile);
          }

          String sNum = request.getParameter("num");
          System.out.println(sNum);
          int num = Integer.parseInt(sNum);
          String title = mr.getParameter("title");
          String content = mr.getParameter("content");

          HttpSession session = request.getSession();      
          String id = (String)session.getAttribute("user_id");


          BoardDTO dto = new BoardDTO();
          dto.setFr_idx(num);
          dto.setFr_title(title);
          dto.setFr_cont(content);
          dto.setUser_id(id);
          dto.setFr_ofile(fileName);
          dto.setFr_sfile(newFileName);
          
          BoardDAO dao = new BoardDAO();
          dao.updateWrite(dto);
          //         // 5. move
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