package kr.spring.pickPlace.service;

import java.util.List;

import kr.spring.pickPlace.domain.PickPlaceVO;
import kr.spring.pickPlace.domain.PickRankVO;

public interface PickPlaceService {
	
	//찜 유,무 확인
	public PickPlaceVO selectMyList(int mem_num,int p_num);
	
	//찜하기
	public void insertMyList(int mem_num,int p_num);
	
	//찜취소하기
	public void deleteMyList(int mem_num,int p_num);

	
	//찜 순위
	public List<PickRankVO> pickRankList();
	
	//나의 찜 리스트
	public List<PickPlaceVO> selectMyPickList(int mem_num);
}
