package kr.spring.adminQuestAnswer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.adminQuestAnswer.dao.AdminQuestAnswerMapper;
import kr.spring.questAnswer.domain.QuestAnswerVO;

@Service("adminQuestAnswerService")
public class AdminQuestAnswerServiceImpl implements AdminQuestAnswerService{

	@Resource
	private AdminQuestAnswerMapper adminQuestAnswerMapper; 
	
	@Override
	public List<QuestAnswerVO> selectList(Map<String, Object> map) {

		return adminQuestAnswerMapper.selectList(map);
	}
	@Override
	public int selectRowCount(Map<String, Object> map) {

		return adminQuestAnswerMapper.selectRowCount(map);
	}
	@Override
	public QuestAnswerVO selectQuest(Integer num) {
		// TODO Auto-generated method stub
		return adminQuestAnswerMapper.selectQuest(num);
	}
	@Override
	public void delete(Integer num) {
		adminQuestAnswerMapper.delete(num);
		
	}
	@Override
	public void updateInsert(QuestAnswerVO questAnswerVO) {
		adminQuestAnswerMapper.updateInsert(questAnswerVO);
		
	}
	@Override
	public void updateUpdate(QuestAnswerVO questAnswerVO) {
		adminQuestAnswerMapper.updateUpdate(questAnswerVO);
		
	}

}
