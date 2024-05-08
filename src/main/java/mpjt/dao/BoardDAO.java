package mpjt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import mpjt.dto.BoardDTO;
import mpjt.common.JDBCConnect;

public class BoardDAO {
	
	// 제목 내용 글 검색
	public List<BoardDTO> selectList(Map<String, String> map){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;				

		// search 여부
		boolean isSearch = false;
		if(map.get("searchWord") != null && map.get("searchWord").length() != 0) {
			isSearch = true;
		}	

		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		String sql = "select fr_idx, user_id,fr_title,fr_cont,fr_visitnum, fr_like, fr_regd from free_board";
		if(isSearch) {
			sql += " where " + map.get("searchField") + " like ? ";
		}
		sql += " order by fr_idx desc";

		conn = JDBCConnect.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			if(isSearch) {
				pstmt.setString(1, "%" + map.get("searchWord") + "%");
			}
			rs = pstmt.executeQuery();

			while(rs.next()) {
				int fr_idx = rs.getInt("fr_idx");
				String user_id = rs.getString("user_id");
				String title = rs.getString("fr_title");
				String cont = rs.getString("fr_cont");
				int visitnum = rs.getInt("fr_visitnum");
				int like = rs.getInt("fr_like");
				String regd = rs.getString("fr_regd");
				BoardDTO dto = new BoardDTO(fr_idx, user_id, title, cont, visitnum, like, regd);
				bbs.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}



		return bbs;
	}
	
	// 전체 글 갯수 출력
	public int selectCount(Map<String, String> map){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;				

		int totalCount = 0;

		// search 여부
		boolean isSearch = false;
		if(map.get("searchWord") != null && map.get("searchWord").length() != 0) {
			isSearch = true;
		}		

		String sql = "select count(fr_idx) as cnt from free_board ";
		if(isSearch) {
			//sql += " and " + map.get("searchField") + " like concat('%',?,'%')";
			sql += " where " + map.get("searchField") + " like ? ";
		}
		System.out.println(sql);
		conn = JDBCConnect.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			if(isSearch) {
				//pstmt.setString(1, map.get("searchWord"));
				pstmt.setString(1, "%" + map.get("searchWord") + "%");
			}
			rs = pstmt.executeQuery();

			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}		

		return totalCount;
	}
	
	// 게시판 글쓰기
	public int insertWrite(BoardDTO dto) {
		Connection conn = null;
	    PreparedStatement pstmt = null;  
	    int rs = 0;
	    try {
	       // 2. conn
	       conn = JDBCConnect.getConnection();
	       
	       // 3. sql + 쿼리창
	       String sql = "insert into free_board(fr_title, fr_cont, user_id) values(?,?,?)";
	       pstmt = conn.prepareStatement(sql);
	       
	       // 4. ? 세팅
	       pstmt.setString(1, dto.getFr_title());
	       pstmt.setString(2, dto.getFr_cont());
	       pstmt.setString(3, dto.getUser_id());
	       
	       // 5. execute 실행
	       rs = pstmt.executeUpdate();
	       
	    } catch (Exception e) {
	       e.printStackTrace();
	    }finally {
	       JDBCConnect.close(pstmt, conn);
	    }
	    return rs;
	}
	
	// 게시글 보기
	public BoardDTO selectView(BoardDTO dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;				

		String sql = "select fr_idx, fr_title, fr_cont,A.user_id, fr_regd, fr_visitnum";
		sql += " from free_board A, user B ";
		sql += " where fr_idx = ? and A.user_id = B.user_id";
		conn = JDBCConnect.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getFr_idx());
			rs = pstmt.executeQuery();
			
			dto = null;
			if(rs.next()) {
				int num = rs.getInt("fr_idx");
				String title = rs.getString("fr_title");
				String content = rs.getString("fr_cont");
				String id = rs.getString("user_id");
				String postdate = rs.getString("fr_regd");
				int visitcount = rs.getInt("fr_visitnum");
				dto = new BoardDTO(num, title, content, id, postdate, visitcount);				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}
		
		return dto;
	}
	// 조회수
	public int updateVisitcount(BoardDTO dto) {
		Connection conn = null;
	    PreparedStatement pstmt = null;  
	    int rs = 0;
	    try {
	       // 2. conn
	       conn = JDBCConnect.getConnection();
	       
	       // 3. sql + 쿼리창
	       String sql = "update free_board set fr_visitnum = fr_visitnum + 1 ";
	       sql += " where fr_idx = ?";
	       pstmt = conn.prepareStatement(sql);
	       
	       // 4. ? 세팅
	       pstmt.setInt(1, dto.getFr_idx());
	       
	       // 5. execute 실행
	       rs = pstmt.executeUpdate();
	       
	    } catch (Exception e) {
	       e.printStackTrace();
	    }finally {
	       JDBCConnect.close(pstmt, conn);
	    }
	    return rs;
	}
	
	// 게시글 업데이트
	public int updateWrite(BoardDTO dto) {
		Connection conn = null;
	    PreparedStatement pstmt = null;  
	    int rs = 0;
	    try {
	       // 2. conn
	       conn = JDBCConnect.getConnection();
	       
	       // 3. sql + 쿼리창
	       String sql = "update free_board set fr_title = ?, fr_cont = ? ";
	       sql += " where fr_idx = ?";
	       pstmt = conn.prepareStatement(sql);
	       
	       // 4. ? 세팅
	       pstmt.setString(1, dto.getFr_title());
	       pstmt.setString(2, dto.getFr_cont());
	       pstmt.setInt(3, dto.getFr_idx());
	       
	       // 5. execute 실행
	       rs = pstmt.executeUpdate();
	       
	    } catch (Exception e) {
	       e.printStackTrace();
	    }finally {
	       JDBCConnect.close(pstmt, conn);
	    }
	    return rs;
	}
	// 게시글 삭제
	public int deleteWrite(BoardDTO dto) {
		Connection conn = null;
	    PreparedStatement pstmt = null;  
	    int rs = 0;
	    try {
	       // 2. conn
	       conn = JDBCConnect.getConnection();
	       
	       // 3. sql + 쿼리창
	       String sql = "delete from free_board ";
	       sql += " where fr_idx = ?";
	       pstmt = conn.prepareStatement(sql);
	       
	       // 4. ? 세팅
	       pstmt.setInt(1, dto.getFr_idx());
	       
	       // 5. execute 실행
	       rs = pstmt.executeUpdate();
	       
	    } catch (Exception e) {
	       e.printStackTrace();
	    }finally {
	       JDBCConnect.close(pstmt, conn);
	    }
	    return rs;
	}

}
