package mpjt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import mpjt.common.JDBCConnect;
import mpjt.dto.UserDTO;

public class UserDAO {
   
   public List<UserDTO> getUsers(){
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;      

      List<UserDTO> userList = new ArrayList<>();

      try{
         // 2. connection
         conn = JDBCConnect.getConnection();
         
         // 3. sql창
         String sql = "select user_id, user_password, user_name, user_gen from user;";
         pstmt = conn.prepareStatement(sql);
         // 4. execute
         rs = pstmt.executeQuery();
         // 5. rs처리 : id값만 list에 저장
         while(rs.next()) {
            String id = rs.getString("user_id");
            String password = rs.getString("user_password");
            String name = rs.getString("user_name");
            String gen = rs.getString("user_gen");
            UserDTO dto = new UserDTO(id, password, name, gen);
            userList.add(dto);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         JDBCConnect.close(rs, pstmt, conn);
      }
      return userList;
   }
      
   
   public int login(String user_id, String user_password) { // 내가 sql에 지정한 변수로 써야함 
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;   
      
      String SQL = "SELECT user_password FROM user WHERE user_id = ?";
      try {
         //connection
         conn = JDBCConnect.getConnection();
         
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, user_id);
          rs = pstmt.executeQuery();
          if(rs.next()) {
             if(rs.getString(1).equals(user_password)) 
                return 1; // 로그인 성공 
             else 
                return 0; //비밀번호 불일치  
          }
          return -1; // 아이디가 없음  
      } catch(Exception e) {
         e.printStackTrace();
      }
      return -2; // 데이터베이스 오류 
   }
   
   public int join(UserDTO user) {
	   Connection conn = null;
	    PreparedStatement pstmt = null;  
	    int rs = 0;
	    try {
	       // 2. conn
	       conn = JDBCConnect.getConnection();
	       
	       // 3. sql + 쿼리창
	       String sql = "insert into user(user_id, user_password, user_name, user_gen) values(?,?,?,?)";
	       pstmt = conn.prepareStatement(sql);
	       
	       // 4. ? 세팅
	       pstmt.setString(1, user.getUser_id());
	       pstmt.setString(2, user.getUser_password());
	       pstmt.setString(3, user.getUser_name());
	       pstmt.setString(4, user.getUser_gen());
	       
	       // 5. execute 실행
	       rs = pstmt.executeUpdate();
	       System.out.println("rs>>>>>>>>>>>>>>"+rs);
	       System.out.println("회원가입 성공");
	       rs = 1;
	    } catch (Exception e) {
	       e.printStackTrace();
	    }finally {
	       JDBCConnect.close(pstmt, conn);
	    }
	    return rs;
	}
}