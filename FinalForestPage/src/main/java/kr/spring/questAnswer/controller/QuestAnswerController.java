package kr.spring.questAnswer.controller;

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

import kr.spring.questAnswer.domain.QuestAnswerVO;
import kr.spring.questAnswer.service.QuestAnswerService;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class QuestAnswerController {

	@Resource
	private QuestAnswerService questAnswerService;
	
	private Logger log = Logger.getLogger(this.getClass());
	private int rowCount = 10;
	private int pageCount = 10;
	
	//자바빈(VO)초기화
	@ModelAttribute 
	public QuestAnswerVO initCommand() {
		return new QuestAnswerVO();
	}
	
	//목록
	@RequestMapping("/qna/questAnswerList.do")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentpage,
								@RequestParam(value="keyfield",defaultValue="") String keyfield,
								@RequestParam(value="keyword",defaultValue="") String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//게시판의 총 레코드수 또는 검색 레코드수 반환
		int count = questAnswerService.selectRowCount(map);
		
		if(log.isDebugEnabled()) {
			log.debug("<<count>>" + count);
		
		}
		
		//페이징처리
		PagingUtil page = new PagingUtil(currentpage, count, rowCount, pageCount, "questAnswerList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<QuestAnswerVO> list = null;
			if(count > 0) {
				list = questAnswerService.selectList(map);
			}
			if(log.isDebugEnabled()) {
				log.debug("<<QuestAnswerVO>>" + list);
			}
			
		ModelAndView mav = new ModelAndView();
		mav.setViewName("questAnswerList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml",page.getPagingHtml());
	
		return mav;
	}
	
	//글쓰기
	@RequestMapping(value="/qna/questAnswerWrite.do",method=RequestMethod.GET)
	public String form() {
		return "questAnswerWrite";
	}
	
	//글쓰기 처리 
	@RequestMapping(value="/qna/questAnswerWrite.do",method=RequestMethod.POST)
	public String submit(@Valid QuestAnswerVO questAnswerVO,
								BindingResult result,
								HttpSession session) {
		
		if(log.isDebugEnabled()) {
			log.debug("<<QuestAnswer>>" + questAnswerVO);
		}
		if(session.getAttribute("mem_num")!=null) {
		//System.out.println((Integer)session.getAttribute("mem_num"));
		}
		questAnswerVO.setMem_num((Integer)session.getAttribute("mem_num"));
		//글 등록
		questAnswerService.insert(questAnswerVO);
		
		
		return "redirect:/qna/questAnswerList.do";
	}
	
	//글 상세
	@RequestMapping("/qna/questAnswerDetail.do")
	public ModelAndView detail(@RequestParam("num") int num) {

		//로그 표시
		if(log.isDebugEnabled()) {
			log.debug("<<num>>" + num);
		}
		
		//조회수 증가
		questAnswerService.updateHit(num);
		
		QuestAnswerVO questAnswerVO = questAnswerService.selectQuest(num);
		questAnswerVO.setQuestion(StringUtil.useBrNoHtml(questAnswerVO.getQuestion()));
		
		return new ModelAndView("questAnswerDetail","questAnswerVO",questAnswerVO);
	}
	
	//글 수정
	//글 수정 폼 호출
		@RequestMapping(value="/qna/update.do", method=RequestMethod.GET)
		public String form(@RequestParam("num") int num, Model model) {
			
			QuestAnswerVO questAnswerVO = questAnswerService.selectQuest(num);
			questAnswerVO.setQuestion(StringUtil.useBrNoHtml(questAnswerVO.getQuestion()));
			
			model.addAttribute("questAnswerVO", questAnswerVO);
			
			return "questAnswerModify";
		}

		//글 수정 처리
		@RequestMapping(value="/qna/update.do", method=RequestMethod.POST)
		public String submitUpdate(@Valid QuestAnswerVO questAnswerVO) {
			
			//로그 표시
			if(log.isDebugEnabled()) {
				log.debug("<<questAnswerVO>> : " + questAnswerVO);
			}

			questAnswerService.update(questAnswerVO);
			
			return "redirect:/qna/questAnswerList.do";
		}
		
	//글 삭제 
	
		@RequestMapping("/qna/delete.do")
		public String submit(@RequestParam("num") int num) {
			
			//로그 표시
			if(log.isDebugEnabled()) {
				log.debug("<<num>> : " + num);
			}
			
			//글 삭제
			questAnswerService.delete(num);
			
			return "redirect:/qna/questAnswerList.do";
		}
	
	//나의 QnA리스트	
		@RequestMapping("/qna/questAnswerMemberList.do")
		public ModelAndView q_memberProcess(@RequestParam(value="pageNum",defaultValue="1")int currentpage,
															HttpSession session) {
			
			Map<String,Object> map = new HashMap<String,Object>();
			
			//회원의 총 레코드수  반환
			int count = questAnswerService.selectRowCountMember((Integer)session.getAttribute("mem_num"));
			
			if(log.isDebugEnabled()) {
				log.debug("<<count>>" + count);
			}
			
			//페이징처리
			PagingUtil page = new PagingUtil(currentpage, count, rowCount, pageCount, "questAnswerMemberList.do");
			map.put("mem_num", (Integer)session.getAttribute("mem_num"));
			map.put("start", page.getStartCount());
			map.put("end", page.getEndCount());
			
			List<QuestAnswerVO> list = null;
				if(count > 0) {
					list = questAnswerService.selectListMember(map);
				}
				if(log.isDebugEnabled()) {
					log.debug("<<QuestAnswerVO>>" + list);
				}
				
			ModelAndView mav = new ModelAndView();
			mav.setViewName("questAnswerMemberList");
			mav.addObject("count",count);
			mav.addObject("list",list);
			mav.addObject("pagingHtml",page.getPagingHtml());
		
			return mav;
		}

}		