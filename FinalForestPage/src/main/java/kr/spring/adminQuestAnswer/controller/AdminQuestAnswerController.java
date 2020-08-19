package kr.spring.adminQuestAnswer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.adminQuestAnswer.service.AdminQuestAnswerService;
import kr.spring.questAnswer.domain.QuestAnswerVO;
import kr.spring.util.PagingUtil;

@Controller
public class AdminQuestAnswerController {

	@Resource
	private AdminQuestAnswerService adminQuestAnswerService;

	private Logger log = Logger.getLogger(this.getClass());
	private int rowCount = 10;
	private int pageCount = 10;

	//자바빈(VO)초기화
	@ModelAttribute 
	public QuestAnswerVO initCommand() {
		return new QuestAnswerVO();
	}

	//목록
	@RequestMapping("/adminQna/adminQuestAnswerList.do")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1")int currentpage,
								@RequestParam(value="keyfield",defaultValue="") String keyfield,
								@RequestParam(value="keyword",defaultValue="") String keyword) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//게시판의 총 레코드수 또는 검색 레코드수 반환
		int count = adminQuestAnswerService.selectRowCount(map);

		if(log.isDebugEnabled()) {
			log.debug("<<listcount>>" + count);

		}

		//페이징처리
		PagingUtil page = new PagingUtil(currentpage, count, rowCount, pageCount, "adminQuestAnswerList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());

		List<QuestAnswerVO> list = null;
		if(count > 0) {
			list = adminQuestAnswerService.selectList(map);
		}
		if(log.isDebugEnabled()) {
			log.debug("<<adminQuestAnswerVO>>" + list);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminQuestAnswerList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml",page.getPagingHtml());

		return mav;
	}

	//문의글 상세
	//글 수정 처리
			@RequestMapping(value="/adminQna/update.do", method=RequestMethod.POST)
			public String submitUpdate(@Valid QuestAnswerVO questAnswerVO,
										@RequestParam(value="updateInsert",defaultValue="updateUpdate")String name) {

				//로그 표시
				if(log.isDebugEnabled()) {
					log.debug("<<updateinsert>> : " + questAnswerVO);
					log.debug("<<name>> : " + name);
				}
	
				
				if(name=="updateInsert") {
					adminQuestAnswerService.updateInsert(questAnswerVO);
					return "redirect:/adminQna/adminQuestAnswerDetail.do?num="+questAnswerVO.getQ_num();
				}else {
					adminQuestAnswerService.updateUpdate(questAnswerVO);
					return "redirect:/adminQna/adminQuestAnswerDetail.do?num="+questAnswerVO.getQ_num();
				}
			}
	
	
	//글 상세
		@RequestMapping("/adminQna/adminQuestAnswerDetail.do")
		public ModelAndView detail(@RequestParam("num") int num) {

			//로그 표시
			if(log.isDebugEnabled()) {
				log.debug("<<adminQuestAnswerDetail>>" + num);
			}
			
			QuestAnswerVO questAnswerVO = adminQuestAnswerService.selectQuest(num);
			
			return new ModelAndView("adminQuestAnswerDetail","questAnswerVO",questAnswerVO);
		}
	
	
	//체크박스 글 삭제
	@RequestMapping(value="/adminQna/delete.do", method=RequestMethod.GET)
	public String submit(@RequestParam(value="q_num", defaultValue="") Integer[] num) {

		//로그 표시
		if(log.isDebugEnabled()) {
			log.debug("<<deletenum>> : " + num);

		}
		
		if(num.length>0) {
			for(int i=0;i<num.length;i++) {
				adminQuestAnswerService.delete(num[i]);
			}
			return "redirect:/adminQna/adminQuestAnswerList.do";
		}else{
			
			return "redirect:/adminQna/adminQuestAnswerList.do";
			
		}
	}
	
	//상세 글 삭제
	
	
	
	
}
