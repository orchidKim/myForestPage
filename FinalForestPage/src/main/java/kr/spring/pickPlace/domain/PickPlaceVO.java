package kr.spring.pickPlace.domain;

public class PickPlaceVO {
	
	private int mem_num;//회원 고유번호
	private String id;//회원 아이디
	private int p_num;//휴양림 고유번호
	private String p_name;//찜한 휴양림명
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	
	@Override
	public String toString() {
		return "PickPlaceVO [mem_num=" + mem_num + ", p_num=" + p_num + ", id=" + id + "]";
	}
	
	
}
