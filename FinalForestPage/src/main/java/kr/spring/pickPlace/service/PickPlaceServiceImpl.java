package kr.spring.pickPlace.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.pickPlace.dao.PickPlaceMapper;
import kr.spring.pickPlace.domain.PickPlaceVO;
import kr.spring.pickPlace.domain.PickRankVO;


@Service("pickPlaceService")
public class PickPlaceServiceImpl implements PickPlaceService{
	
	@Resource
	private PickPlaceMapper pickPlaceMapper;
	
	@Override
	public PickPlaceVO selectMyList(int mem_num,int p_num) {
		
		return pickPlaceMapper.selectMyList(mem_num,p_num);
	}

	@Override
	public void insertMyList(int mem_num,int p_num) {
		pickPlaceMapper.insertMyList(mem_num,p_num);
		
	}

	@Override
	public void deleteMyList(int mem_num,int p_num) {
		pickPlaceMapper.deleteMyList(mem_num,p_num);
		
	}

	

	@Override
	public List<PickRankVO> pickRankList() {
		
		return pickPlaceMapper.pickRankList();
	}

	@Override
	public List<PickPlaceVO> selectMyPickList(int mem_num) {
		
		return pickPlaceMapper.selectMyPickList(mem_num);
	}

	

}
