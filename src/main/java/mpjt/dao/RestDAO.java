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
import mpjt.dto.RestDTO;
import mpjt.common.JDBCConnect;

public class RestDAO {

	public List<RestDTO> selectList(Map<String, String> map) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// search 여부
		boolean isSearch = false;
		if(map.get("searchWord") != null && map.get("searchWord").length() !=0) {
			isSearch = true;
		}
		List<RestDTO> rest = new ArrayList<RestDTO>();
		String sql = "select rs_idx, rs_name, rs_addr, rs_tell, rs_hour,rs_visitnum, rs_type, rs_reviews from restaurant";
		if(isSearch) {
			sql += " where " + map.get("searchField") + " like ? ";
		}
		sql += " order by rs_idx desc";

		conn = JDBCConnect.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			if(isSearch) {
				pstmt.setString(1, "%" + map.get("searchWord") + "%");
			}
			rs = pstmt.executeQuery();

			while(rs.next()) {
				int idx = rs.getInt("rs_idx");
				String name = rs.getString("rs_name");
				String addr = rs.getString("rs_addr");
				String tell = rs.getString("rs_tell");
				String hour = rs.getString("rs_hour");
				int visitnum = rs.getInt("rs_visitnum");
				String type = rs.getString("rs_type");
				String reviews = rs.getString("rs_reviews");
				RestDTO dto = new RestDTO(idx, name, addr, tell, hour, visitnum, type, reviews);
				rest.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}

		return rest;
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

		String sql = "select count(rs_name) as cnt from restaurant ";
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
	public int insertWrite(RestDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;  
		int rs = 0;
		try {
			// 2. conn
			conn = JDBCConnect.getConnection();

			// 3. sql + 쿼리창
			String sql = "insert into restaurant(rs_name,rs_addr,rs_tell,rs_hour,rs_type,rs_reviews, user_id) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			// 4. ? 세팅
			pstmt.setString(1, dto.getRs_name());
			pstmt.setString(2, dto.getRs_addr());
			pstmt.setString(3, dto.getRs_tell());
			pstmt.setString(4, dto.getRs_hour());
			pstmt.setString(5, dto.getRs_type());
			pstmt.setString(6, dto.getRs_reviews());
			pstmt.setString(7, dto.getUser_id());
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

	public RestDTO selectView(RestDTO dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;				


		String sql = "select rs_idx, rs_regd, A.user_id, rs_reviews, rs_name, rs_addr, rs_tell,rs_like";
		sql += " from restaurant A, user B ";
		sql += " where rs_idx = ? and A.user_id = B.user_id";
		conn = JDBCConnect.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getRs_idx());
			rs = pstmt.executeQuery();

			dto = null;
			if(rs.next()) {
				int idx = rs.getInt("rs_idx");
				String uid = rs.getString("user_id");
				String regd = rs.getString("rs_regd");
				String reviews = rs.getString("rs_reviews");
				String name = rs.getString("rs_name");
				String addr = rs.getString("rs_addr");
				String tell = rs.getString("rs_tell");
				int like = rs.getInt("rs_like");
				dto = new RestDTO(idx, regd, reviews, name, addr, uid, tell,like);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnect.close(rs, pstmt, conn);
		}

		return dto;
	}
	
	// 조회수
		public int updateVisitcount(RestDTO dto) {
			Connection conn = null;
		    PreparedStatement pstmt = null;  
		    int rs = 0;
		    try {
		       // 2. conn
		       conn = JDBCConnect.getConnection();
		       
		       // 3. sql + 쿼리창
		       String sql = "update restaurant set rs_visitnum = rs_visitnum + 1 ";
		       sql += " where rs_idx = ?";
		       pstmt = conn.prepareStatement(sql);
		       
		       // 4. ? 세팅
		       pstmt.setInt(1, dto.getRs_idx());
		       
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
	public int updateWrite(RestDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;  
		int rs = 0;
		try {
			// 2. conn
			conn = JDBCConnect.getConnection();

			// 3. sql + 쿼리창
			String sql = "update restaurant set rs_tell = ?, rs_addr = ? ";
			sql += " where rs_idx = ?";
			pstmt = conn.prepareStatement(sql);

			// 4. ? 세팅
			pstmt.setString(1, dto.getRs_tell());
			pstmt.setString(2, dto.getRs_addr());
			pstmt.setInt(3, dto.getRs_idx());

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
		public int deleteWrite(RestDTO dto) {
			Connection conn = null;
		    PreparedStatement pstmt = null;  
		    int rs = 0;
		    try {
		       // 2. conn
		       conn = JDBCConnect.getConnection();
		       
		       // 3. sql + 쿼리창
		       String sql = "delete from restaurant ";
		       sql += " where rs_idx = ?";
		       pstmt = conn.prepareStatement(sql);
		       
		       // 4. ? 세팅
		       pstmt.setInt(1, dto.getRs_idx());
		       
		       // 5. execute 실행
		       rs = pstmt.executeUpdate();
		       
		    } catch (Exception e) {
		       e.printStackTrace();
		    }finally {
		       JDBCConnect.close(pstmt, conn);
		    }
		    return rs;
		}
		// 좋아요 증가
		public int updateLike(RestDTO dto) {
			Connection conn = null;
		    PreparedStatement pstmt = null;  
		    int rs = 0;
		    try {
		       // 2. conn
		       conn = JDBCConnect.getConnection();
		       
		       // 3. sql + 쿼리창
		       String sql = "update restaurant set rs_like = rs_like + 1 ";
		       sql += " where rs_idx = ?";
		       pstmt = conn.prepareStatement(sql);
		       
		       // 4. ? 세팅
		       pstmt.setInt(1, dto.getRs_like());
		       
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
