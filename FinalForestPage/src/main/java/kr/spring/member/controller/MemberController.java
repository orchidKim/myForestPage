package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.domain.MemberVO;
import kr.spring.member.service.MemberService;
import kr.spring.util.AuthCheckException;
import kr.spring.util.PagingUtil;

@Controller
public class MemberController {

	//로그 대상 지정
	private Logger log = Logger.getLogger(this.getClass());

	@Resource
	MemberService memberService;

	//자바빈 초기화(유효성 체크 할때 필요)
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}


	//회원가입 폼 호출
	@RequestMapping(value="/member/register.do", method=RequestMethod.GET)
	public String form() {
		return "memberRegister";
	}

	//회원가입 처리
	@RequestMapping(value="/member/register.do", method=RequestMethod.POST)
	public String submit(@Valid MemberVO memberVO, BindingResult result) {		
		if(log.isDebugEnabled()) {
			log.debug("<<MemberVO>> : "+memberVO);
		}		
		//유효성 체크 결과 에러가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}		

		//회원가입
		memberService.insert(memberVO);	
		return "redirect:/main/main.do";
	}


	//로그인 폼 호출
	@RequestMapping(value="/member/login.do", method=RequestMethod.GET)
	public String formLogin() {
		return "memberLogin";
	}

	//로그인 처리
	@RequestMapping(value="/member/login.do",method=RequestMethod.POST)
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session) {

		//id와 비밀번호만 유효성체크하고,체크결과 에러가 있으면 폼을 호출
		if(result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return formLogin();
		}

		//로그인 체크
		try {
			MemberVO member = memberService.selectCheckMember(memberVO.getId());
			boolean check = false;
			
			//입력받은 아이디와 비밀번호의 계정이 존재하지 않는 경우
			if(member==null) {
				check = false;
				result.reject("invalidIdOrPasswd");
				return formLogin();
			}
 
			if(member.getAuth() == 1) {
				check = false;
				result.reject("AuthOneOrZero");
				return formLogin();
			}

			if(member.getAuth() == 0) {
				check = false;
				result.reject("AuthOneOrZero");
				return formLogin();
			}

			if(member!=null) {
				//아이디가 있을 경우,비밀번호 체크
				check = member.isCheckedPasswd(memberVO.getPasswd());
			}

			if(check) {//로그인 성공
				session.setAttribute("user_id", member.getId());
				session.setAttribute("mem_num", member.getMem_num());
				session.setAttribute("user_auth", member.getAuth());

				//관리자는 로그인 후 관리자 페이지로 이동
				if(member.getAuth()==3) {
					return "adminList";
				}
				return "redirect:/main/main.do";

			}else {//로그인 실패
				throw new AuthCheckException();
			}
		}catch(AuthCheckException e){//로그인 실패시 에러코드를 지정하고 폼을 호출
			result.reject("invalidIdOrPasswd");
			return formLogin();
		}		
	}


	//로그아웃
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session) {
		session.invalidate();//로그아웃 처리
		return "redirect:/main/main.do";
	}


	//회원상세정보
	@RequestMapping("/member/detail.do")
	public String process(HttpSession session, Model model) {
		//세션에 저장되있는 mem_num 반환
		//스프링에선 인터셉터가 로그인 되있는지 아닌지 별도로 확인해줌
		int mem_num = (Integer)session.getAttribute("mem_num");
		MemberVO member = memberService.selectMember(mem_num);

		model.addAttribute("member",member);
		return "memberView";
	}

	//회원정보 수정 폼
	@RequestMapping(value="/member/update.do",method=RequestMethod.GET)
	public String formUpdate(HttpSession session, Model model) {
		//세션에 저장되있는 mem_num 반환
		int mem_num = (Integer)session.getAttribute("mem_num");
		MemberVO memberVO = memberService.selectMember(mem_num);
		model.addAttribute("memberVO",memberVO);//model에 저장하면 리퀘스트에도 저장해줌
		return "memberModify";
	}

	//회원정보 수정 처리
	@RequestMapping(value="/member/update.do",method=RequestMethod.POST)
	public String submitUpdate(@Valid MemberVO memberVO, BindingResult result) {

		//로그 표시
		if(log.isDebugEnabled()) {
			log.debug("<<MemberVO>> : "+memberVO);
		}

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("passwd") || result.hasFieldErrors("name") || result.hasFieldErrors("email") || result.hasFieldErrors("phone") || 
				result.hasFieldErrors("address") || result.hasFieldErrors("passwd_q")  || result.hasFieldErrors("passwd_a")) {
			return "memberModify";
		}		

		//회원정보 수정
		memberService.update(memberVO);		
		return "redirect:/member/detail.do";
	}


	//비밀번호 찾기 - 아이디 입력 폼 
	@RequestMapping(value="/member/findPasswordId.do",method=RequestMethod.GET)
	public String formFindPasswordId() {
		return "memberFindPasswordId";
	}

	//비밀번호 찾기 - 비밀번호 찾기 질문 답변 폼
	@RequestMapping(value="/member/findPasswordId.do",method=RequestMethod.POST)
	public String formFindPasswordId(@Valid MemberVO memberVO, BindingResult result,Model model) {

		//로그 표시
		if(log.isDebugEnabled()) {log.debug("<<MemberVO>> : "+memberVO);}

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("id")) {
			return "memberFindPasswordId";
		}

		//인자로 받은 id로 해당 멤버의 MemberVO 반환받음
		String id = memberVO.getId();
		MemberVO member = memberService.selectCheckMember(id);	
		model.addAttribute("member",member);

		return "memberFindPassword";
	}



	//회원탈퇴 폼
	@RequestMapping(value="/member/delete.do",method=RequestMethod.GET)
	public String formDelete(HttpSession session, Model model) {
		int mem_num = (Integer)session.getAttribute("mem_num");
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_num(mem_num);
		model.addAttribute("memberVO",memberVO);
		return "memberDelete";
	}

	//회원탈퇴 처리
	@RequestMapping(value="/member/delete.do",method=RequestMethod.POST)
	public String submitDelete(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model) {

		//로그 표시
		if(log.isDebugEnabled()) {log.debug("<<MemberVO>> : "+memberVO);}

		//비밀번호만 유효성 체크,체크결과 에러가 있으면 폼 호출
		if(result.hasFieldErrors("passwd")) {
			return "memberDelete";
		}

		//비밀번호 인증
		try {
			//hidden로 넘긴 mem_num을 반환받음	
			MemberVO member = memberService.selectMember(memberVO.getMem_num());
			boolean check = false;
			if(member!=null) {
				check = member.isCheckedPasswd(memberVO.getPasswd());
			}
			if(check) {//비밀번호 인증 성공,회원탈퇴
				memberService.delete(memberVO.getMem_num());
				session.invalidate();//로그아웃 처리
				return "redirect:/main/main.do";
			}else {//비밀번호 인증 실패
				throw new AuthCheckException();
			}
		}catch(AuthCheckException e){
			//비밀번호 인증 실패시 에러 코드 지정하고 폼 호출
			result.rejectValue("passwd", "invalidPasswd");
			return "memberDelete";
		}

	}




	//-----------------------------------------------member 관리자---------------------------------------------------//


	//관리자 회원관리 페이지
	private int rowCount = 10;
	private int pageCount = 10;

	@RequestMapping(value="/admin/memberList.do", method=RequestMethod.GET)
	public ModelAndView memberList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, 
			@RequestParam(value="keyfield",defaultValue="") String keyfield,
			@RequestParam(value="keyword",defaultValue="") String keyword) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//게시판의 총 레코드 수 또는 검색 레코드 수 반환
		int count = memberService.selectRowCount(map);

		if(log.isDebugEnabled()) {log.debug("<<회원수>> : "+count);}

		//페이징 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,rowCount,pageCount,"memberList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());	

		List<MemberVO> list = null;
		if(count>0) {
			list = memberService.memberList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml",page.getPagingHtml());

		return mav;
	}



	//회원 권한 변경 (관리자) : 2(일반회원) -> 1(정지회원)
	@RequestMapping(value="/admin/authToOne.do", method=RequestMethod.GET)
	public String authToOne(@RequestParam("mem_num") Integer[] mem_num) {
		if(mem_num.length>0) {
				for(int i=0;i<mem_num.length;i++) {
					memberService.authToOne(mem_num[i]);
				}
			return "redirect:/admin/memberList.do";
		}else {
			return "redirect:/admin/memberList.do";
		}
	}

	//회원 권한 변경 (관리자) : 1(정지회원) -> 2(일반회원)
	@RequestMapping(value="/admin/authToTwo.do", method=RequestMethod.GET)
	public String authToTwo(@RequestParam("mem_num") Integer[] mem_num) {
		
		if(mem_num.length>0) {
			for(int i=0;i<mem_num.length;i++) {
				memberService.authToTwo(mem_num[i]);
			}
			return "redirect:/admin/memberList.do";
		}else {		
			return "redirect:/admin/memberList.do";
		}
	}

}









