package kr.spring.forest.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.forest.domain.ForestVO;

public interface ForestService {
	//휴양림 등록
	public void insertForest(ForestVO forest);

	//특정 휴양림 삭제
	public void deleteForest(int p_num);

	//특정 휴양림 수정
	public void updateForest(ForestVO forest);

	//특정 휴양림 상세보기
	public ForestVO selectForest(int p_num);

	//지역별 휴양림 리스트
	public List<ForestVO> selectForestList(String location);

	//선택 지역 휴양림 총 카운트
	public int selectForestListCount(String location);

	//전국 휴양림 리스트
	public List<ForestVO> allForestList();

	//전국 휴양림 총 카운트
	public int allForestListCount();

	//페이징 처리를 위한 휴양림 리스트 출력
	public List<ForestVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);


}
