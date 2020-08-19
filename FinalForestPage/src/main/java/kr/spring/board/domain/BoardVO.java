package kr.spring.board.domain;


import java.sql.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class BoardVO {
	private int n_num;
	@NotEmpty
	private String n_title;
	private int n_hit;
	private Date reg_date;
	private Date modify_date;
	@NotEmpty
	private String notice;
	private int mem_num;
	private String id;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getN_num() {
		return n_num;
	}
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public int getN_hit() {
		return n_hit;
	}
	public void setN_hit(int n_hit) {
		this.n_hit = n_hit;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	@Override
	public String toString() {
		return "NoticeVO [n_num=" + n_num + ", n_title=" + n_title + ", n_hit=" + n_hit + ", reg_date=" + reg_date
				+ ", modify_date=" + modify_date + ", notice=" + notice + ", mem_num=" + mem_num + ", id=" + id + "]";
	}
	
	}
	


