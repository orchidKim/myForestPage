package kr.spring.visit.domain;

import java.sql.Date;

public class VisitVO {
	private int v_num;//방문예약 고유번호
	private String p_name;//휴양림명
	private int mem_num;//방문예정자 회원고유번호
	private int p_num;//방문예정 휴양림 고유번호
	private String v_day;//방문날짜 
	private int v_cnt;//방문인원
	
	public int getV_num() {
		return v_num;
	}

	public void setV_num(int v_num) {
		this.v_num = v_num;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public String getV_day() {
		return v_day;
	}

	public void setV_day(String v_day) {
		this.v_day = v_day;
	}

	public int getV_cnt() {
		return v_cnt;
	}

	public void setV_cnt(int v_cnt) {
		this.v_cnt = v_cnt;
	}

	@Override
	public String toString() {
		return "VisitVO [v_num=" + v_num + ", p_name=" + p_name + ", mem_num=" + mem_num + ", p_num=" + p_num
				+ ", v_day=" + v_day + ", v_cnt=" + v_cnt + "]";
	}
	
	
	


}



