package kr.spring.forest.domain;

import org.springframework.web.multipart.MultipartFile;

public class ForestVO {
	private int p_num;//고유번호
	
	private String p_name;//휴양림명
	private String p_city;//시도명
	private String p_div;//구분
	
	private float p_size;//면적
	private int p_count;//수용가능인원
	
	private String p_cost;//입장료
	private String p_stay;//숙박가능여부
	private String p_facility;//주요시설 
	private String p_load;//소재지도로명주소
	private String p_pubnum;//관리기관명
	private String p_phone;//전화번호
	private String p_web;//홈페이지 주소
	
	private float p_latitude;//위도
	private float p_longitude;//경도
	
	private String p_regdate;//데이터기준일자
	private String p_code;//제공기관코드
	private String p_pubname;//제공기관명
	
	private String p_img;
	private MultipartFile img_path;//이미지 경로
	
	
	public ForestVO() {
		super();
	}


	public ForestVO(int p_num, String p_name, String p_city, String p_div, float p_size, int p_count, String p_cost,
			String p_stay, String p_facility, String p_load, String p_pubnum, String p_phone, String p_web,
			float p_latitude, float p_longitude, String p_regdate, String p_code, String p_pubname, String p_img,
			MultipartFile img_path) {
		super();
		this.p_num = p_num;
		this.p_name = p_name;
		this.p_city = p_city;
		this.p_div = p_div;
		this.p_size = p_size;
		this.p_count = p_count;
		this.p_cost = p_cost;
		this.p_stay = p_stay;
		this.p_facility = p_facility;
		this.p_load = p_load;
		this.p_pubnum = p_pubnum;
		this.p_phone = p_phone;
		this.p_web = p_web;
		this.p_latitude = p_latitude;
		this.p_longitude = p_longitude;
		this.p_regdate = p_regdate;
		this.p_code = p_code;
		this.p_pubname = p_pubname;
		this.p_img = p_img;
		this.img_path = img_path;
	}


	@Override
	public String toString() {
		return "ForestVO [p_num=" + p_num + ", p_name=" + p_name + ", p_city=" + p_city + ", p_div=" + p_div
				+ ", p_size=" + p_size + ", p_count=" + p_count + ", p_cost=" + p_cost + ", p_stay=" + p_stay
				+ ", p_facility=" + p_facility + ", p_load=" + p_load + ", p_pubnum=" + p_pubnum + ", p_phone="
				+ p_phone + ", p_web=" + p_web + ", p_latitude=" + p_latitude + ", p_longitude=" + p_longitude
				+ ", p_regdate=" + p_regdate + ", p_code=" + p_code + ", p_pubname=" + p_pubname + ", p_img=" + p_img
				+ ", img_path=" + img_path + "]";
	}


	public int getP_num() {
		return p_num;
	}


	public void setP_num(int p_num) {
		this.p_num = p_num;
	}


	public String getP_name() {
		return p_name;
	}


	public void setP_name(String p_name) {
		this.p_name = p_name;
	}


	public String getP_city() {
		return p_city;
	}


	public void setP_city(String p_city) {
		this.p_city = p_city;
	}


	public String getP_div() {
		return p_div;
	}


	public void setP_div(String p_div) {
		this.p_div = p_div;
	}


	public float getP_size() {
		return p_size;
	}


	public void setP_size(float p_size) {
		this.p_size = p_size;
	}


	public int getP_count() {
		return p_count;
	}


	public void setP_count(int p_count) {
		this.p_count = p_count;
	}


	public String getP_cost() {
		return p_cost;
	}


	public void setP_cost(String p_cost) {
		this.p_cost = p_cost;
	}


	public String getP_stay() {
		return p_stay;
	}


	public void setP_stay(String p_stay) {
		this.p_stay = p_stay;
	}


	public String getP_facility() {
		return p_facility;
	}


	public void setP_facility(String p_facility) {
		this.p_facility = p_facility;
	}


	public String getP_load() {
		return p_load;
	}


	public void setP_load(String p_load) {
		this.p_load = p_load;
	}


	public String getP_pubnum() {
		return p_pubnum;
	}


	public void setP_pubnum(String p_pubnum) {
		this.p_pubnum = p_pubnum;
	}


	public String getP_phone() {
		return p_phone;
	}


	public void setP_phone(String p_phone) {
		this.p_phone = p_phone;
	}


	public String getP_web() {
		return p_web;
	}


	public void setP_web(String p_web) {
		this.p_web = p_web;
	}


	public float getP_latitude() {
		return p_latitude;
	}


	public void setP_latitude(float p_latitude) {
		this.p_latitude = p_latitude;
	}


	public float getP_longitude() {
		return p_longitude;
	}


	public void setP_longitude(float p_longitude) {
		this.p_longitude = p_longitude;
	}


	public String getP_regdate() {
		return p_regdate;
	}


	public void setP_regdate(String p_regdate) {
		this.p_regdate = p_regdate;
	}


	public String getP_code() {
		return p_code;
	}


	public void setP_code(String p_code) {
		this.p_code = p_code;
	}


	public String getP_pubname() {
		return p_pubname;
	}


	public void setP_pubname(String p_pubname) {
		this.p_pubname = p_pubname;
	}


	public String getP_img() {
		return p_img;
	}


	public void setP_img(String p_img) {
		this.p_img = p_img;
	}


	public MultipartFile getImg_path() {
		return img_path;
	}


	public void setImg_path(MultipartFile img_path) {
		this.img_path = img_path;
	}


	
	
}
