package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.domain.MemberVO;

public interface MemberMapper {
	
	//다음멤버번호 검색
	@Select("SELECT member_seq.nextval FROM dual")
	public Integer selectMem_num();
	
	//멤버회원가입 - member테이블
	@Insert("INSERT INTO member (mem_num,id,auth) VALUES (#{mem_num},#{id},2)")
	public void insert(MemberVO member);
	
	//멤버회원가입 - member_detail테이블
	@Insert("INSERT INTO member_detail (mem_num,passwd,name,email,phone,address,reg_date,passwd_q,passwd_a) VALUES (#{mem_num},#{passwd},#{name},#{email},#{phone},#{address},SYSDATE,#{passwd_q},#{passwd_a})")
	public void insertDetail(MemberVO member);
	
	//아이디로 멤버 검색
	@Select("SELECT * FROM member m LEFT OUTER JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.id=#{id}")
	public MemberVO selectCheckMember(String id);
	
	//멤버번호로 멤버 검색
	@Select("SELECT * FROM member m JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);
	
	//멤버상세정보 수정
	@Update("UPDATE member_detail SET passwd=#{passwd},name=#{name},email=#{email},phone=#{phone},address=#{address},passwd_q=#{passwd_q},passwd_a=#{passwd_a} WHERE mem_num=#{mem_num}")
	public void update(MemberVO member);
	
	//멤버 회원탈퇴 (member테이블)
	@Update("UPDATE member SET auth=0 WHERE mem_num=#{mem_num}")
	public void delete(Integer mem_num);
	
	//멤버 회원탈퇴 (member_detail테이블)
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteDetail(Integer mem_num);
	
	//비밀번호 찾기
	@Select("SELECT password_q FROM member m LEFT OUTER JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.id=#{id}")
	public void findPassword(String id);
	
	//총 회원 수 구하기
	public int selectRowCount(Map<String, Object> map);

	//회원 목록 
	public List<MemberVO> memberList(Map<String, Object> map);

	//회원 auth를 1(정지회원)로 만듬
	@Update("UPDATE member SET auth=1 WHERE mem_num=#{mem_num}")
	public void authToOne(int mem_num);
	
	//회원 auth를 2(일반회원)로 만듬
	@Update("UPDATE member SET auth=2 WHERE mem_num=#{mem_num}")
	public void authToTwo(int mem_num);
	

	
	
	
	
	
	
	
	

	
}
