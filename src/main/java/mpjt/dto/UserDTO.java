package mpjt.dto;

public class UserDTO {
	private int user_idx;
	private String user_id;
	private String user_password;
	private String user_name;
	private String user_nickname;
	private String user_email;
	private String user_birthday;
	private String user_gen;
	private String user_pnum;
	private String user_pic;
	private String user_favor;
	private String user_upd;
	private String user_regd;

	public UserDTO() {

	}
	
	public UserDTO(int user_idx,String user_id, String user_password, String user_name,String user_nickname) {
		this.user_idx = user_idx;
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_name = user_name;
		this.user_nickname = user_nickname;
	}
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_birthday() {
		return user_birthday;
	}
	public void setUser_birthday(String user_birthday) {
		this.user_birthday = user_birthday;
	}
	public String getUser_gen() {
		return user_gen;
	}
	public void setUser_gen(String user_gen) {
		this.user_gen = user_gen;
	}
	public String getUser_pnum() {
		return user_pnum;
	}
	public void setUser_pnum(String user_pnum) {
		this.user_pnum = user_pnum;
	}
	public String getUser_pic() {
		return user_pic;
	}
	public void setUser_pic(String user_pic) {
		this.user_pic = user_pic;
	}
	public String getUser_favor() {
		return user_favor;
	}
	public void setUser_favor(String user_favor) {
		this.user_favor = user_favor;
	}
	public String getUser_upd() {
		return user_upd;
	}
	public void setUser_upd(String user_upd) {
		this.user_upd = user_upd;
	}
	public String getUser_regd() {
		return user_regd;
	}
	public void setUser_regd(String user_regd) {
		this.user_regd = user_regd;
	}
}

