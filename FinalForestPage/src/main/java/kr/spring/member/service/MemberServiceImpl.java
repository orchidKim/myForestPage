package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.domain.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	
	@Resource
	private MemberMapper memberMapper;
	
	@Override
	public void insert(MemberVO member) {
		//시퀀스를 이용해서 mem_num 구하기
		member.setMem_num(memberMapper.selectMem_num());
		//member,member_detail 테이블에 각각 저장
		//순서는 member가 member_detail보다 먼저여야함(foreign key 때문)
		memberMapper.insert(member);
		memberMapper.insertDetail(member);
	}
	
	
	//멤버상세정보
	@Override
	public MemberVO selectMember(Integer mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	
	//로그인 확인,아이디 중복여부 확인
	@Override
	public MemberVO selectCheckMember(String id) {
		return memberMapper.selectCheckMember(id);
	}
	

	//멤버상세정보 수정
	@Override
	public void update(MemberVO member) {
		memberMapper.update(member);
	}
	
	
	//회원탈퇴
	@Override
	public void delete(Integer mem_num) {
		memberMapper.delete(mem_num);
		memberMapper.deleteDetail(mem_num);
	}



	
	//총 회원 수 구하기
	@Override
	public int selectRowCount(Map<String, Object> map) {
		
		return memberMapper.selectRowCount(map);
	}

	//회원 목록 리스트(관리자)
	@Override
	public List<MemberVO> memberList(Map<String, Object> map) {
		return memberMapper.memberList(map);
	}


	//회원 권한 2로 변경
	@Override
	public void authToTwo(Integer mem_num) {
		memberMapper.authToTwo(mem_num);		
	}

	//회원 권한 1로 변경
	@Override
	public void authToOne(Integer mem_num) {
		memberMapper.authToOne(mem_num);		
	}
	
	
	
	



	



	

	

	
}
