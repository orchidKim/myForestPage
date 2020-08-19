package kr.spring.comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.comment.domain.CommentVO;
import kr.spring.member.domain.MemberVO;


public interface CommentMapper {
	//회원 고유번호를통한 아이디 검색
	@Select("select id from member where mem_num=#{mem_num}")
	public String findId(int mem_num);
	
	//휴양림별 댓글 리스트
	@Select("SELECT * FROM place_comment WHERE p_num=#{p_num} order by reg_date desc")
	public List<CommentVO> selectCommentList(int p_num);

	//휴양림별 댓글 총 카운트
	@Select("SELECT COUNT(*) FROM place_comment WHERE p_num=#{p_num}")
	public int selectCommentListCount(int p_num);

	//댓글 입력
	@Insert("INSERT INTO place_comment (C_NUM,P_NUM,MEM_NUM,COMMENTS) VALUES (comment_seq.nextval,#{p_num},${mem_num},#{comments})")
	public void insertComment(CommentVO comment);

	//댓글 삭제
	@Delete("DELETE FROM place_comment WHERE c_num=#{c_num}")
	public void deleteComment(int c_num);

	//전체 댓글 리스트 (관리자 영역)
	@Select("select * from place_comment order by reg_date desc")
	public List<CommentVO> allCommentList();

	//전체 댓글 카운트 (관리자 영역)
	@Select("SELECT COUNT(*) FROM place_comment")
	public int allCommentListCount();


	//페이징 처리가 포함된 후기댓글 리스트 출력
	public int selectRowCount(Map<String, Object> map);
	public List<CommentVO> commentList(Map<String, Object> map);

}








