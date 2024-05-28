package mpjt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import mpjt.dto.CommentDTO;
import mpjt.common.JDBCConnect;

public class CommentDAO {

    // 댓글 목록 가져오기
   public List<CommentDTO> getComment(CommentDTO cdto, String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<CommentDTO> commentList = new ArrayList<>();
       

        try {
            conn = JDBCConnect.getConnection();
            String sql = "SELECT frc_idx, fr_idx, user_id, frc_cont, frc_like, frc_regd, frc_like_users " +
                         "FROM free_board_comment WHERE fr_idx = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cdto.getFr_idx());
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentDTO cto = new CommentDTO();
                cto.setFrc_idx(rs.getInt("frc_idx"));
                cto.setFr_idx(rs.getInt("fr_idx"));
                cto.setUser_id(rs.getString("user_id"));
                cto.setFrc_cont(rs.getString("frc_cont"));
                cto.setFrc_like(rs.getInt("frc_like"));
                cto.setFrc_regd(rs.getString("frc_regd"));

                // 좋아요 상태 설정
                String likeUsers = rs.getString("frc_like_users");
                Set<String> likeUserSet = new HashSet<>(Arrays.asList(likeUsers != null ? likeUsers.split(",") : new String[0]));
                cto.setLiked(likeUserSet.contains(userId));
                commentList.add(cto);
                int commentCount = commentList.size();
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
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<CommentDTO> cbs = new ArrayList<CommentDTO>();

        try {
            conn = JDBCConnect.getConnection();
            String sql = "INSERT INTO free_board_comment (fr_idx, user_id, frc_cont) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, cdto.getFr_idx());
            pstmt.setString(2, cdto.getUser_id());
            pstmt.setString(3, cdto.getFrc_cont());
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("댓글 추가 실패: 행이 영향을 받지 않음");
            }

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                int frc_idx = rs.getInt(1);
                CommentDTO cto = new CommentDTO(frc_idx, cdto.getFr_idx(), cdto.getUser_id(), cdto.getFrc_cont(), 0, null);
                cbs.add(cto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCConnect.close(rs, pstmt, conn);
        }
        return cbs;
    }

    // 댓글 삭제
    public int deleteComment(CommentDTO cdto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int rs = 0;

        try {
            conn = JDBCConnect.getConnection();
            String sql = "DELETE FROM free_board_comment WHERE frc_idx = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cdto.getFrc_idx());
            rs = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCConnect.close(pstmt, conn);
        }
        return rs;
    }

 // 좋아요 토글 기능 수정
    public int toggleLike(int frc_idx, String user_id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int updatedLikeCount = 0; // 좋아요 수를 업데이트한 값

        try {
            conn = JDBCConnect.getConnection();

            // 댓글 좋아요 여부 확인
            String query = "SELECT frc_like_users, frc_like FROM free_board_comment WHERE frc_idx = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, frc_idx);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String likeUsers = rs.getString("frc_like_users");
                int currentLikeCount = rs.getInt("frc_like");
                Set<String> likeUserSet = new HashSet<>(Arrays.asList(likeUsers != null ? likeUsers.split(",") : new String[0]));

                if (likeUserSet.contains(user_id)) {
                    // 이미 좋아요를 누른 상태이면 좋아요 취소
                    likeUserSet.remove(user_id);
                    updatedLikeCount = currentLikeCount - 1; // 좋아요 수 감소
                } else {
                    // 좋아요를 누르지 않은 상태이면 좋아요 추가
                    likeUserSet.add(user_id);
                    updatedLikeCount = currentLikeCount + 1; // 좋아요 수 증가
                }

                // 좋아요 사용자 목록을 다시 문자열로 변환
                likeUsers = String.join(",", likeUserSet);

                // 좋아요 수와 사용자 목록 업데이트
                query = "UPDATE free_board_comment SET frc_like_users = ?, frc_like = ? WHERE frc_idx = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, likeUsers);
                pstmt.setInt(2, updatedLikeCount);
                pstmt.setInt(3, frc_idx);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCConnect.close(rs, pstmt, conn);
        }

        return updatedLikeCount;
    }


 // 좋아요 갯수 계산
    public int getLikesCount(int frc_idx) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int likesCount = 0;

        try {
            conn = JDBCConnect.getConnection();
            String query = "SELECT COUNT(*) AS like_count FROM comment_like WHERE frc_idx = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, frc_idx);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                likesCount = rs.getInt("like_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCConnect.close(rs, pstmt, conn);
        }

        return likesCount;
    }


}
