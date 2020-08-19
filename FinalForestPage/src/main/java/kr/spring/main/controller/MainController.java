package kr.spring.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.domain.BoardVO;
import kr.spring.board.service.BoardService;
import kr.spring.pickPlace.domain.PickRankVO;
import kr.spring.pickPlace.service.PickPlaceService;
import kr.spring.questAnswer.domain.QuestAnswerVO;
import kr.spring.questAnswer.service.QuestAnswerService;

@Controller
public class MainController {

	@Resource
	PickPlaceService pickPlaceService;

	@Resource
	private QuestAnswerService questAnswerService;

	@Resource
	private BoardService noticeService;

	@RequestMapping("/main/main.do")
	public ModelAndView process() {
		ModelAndView mav = new ModelAndView();

		List<PickRankVO> pickRankList = null;
		pickRankList = pickPlaceService.pickRankList();

		List<QuestAnswerVO> qnaList = null;
		qnaList = questAnswerService.QnA_list();
		
		for(QuestAnswerVO tmp : qnaList) {
			tmp.setId(questAnswerService.findId(tmp.getMem_num()));
		}

		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 5);

		List<BoardVO> boarList = null;
		boarList = noticeService.selectList(map);

		mav.setViewName("main");
		mav.addObject("pickRankList",pickRankList);
		mav.addObject("qnaList",qnaList);
		mav.addObject("boarList",boarList);

		return mav; 
	}
}
