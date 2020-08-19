package kr.spring.visit.controller;


import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.forest.domain.ForestVO;
import kr.spring.visit.domain.VisitCount;
import kr.spring.visit.domain.VisitVO;
import kr.spring.visit.service.VisitService;

@Controller
public class VisitController {

	@Resource
	private VisitService visitService;

	@ModelAttribute
	public VisitVO initCommand() {
		return new VisitVO();
	}

	//휴양림 상세에서 년,월 선택 후 해당 월 방문예약 현황 페이지로 이동
	@RequestMapping(value="/visit/bookVisitDay.do",method=RequestMethod.POST)
	public ModelAndView bookVisitDayForm(VisitVO visitVO, HttpSession session) {
		
		//날짜(년,월) 포맷 변경 2020-07 -> 20/07
		visitVO.setV_day(visitVO.getV_day().replace("-", "/").substring(2));

		//휴양림 고유번호로 휴양림명 출력
		String p_name = visitService.findForestName(visitVO.getP_num());

		//20/07 -> 20/07/01, 20/07/28
		String start = visitVO.getV_day().toString()+"/01";
		String end = visitVO.getV_day().toString()+"/28";

		List<VisitCount> visitCountList = null;
		visitCountList = visitService.findVisitCount(visitVO.getP_num(), start, end);
		
		int avg = 0;
		int sum = 0;
		
		//선택 휴양림의 예약내역이 존재하는 경우, 평균 예약인원 계산
		if(visitCountList.size() != 0) {
			for(VisitCount vc : visitCountList) {
				sum += vc.getSum_cnt();
			}
			avg = sum/visitCountList.size();
		}
		

		String year = visitVO.getV_day().toString().split("/")[0];
		String month = visitVO.getV_day().toString().split("/")[1];
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("bookVisitDay");
		mav.addObject("p_name",p_name);
		mav.addObject("visit",visitVO);
		mav.addObject("year",year);
		mav.addObject("month",month);
		mav.addObject("avg",avg);
		mav.addObject("visitCountList",visitCountList);

		return mav;
	}

	//예약 처리
	@RequestMapping(value="/visit/insertVisit.do",method=RequestMethod.POST)
	public String bookInsert(VisitVO visitVO) {
		//예약 정보 등록
		visitService.insertVisit(visitVO);
		
		return "redirect:/visit/myBookList.do";
	}

	//회원의 예약 상세
	@RequestMapping(value="/visit/myBookList.do",method=RequestMethod.GET)
	public ModelAndView myBookList(HttpSession session) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("myBookList");

		List<VisitVO> myVisitList = visitService.myVisitList((Integer)session.getAttribute("mem_num"));

		//visitVO 휴양림 고유번호를 통한 휴양림명 세팅
		for(VisitVO tmp : myVisitList) {
			tmp.setP_name(visitService.findForestName(tmp.getP_num()));
		}

		mav.addObject("myVisitList",myVisitList);

		return mav;
	}

	//선택 방문예약 행 삭제
	@RequestMapping(value="/visit/visitDelete.do",method=RequestMethod.GET)
	public String forestDelete(@RequestParam("v_num") int v_num) {
								
		visitService.deleteMyVisit(v_num);

		return "redirect:/main/main.do";
	}


}
