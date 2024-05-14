package mpjt.dao;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import mpjt.dto.BoardDTO;
import mpjt.dto.CommentDTO;
import mpjt.common.JDBCConnect;

public class CommentDAO {

	// 게시글 번호에 따른 댓글 불러오기
	public List<CommentDTO> getComment(CommentDTO cdto){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;				


		
		List<CommentDTO> commentList = new ArrayList<CommentDTO>();


		try {
			// 1. Connection
			conn = JDBCConnect.getConnection();
			
			// 2. SQL + 쿼리문
			String sql = "select frc_idx, fr_idx, user_id, frc_cont, frc_like, frc_regd from free_board_comment where fr_idx = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cdto.getFr_idx());
			rs = pstmt.executeQuery();

			while(rs.next()) {
				int frc_idx = rs.getInt("frc_idx");
				int fr_idx = rs.getInt("fr_idx");
				String user_id = rs.getString("user_id");
				String cont = rs.getString("frc_cont");
				int like = rs.getInt("frc_like");
				String regd = rs.getString("frc_regd");
				CommentDTO cto = new CommentDTO(frc_idx, fr_idx, user_id, cont, like, regd);
				commentList.add(cto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}
		return commentList;
	}

	// 댓글 달기
	public List<CommentDTO> insertWrite(CommentDTO cdto) {
	    System.out.println("insertWrite 메서드 실행");
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    List<CommentDTO> cbs = new ArrayList<CommentDTO>();
	    
	    try {
	        // 1. Connection
	        conn = JDBCConnect.getConnection();

	        // 2. SQL + 쿼리문
	        String sql = "insert into free_board_comment (fr_idx, user_id, frc_cont) values(?,?,?)";
	        pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 생성된 키 반환을 위해 Statement.RETURN_GENERATED_KEYS 옵션 사용

	        // 3. ?에 값 세팅
	        pstmt.setInt(1, cdto.getFr_idx());
	        pstmt.setString(2, cdto.getUser_id());
	        pstmt.setString(3, cdto.getFrc_cont());

	        // 4. execute 실행
	        int affectedRows = pstmt.executeUpdate();
	        
	        if (affectedRows == 0) {
	            throw new SQLException("댓글 추가 실패: 행이 영향을 받지 않음");
	        }

	        // 생성된 키(댓글의 ID) 가져오기
	        rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            int frc_idx = rs.getInt(1); // 첫 번째 컬럼의 값을 가져옴
	            CommentDTO cto = new CommentDTO(frc_idx, cdto.getFr_idx(), cdto.getUser_id(), cdto.getFrc_cont(), cdto.getFrc_like(), cdto.getFrc_regd()); // 좋아요 수와 등록일은 새로 추가된 댓글의 경우 0 또는 null로 설정
	            cbs.add(cto);
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        JDBCConnect.close(rs, pstmt, conn); // ResultSet도 닫아주어야 함
	    }
	    return cbs;
	}
}
