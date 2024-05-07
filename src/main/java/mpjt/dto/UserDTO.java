package mpjt.dto;

import java.security.Timestamp;
import java.sql.Date;
import java.time.LocalDate;

public class UserDTO {
	
	private int user_idx;
	private String user_id;
	private String user_password;
	private String user_name;
	private String user_gen;
	private Timestamp user_upd;
	private Timestamp user_regd;
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
	public String getUser_gen() {
		return user_gen;
	}
	public void setUser_gen(String user_gen) {
		this.user_gen = user_gen;
	}
	public Timestamp getUser_upd() {
		return user_upd;
	}
	public void setUser_upd(Timestamp user_upd) {
		this.user_upd = user_upd;
	}
	public Timestamp getUser_regd() {
		return user_regd;
	}
	public void setUser_regd(Timestamp user_regd) {
		this.user_regd = user_regd;
	}
	
	
}
	