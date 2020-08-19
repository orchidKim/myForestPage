package kr.spring.forest.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.forest.dao.ForestMapper;
import kr.spring.forest.domain.ForestVO;

@Service("ForestService")
public class ForestServiceImpl implements ForestService{

	@Resource
	private ForestMapper forestMapper;
	
	@Override
	public void insertForest(ForestVO forest) {
		forestMapper.insertForest(forest);
		
	}

	@Override
	public void deleteForest(int p_num) {
		forestMapper.deleteForest(p_num);
		
	}

	@Override
	public void updateForest(ForestVO forest) {
		forestMapper.updateForest(forest);
		
	}

	@Override
	public ForestVO selectForest(int p_num) {
		return forestMapper.selectForest(p_num);
		
	}

	@Override
	public List<ForestVO> selectForestList(String location) {
		return forestMapper.selectForestList(location);
		
	}

	@Override
	public int selectForestListCount(String location) {
		return forestMapper.selectForestListCount(location);
	}

	@Override
	public List<ForestVO> allForestList() {
		return forestMapper.allForestList();
	}

	@Override
	public int allForestListCount() {
		return forestMapper.allForestListCount();
	}

	@Override
	public List<ForestVO> selectList(Map<String, Object> map) {
		return forestMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return forestMapper.selectRowCount(map);
	}



	

}
