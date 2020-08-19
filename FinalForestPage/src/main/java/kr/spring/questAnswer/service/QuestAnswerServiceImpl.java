package kr.spring.questAnswer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.questAnswer.dao.QuestAnswerMapper;
import kr.spring.questAnswer.domain.QuestAnswerVO;

@Service("questAnswerService")
public class QuestAnswerServiceImpl implements QuestAnswerService{
	@Resource
	private QuestAnswerMapper questAnswerMapper;
	@Override
	public List<QuestAnswerVO> selectList(Map<String, Object> map) {
		
		return questAnswerMapper.selectList(map);
	}
	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return questAnswerMapper.selectRowCount(map);
	}
	@Override
	public void insert(QuestAnswerVO questAnswerVO) {
		questAnswerMapper.insert(questAnswerVO);
	}
	@Override
	public QuestAnswerVO selectQuest(Integer num) {
		// TODO Auto-generated method stub
		return questAnswerMapper.selectQuest(num);
	}
	@Override
	public void update(QuestAnswerVO questAnswerVO) {
		questAnswerMapper.update(questAnswerVO);
		
	}
	@Override
	public void delete(Integer num) {
		questAnswerMapper.delete(num);
		
	}
	@Override
	public String findId(int mem_num) {
		
		return questAnswerMapper.findId(mem_num);
	}
	@Override
	public List<QuestAnswerVO> QnA_list() {
		
		return questAnswerMapper.QnA_list();
	}
	@Override
	public List<QuestAnswerVO> selectListMember(Map<String, Object> map) {
		
		return questAnswerMapper.selectListMember(map);
	}
	@Override
	public int selectRowCountMember(int mem_num) {
		// TODO Auto-generated method stub
		return questAnswerMapper.selectRowCountMember(mem_num);
	}
	@Override
	public void updateHit(Integer num) {
		questAnswerMapper.updateHit(num);
		
	}
	
}
