package kr.spring.comment.domain;

import java.sql.Date;


public class CommentVO {
	private int c_num;		//댓글 고유번호
	private int p_num;		//휴양림 고유번호
	private int mem_num;	//회원 고유번호
	private String comments;	//댓글내용
	private Date reg_date;		//작성일
	private String id;			//회원아이디(작성자 아이디)
	
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "CommentVO [c_num=" + c_num + ", p_num=" + p_num + ", mem_num=" + mem_num + ", comments=" + comments
				+ ", reg_date=" + reg_date + ", id=" + id + "]";
	}
	
	
}
