package kr.spring.questAnswer.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.questAnswer.domain.QuestAnswerVO;

public interface QuestAnswerService {
	public String findId(int mem_num);
	public List<QuestAnswerVO> QnA_list();	
	public void updateHit(Integer num);
	
	public int selectRowCount(Map<String,Object> map);
	public List<QuestAnswerVO> selectList(Map<String,Object> map);
	
	public int selectRowCountMember(int mem_num);
	public List<QuestAnswerVO> selectListMember(Map<String,Object> map);
	
	public void insert(QuestAnswerVO questAnswerVO);
	public QuestAnswerVO selectQuest(Integer num);
	public void update(QuestAnswerVO questAnswerVO);
	public void delete(Integer num);
	

}
