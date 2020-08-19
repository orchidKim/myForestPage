package kr.spring.questAnswer.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.questAnswer.domain.QuestAnswerVO;

public interface QuestAnswerMapper {
	
	//Q&A 전체 개수 구하기
	public int selectRowCount(Map<String,Object> map);
	//Q&A 전체 문의 구하기
	public List<QuestAnswerVO> selectList(Map<String,Object> map);
	//조회수증가
	@Update("UPDATE qna SET q_hit=q_hit+1 WHERE q_num=#{q_num}")
	public void updateHit(Integer num);
	
	//나의 문의내역 개수 구하기
	@Select("SELECT COUNT(*) FROM qna q JOIN member m ON q.mem_num = m.mem_num WHERE m.mem_num = #{mem_num}")
	public int selectRowCountMember(int mem_num);
	//나의 문의내역
	public List<QuestAnswerVO> selectListMember(Map<String,Object> map);
	
	//문의 등록하기요
	@Insert("INSERT INTO qna(q_num,q_title,question,mem_num) VALUES (qna_seq.nextval,#{q_title},#{question},#{mem_num})")
	public void insert(QuestAnswerVO questAnswerVO);
	//문의 상세내역
	@Select("SELECT * FROM qna q JOIN member m ON q.mem_num = m.mem_num WHERE q_num = #{num}") 
	public QuestAnswerVO selectQuest(Integer num);
	//문의 수정하기
	public void update(QuestAnswerVO questAnswerVO);
	//문의 삭제하기
	@Delete("DELETE FROM qna WHERE q_num=#{num}")
	public void delete(Integer num);
	
	//main controller에서  Q&A 정보를 출력하기 위한 고객번호 찾기
	@Select("select id from member where mem_num=#{mem_num}")
	public String findId(int mem_num);
	//메인페이지 문의리스트 
	@Select("SELECT * FROM (SELECT * FROM  QNA ORDER BY q_num desc)  WHERE rownum <= 5")
	public List<QuestAnswerVO> QnA_list();
	
}
