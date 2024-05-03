package mpjt.dao;

import java.sql.Connection;



import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
			String sql = "select user_idx,user_id,user_password,user_name,user_nickname from user";
			pstmt = conn.prepareStatement(sql);
			// 4. execute
			rs = pstmt.executeQuery();
			// 5. rs처리 : id값만 list에 저장
			while(rs.next()) {
				int idx = rs.getInt("user_idx");
				String id = rs.getString("user_id");
				String password = rs.getString("user_password");
				String name = rs.getString("user_name");
				String nickname = rs.getString("user_nickname");
				UserDTO dto = new UserDTO(idx, id, password, name, nickname);
				userList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCConnect.close(rs, pstmt, conn);
		}
		return userList;
	}

}
