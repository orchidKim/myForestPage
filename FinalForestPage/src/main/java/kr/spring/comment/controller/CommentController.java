package kr.spring.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.comment.domain.CommentVO;
import kr.spring.comment.service.CommentService;
import kr.spring.member.domain.MemberVO;
import kr.spring.member.service.MemberService;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class CommentController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource
	private CommentService commentService;
	
	@Resource
	MemberService memberService;
	
	private int rowCount = 10;
	private int pageCount = 10;

	@ModelAttribute
	public CommentVO initCommand() {
		return new CommentVO();
	}

	//댓글  입력(submit) 후 등록 처리
	@RequestMapping(value="/comment/writeComment.do",method=RequestMethod.POST)
	public String commentInsert(CommentVO commentVO){
		commentVO.setId(commentService.findId(commentVO.getMem_num()));
		commentService.insertComment(commentVO);

		return "redirect:/forest/forestDetail.do?p_num="+commentVO.getP_num();
	}

	//관리자 페이지 진입 후, 전체 댓글 리스트 추출
	@RequestMapping("/admin/adminCommentList.do")
	public ModelAndView adminForestList(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="") String keyfield,
			@RequestParam(value="keyword",defaultValue="") String keyword) {
		
		Map<String,Object>map = new HashMap<String,Object>();
		
		/*System.out.println("검색필드 : "+keyfield+", 검색단어 : "+keyword);*/
		
		//아이디 필드로 검색한 경우 해당 아이디를 회원고유번호로 변경 후 검색처리
		if(keyfield.equals("mem_num")) {
			//System.out.println("검색단어(아이디) : "+keyword);
			//검색 아이디에 해당하는 객체 출력
			MemberVO memberVO = memberService.selectCheckMember(keyword); 
			
			//검색한 아이디의 객체가 존재하면 해당 아이디의 고유번호를 출력
			if(memberVO != null) {
				keyword = Integer.toString(memberVO.getMem_num());
				//System.out.println("검색단어(회원고유번호) : "+keyword);
			}else {
				keyword ="";
			}
			
		}
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		
		
		int count = commentService.selectRowCount(map);
				
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,rowCount,pageCount,"adminCommentList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<CommentVO> commentList = null;
		
		if(count > 0) {
			commentList = commentService.commentList(map);
		}

		//회원번호를 통한 아이디 세팅
		if(count > 0) {
			for(CommentVO commentVO : commentList) {
				commentVO.setComments(StringUtil.useBrNoHtml(commentVO.getComments()));
				commentVO.setId(commentService.findId(commentVO.getMem_num()));
			}
		}
		

		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminCommentList");
		mav.addObject("count",count);
		mav.addObject("commentList",commentList);
		mav.addObject("pagingHtml",page.getPagingHtml());

		return mav;
	}

	//관리자의 댓글 삭제 처리, 삭제 후 관리자 댓글 리스트로 이동
	@RequestMapping(value="/admin/commentDeleteAdmin.do",method=RequestMethod.GET)
	public String commentDeleteAdmin(@RequestParam(value="c_num",defaultValue="") int[] c_num) {

		//로그 표시
		if(log.isDebugEnabled()) {
		log.debug("<<delete_c_num>> : " + c_num);
		}
		//글 삭제
		if(c_num.length>0) {
			for(int i=0;i<c_num.length;i++) {
				commentService.deleteComment(c_num[i]);
			}
			return "redirect:/admin/adminCommentList.do";
		}else
		return "redirect:/admin/adminCommentList.do";
	}

	//회원의 댓글 삭제 처리, 삭제 후 이전 페이지로 이동
	@RequestMapping(value="/comment/commentDeleteUser.do",method=RequestMethod.GET)
	public String commentDeleteUser(@RequestParam("c_num") int c_num,
										@RequestParam("p_num") int p_num) {

		commentService.deleteComment(c_num);
		return "redirect:/forest/forestDetail.do?p_num="+p_num;
	}



}
