package mpjt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mpjt.dto.UserDTO;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { // 예외처리 , mysql에 접속하게 해주는 부분임 
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mpjt";
			String dbID = "root";
			String dbPassword = "dksk1103";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String user_id, String user_password) { // 내가 sql에 지정한 변수로 써야함 
		String SQL = "SELECT user_password FROM user WHERE user_id = ?";
		try {
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
		String SQL = "INSERT INTO user VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);			
			pstmt.setInt(1, user.getUser_idx());
			pstmt.setString(2, user.getUser_id());
			pstmt.setString(3, user.getUser_password());
			pstmt.setString(4, user.getUser_name());
			pstmt.setString(5, user.getUser_gen());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
