package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.domain.MemberVO;

public interface MemberService {

	public void insert(MemberVO member);
	
	public MemberVO selectCheckMember(String id);
	
	public MemberVO selectMember(Integer mem_num);

	public void update(MemberVO member);
	
	public void delete(Integer mem_num);

	public int selectRowCount(Map<String, Object> map);
	
	public List<MemberVO> memberList(Map<String,Object> map);
	
	

	public void authToTwo(Integer mem_num);
	
	public void authToOne(Integer mem_num);

}
