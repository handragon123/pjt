package mpjt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mpjt.common.JDBCConnect;

public class BoardDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() { // 예외처리 , mysql에 접속하게 해주는 부분임 
		try {
			conn = JDBCConnect.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // db 오류 알림 
	}
	
	public int getNext() {
		String SQL = "SELECT fr_idx FROM free_board ORDER BY fr_idx DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // db 오류 알림 
	}
	
	public int write(String fr_title, String user_id, String fr_cont) {
		String SQL = "INSERT INTO fr_board values (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, fr_title);
			pstmt.setString(3, user_id);
			pstmt.setString(4, getDate());
			pstmt.setString(5, fr_cont);
			pstmt.setInt(6, 1);
			rs = pstmt.executeQuery();
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
