package kr.spring.member.domain;

import java.sql.Date;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class MemberVO {

	private int mem_num;//회원번호
	
	@NotEmpty
	private String id;//회원아이디
	
	private int auth;//회원권한
	
	@NotEmpty
	private String name;//회원이름
	
	@NotEmpty
	private String passwd;//회원비밀번호
	
	@NotEmpty
	private String phone;//회원전화번호
	
	@Email
	@NotEmpty
	private String email;//회원이메일
	
	@NotEmpty
	private String address;//회원주소
	
	private Date reg_date;//회원가입일
	
	@NotEmpty
	private String passwd_q;//회원비밀번호 찾기 질문
	
	@NotEmpty
	private String passwd_a;//회원비밀번호 찾기 답변

	
	

	//비밀번호 인증
	public boolean isCheckedPasswd(String userPasswd) {
		if(auth>1 && passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}
	
	
	
	
	
	
	
	
	
	
	
	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getPasswd_q() {
		return passwd_q;
	}

	public void setPasswd_q(String passwd_q) {
		this.passwd_q = passwd_q;
	}

	public String getPasswd_a() {
		return passwd_a;
	}

	public void setPasswd_a(String passwd_a) {
		this.passwd_a = passwd_a;
	}











	@Override
	public String toString() {
		return "MemberVO [mem_num=" + mem_num + ", id=" + id + ", auth=" + auth + ", name=" + name + ", passwd="
				+ passwd + ", phone=" + phone + ", email=" + email + ", address=" + address + ", reg_date=" + reg_date
				+ ", passwd_q=" + passwd_q + ", passwd_a=" + passwd_a + "]";
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
