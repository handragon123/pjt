package mpjt.dto;

public class BoardDTO {
	private int fr_idx;
	private String user_id;
	private int user_idx;
	private String fr_title;
	private String fr_cont;
	private int fr_visitnum;
	private int fr_like;
	private String fr_file;
	private String fr_upd;
	private String fr_regd;
	
	public BoardDTO() {
	}
	
	public BoardDTO(int fr_idx, String user_id, String fr_title, String fr_cont, int fr_visitnum, int fr_like, String fr_regd) {
	this.fr_idx = fr_idx;
	this.user_id = user_id;
	this.fr_title = fr_title;
	this.fr_cont = fr_cont;
	this.fr_visitnum = fr_visitnum;
	this.fr_like = fr_like;
	this.fr_regd = fr_regd;
	
	}
	
	public int getFr_idx() {
		return fr_idx;
	}
	public void setFr_idx(int fr_idx) {
		this.fr_idx = fr_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getFr_title() {
		return fr_title;
	}
	public void setFr_title(String fr_title) {
		this.fr_title = fr_title;
	}
	public String getFr_cont() {
		return fr_cont;
	}
	public void setFr_cont(String fr_cont) {
		this.fr_cont = fr_cont;
	}
	public int getFr_visitnum() {
		return fr_visitnum;
	}
	public void setFr_visitnum(int fr_visitnum) {
		this.fr_visitnum = fr_visitnum;
	}
	public int getFr_like() {
		return fr_like;
	}
	public void setFr_like(int fr_like) {
		this.fr_like = fr_like;
	}
	public String getFr_file() {
		return fr_file;
	}
	public void setFr_file(String fr_file) {
		this.fr_file = fr_file;
	}
	public String getFr_upd() {
		return fr_upd;
	}
	public void setFr_upd(String fr_upd) {
		this.fr_upd = fr_upd;
	}
	public String getFr_regd() {
		return fr_regd;
	}
	public void setFr_regd(String fr_regd) {
		this.fr_regd = fr_regd;
	}
}
