package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.domain.MemberVO;
import kr.spring.member.service.MemberService;

@Controller
public class MemberAjaxController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource
	private MemberService memberService;
	
	
	//아이디 중복체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String,String> process(@RequestParam String id){
		
		Map<String,String> map = new HashMap<String,String>();
		
		MemberVO member = memberService.selectCheckMember(id);
		
		if(member!=null) {//아이디 중복
			map.put("result", "idDuplicated");
		}else {//아이디 미중복
			map.put("result", "idNotFound");
		}
		
		return map;
	}
	
	
	//비밀번호 찾기
	@RequestMapping("/member/confirmAnswer.do")
	@ResponseBody
	public Map<String,String> processPasswd(@RequestParam String id, String passwd_a){
		
		Map<String,String> map = new HashMap<String,String>();
		
		//인자로 받은 id로 해당하는 memberVO를 반환받음
		MemberVO member = memberService.selectCheckMember(id);
		
		//반환받은 memberVO에서 passwd_a를 꺼내 memberPasswd 저장
		String memberPasswd_a = member.getPasswd_a();
		
		if(memberPasswd_a.equals(passwd_a)) {//비밀번호 답변 틀림
			map.put("result", "idDuplicated");
		}else{//비밀번호 답변 맞음
			map.put("result", "idNotFound");
		}
		
		return map;
	}
	
	
	
	
	
	
}
