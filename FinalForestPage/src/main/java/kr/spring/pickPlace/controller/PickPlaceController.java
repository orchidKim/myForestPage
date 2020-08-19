package kr.spring.pickPlace.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.pickPlace.domain.PickPlaceVO;
import kr.spring.pickPlace.domain.PickRankVO;
import kr.spring.pickPlace.service.PickPlaceService;


@Controller
public class PickPlaceController {

	@Resource
	PickPlaceService pickPlaceService;

	//자비빈(VO)초기화
	@ModelAttribute
	public PickPlaceVO initCommand() {
		return new PickPlaceVO();
	}

	//로그 대상 지정
	private Logger log = Logger.getLogger(this.getClass());

	//회원제 서비스, 휴양림 상세페이지에서 특정 휴양림 찜 버튼 처리
	@RequestMapping(value="/pickPlace/pickPlace.do", method=RequestMethod.GET)
	public String insertMyList(@RequestParam("p_num") int p_num, HttpSession session) {
		int mem_num = (Integer)session.getAttribute("mem_num");

		//회원이 특정 휴양림을 여러번 찜하지 못하도록, 이전에 같은 휴양림을 찜한 내역이 있다면 지우고 다시 찜 처리
		PickPlaceVO checkMyList = null;
		checkMyList = pickPlaceService.selectMyList(mem_num,p_num);

		//회원이 특정 휴양림을 처음 찜 했을 때
		if(checkMyList == null) {
			pickPlaceService.insertMyList(mem_num,p_num);
		}else {
			//회원이 같은 휴양림을 다시 찜했을 때	
			pickPlaceService.deleteMyList(mem_num,p_num);
			pickPlaceService.insertMyList(mem_num,p_num);
		}

		//찜 처리 후, 나의 찜 리스트로 이동
		return "redirect:/pickPlace/myPickList.do";
	}

	//회원고유번호를 통한 나의 찜 리스트 출력
	@RequestMapping(value="/pickPlace/myPickList.do", method=RequestMethod.GET)
	public ModelAndView myPickList(HttpSession session){
		List<PickPlaceVO> myPickList = null;
		myPickList = pickPlaceService.selectMyPickList((Integer)session.getAttribute("mem_num"));

		ModelAndView mav = new ModelAndView();
		mav.setViewName("myPickList");
		mav.addObject("list",myPickList);
		mav.addObject("mem_num",(Integer)session.getAttribute("mem_num"));

		return mav;
	}

	//회원이 선택한 휴양림을 찜 리스트에서 삭제 
	@RequestMapping("/pickPlace/myPickListDelete.do")
	public String myPickListDelete(@RequestParam("p_num") int p_num,HttpSession session) {

		pickPlaceService.deleteMyList((Integer)session.getAttribute("mem_num"),p_num);

		return "redirect:/pickPlace/myPickList.do?mem_num="+(Integer)session.getAttribute("mem_num");
	}

	//인기 휴양림  top8  출력
	@RequestMapping("/pickPlace/pickRank.do")
	public ModelAndView pickRank() {
		List<PickRankVO> pickRankList = null;
		pickRankList = pickPlaceService.pickRankList();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("pickRank");
		mav.addObject("pickRankList",pickRankList);

		return mav;
	}
}










