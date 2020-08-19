package kr.spring.pickPlace.domain;

public class PickRankVO {
	private int p_num;//휴양림 고유번호
	private String p_name;//휴양림명
	private String p_img;//휴양림 이미지
	private int rank;//해당 휴양림의 찜 수 
	
	
	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_img() {
		return p_img;
	}

	public void setP_img(String p_img) {
		this.p_img = p_img;
	}

	@Override
	public String toString() {
		return "PickRankVO [p_num=" + p_num + ", rank=" + rank + ", p_name=" + p_name + ", p_img=" + p_img + "]";
	}
	
	
	
	
	
	
}
