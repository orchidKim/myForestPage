package kr.spring.adminQuestAnswer.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.questAnswer.domain.QuestAnswerVO;

public interface AdminQuestAnswerMapper {
	
	public List<QuestAnswerVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	/*@Insert("INSERT INTO qna(q_num,q_title,question,mem_num) VALUES (qna_seq.nextval,#{q_title},#{question},#{mem_num})")
	public void insert(QuestAnswerVO questAnswerVO);*/
	@Select("SELECT * FROM qna q JOIN member m ON q.mem_num = m.mem_num WHERE q_num = #{num}") 
	public QuestAnswerVO selectQuest(Integer num);
	public void updateInsert(QuestAnswerVO questAnswerVO);
	public void updateUpdate(QuestAnswerVO questAnswerVO);
	@Delete("DELETE FROM qna WHERE q_num=#{num}")
	public void delete(Integer num);	
	
}
