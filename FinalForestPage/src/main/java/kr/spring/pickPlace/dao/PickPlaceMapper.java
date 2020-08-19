package kr.spring.pickPlace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.pickPlace.domain.PickPlaceVO;
import kr.spring.pickPlace.domain.PickRankVO;


public interface PickPlaceMapper {
	//찜 유,무 확인
	@Select("SELECT * FROM my_list WHERE mem_num=#{mem_num} AND p_num=#{p_num}")
	public PickPlaceVO selectMyList(@Param(value="mem_num")int mem_num,@Param(value="p_num")int p_num);

	//찜하기
	@Insert("INSERT INTO my_list (mem_num,p_num) VALUES (#{mem_num},#{p_num})")
	public void insertMyList(@Param(value="mem_num")int mem_num,@Param(value="p_num")int p_num);

	//찜취소하기
	@Delete("DELETE FROM my_list WHERE mem_num=#{mem_num} AND p_num=#{p_num}")
	public void deleteMyList(@Param(value="mem_num")int mem_num,@Param(value="p_num")int p_num);

	//찜 순위
	@Select("SELECT p.p_num, p.p_name, p.p_img, r.rank FROM placedata p JOIN (select * from (select p_num, count(p_num) rank from my_list group by p_num) where rownum<=8) r ON p.p_num=r.p_num order by rank desc") 
	public List<PickRankVO> pickRankList();

	//나의 찜 목록																				
	@Select("SELECT p.p_name,p.p_num FROM placedata p JOIN (select * from my_list where mem_num=#{mem_num}) r ON p.p_num=r.p_num")
	public List<PickPlaceVO> selectMyPickList(int mem_num);
}


















