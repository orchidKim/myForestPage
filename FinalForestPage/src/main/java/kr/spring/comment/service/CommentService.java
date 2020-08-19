package kr.spring.comment.service;

import java.util.List;
import java.util.Map;

import kr.spring.comment.domain.CommentVO;


public interface CommentService {
	//회원 고유번호를통한 아이디 검색
	public String findId(int mem_num);

	//휴양림별 댓글 리스트
	public List<CommentVO> selectCommentList(int p_num);

	//휴양림별 댓글 총 카운트
	public int selectCommentListCount(int p_num);

	//댓글 입력
	public void insertComment(CommentVO comment);

	//댓글 삭제
	public void deleteComment(int c_num);

	//전체 댓글 리스트 (관리자 영역)
	public List<CommentVO> allCommentList();

	//전체 댓글 카운트 (관리자 영역)
	public int allCommentListCount();

	//페이징 처리가 포함된 후기댓글 리스트 출력
	public int selectRowCount(Map<String, Object> map);
	public List<CommentVO> commentList(Map<String, Object> map);

}
