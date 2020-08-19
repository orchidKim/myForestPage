package kr.spring.visit.domain;

import java.sql.Date;

public class VisitCount {
	private Date v_day;
	private int sum_cnt;
	
	public Date getV_day() {
		return v_day;
	}

	public void setV_day(Date v_day) {
		this.v_day = v_day;
	}

	public int getSum_cnt() {
		return sum_cnt;
	}

	public void setSum_cnt(int sum_cnt) {
		this.sum_cnt = sum_cnt;
	}

	@Override
	public String toString() {
		return "VisitCount [v_day=" + v_day + ", sum_cnt=" + sum_cnt + "]";
	}
	
	

}
