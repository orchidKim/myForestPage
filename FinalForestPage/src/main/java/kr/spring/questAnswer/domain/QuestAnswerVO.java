package kr.spring.questAnswer.domain;

import java.sql.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class QuestAnswerVO {
	private	int	mem_num	;
	private	int	q_num	;
	@NotEmpty
	private	String	q_title	;
	@NotEmpty
	private	String	question	;
	private	String	answer	;
	private String id ;
	private int		q_hit	;


	private	Date	q_reg_date	;
	private	Date	q_modify_date	;
	private	Date	a_reg_date	;
	private	Date	a_modify_date	;
	
	
	@Override
	public String toString() {
		return "QuestAnswerVO [mem_num=" + mem_num + ", q_num=" + q_num + ", q_title=" + q_title + ", question="
				+ question + ", answer=" + answer + ", id=" + id + ", q_reg_date=" + q_reg_date + ", q_modify_date="
				+ q_modify_date + ", a_reg_date=" + a_reg_date + ", a_modify_date=" + a_modify_date + "]";
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public int getQ_hit() {
		return q_hit;
	}

	public void setQ_hit(int q_hit) {
		this.q_hit = q_hit;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Date getQ_reg_date() {
		return q_reg_date;
	}

	public void setQ_reg_date(Date q_reg_date) {
		this.q_reg_date = q_reg_date;
	}

	public Date getQ_modify_date() {
		return q_modify_date;
	}

	public void setQ_modify_date(Date q_modify_date) {
		this.q_modify_date = q_modify_date;
	}

	public Date getA_reg_date() {
		return a_reg_date;
	}

	public void setA_reg_date(Date a_reg_date) {
		this.a_reg_date = a_reg_date;
	}

	public Date getA_modify_date() {
		return a_modify_date;
	}

	public void setA_modify_date(Date a_modify_date) {
		this.a_modify_date = a_modify_date;
	}
	
}
