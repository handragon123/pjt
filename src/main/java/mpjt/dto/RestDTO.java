package mpjt.dto;

import javax.servlet.http.HttpSession;

public class RestDTO {


	private int rs_idx;
	private String rs_name;
	private String rs_addr;
	private String rs_tell;
	private String rs_hour;
	private int rs_visitnum;
	private String rs_type;
	private String rs_reviews;
	private String user_id;
	private String rs_upd;
	private String rs_regd;
	private int rs_like;

	// 글 작성
	public RestDTO(String rs_name, String rs_addr, String rs_tell, String rs_hour, String rs_type, String rs_reviews,
			String user_id) {
		super();
		this.rs_name = rs_name;
		this.rs_addr = rs_addr;
		this.rs_tell = rs_tell;
		this.rs_hour = rs_hour;
		this.rs_type = rs_type;
		this.rs_reviews = rs_reviews;
		this.user_id = user_id;
	}

	public RestDTO() {
		// TODO Auto-generated constructor stub
	}

	// 게시판 보기
	public RestDTO(int rs_idx, String rs_name, String rs_addr, String rs_tell, String rs_hour, int rs_visitnum,
			String rs_type, String rs_reviews) {
		super();
		this.rs_idx = rs_idx;
		this.rs_name = rs_name;
		this.rs_addr = rs_addr;
		this.rs_tell = rs_tell;
		this.rs_hour = rs_hour;
		this.rs_visitnum = rs_visitnum;
		this.rs_type = rs_type;
		this.rs_reviews = rs_reviews;
		
	}
	


	// 게시글 보기
//	public RestDTO(String rs_name, String rs_addr, String rs_num, String rs_hour,
//			String rs_type, String rs_reviews) {
//		super();
//		this.rs_name = rs_name;
//		this.rs_addr = rs_addr;
//		this.rs_num = rs_num;
//		this.rs_hour = rs_hour;
//		this.rs_type = rs_type;
//		this.rs_reviews = rs_reviews;
//	}
//	
	// 게시글 보기
	public RestDTO(int rs_idx,  String rs_regd, String rs_reviews,
			String rs_name, String rs_addr, String user_id, String rs_tell, int rs_like) {
		super();
		this.rs_idx = rs_idx;
		this.user_id = user_id;
		this.rs_regd = rs_regd;
		this.rs_reviews = rs_reviews;
		this.rs_name = rs_name;
		this.rs_addr = rs_addr;
		this.rs_tell = rs_tell;
		this.rs_like = rs_like;
	}
	
	
	

	public int getRs_idx() {
		return rs_idx;
	}

	public void setRs_idx(int rs_idx) {
		this.rs_idx = rs_idx;
	}

	public String getRs_name() {
		return rs_name;
	}

	public void setRs_name(String rs_name) {
		this.rs_name = rs_name;
	}

	public String getRs_addr() {
		return rs_addr;
	}

	public void setRs_addr(String rs_addr) {
		this.rs_addr = rs_addr;
	}

	public String getRs_tell() {
		return rs_tell;
	}

	public void setRs_tell(String rs_tell) {
		this.rs_tell = rs_tell;
	}

	public String getRs_hour() {
		return rs_hour;
	}

	public void setRs_hour(String rs_hour) {
		this.rs_hour = rs_hour;
	}

	public int getRs_visitnum() {
		return rs_visitnum;
	}

	public void setRs_visitnum(int rs_visitnum) {
		this.rs_visitnum = rs_visitnum;
	}

	public String getRs_type() {
		return rs_type;
	}

	public void setRs_type(String rs_type) {
		this.rs_type = rs_type;
	}

	public String getRs_reviews() {
		return rs_reviews;
	}

	public void setRs_reviews(String rs_reviews) {
		this.rs_reviews = rs_reviews;
	}
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_idx) {
		this.user_id = user_id;
	}
	
	public String getRs_upd() {
		return rs_upd;
	}

	public void setRs_upd(String rs_upd) {
		this.rs_upd = rs_upd;
	}

	public String getRs_regd() {
		return rs_regd;
	}

	public void setRs_regd(String rs_regd) {
		this.rs_regd = rs_regd;
	}
	
	public int getRs_like() {
		return rs_like;
	}

	public void setRs_like(int rs_like) {
		this.rs_like = rs_like;
	}
	
	
	
	
}
	