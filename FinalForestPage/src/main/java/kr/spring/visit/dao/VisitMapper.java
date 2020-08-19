package kr.spring.visit.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.visit.domain.VisitCount;
import kr.spring.visit.domain.VisitVO;


public interface VisitMapper {
	
	//휴양림 고유번호를 통해 휴양림명 출력
	@Select("select p_name from placedata where p_num=#{p_num}")
	public String findForestName(int p_num);
	
	//선택 월의 1-31까지, 특정 휴양림 방문예약 현황 출력  map(날짜,인원) 반환
	@Select("select v_day, sum(v_cnt) sum_cnt from (select v_day, v_cnt from visit_place where p_num=#{p_num} and v_day between to_date(#{start}) and to_date(#{end})) group by v_day order by v_day")
	public List<VisitCount> findVisitCount(@Param(value = "p_num") int p_num, @Param(value = "start") String start, @Param(value = "end") String end);
	
	@Insert("insert into visit_place (v_num,mem_num,p_num,v_day,v_cnt) values (visit_seq.nextval,#{mem_num},#{p_num},#{v_day},#{v_cnt})")
	public void insertVisit(VisitVO visit);
	
	@Select("select v_num,mem_num,p_num,to_char(v_day,'yy/MM/dd') v_day ,v_cnt from visit_place where mem_num=#{mem_num} order by v_num desc")
	public List<VisitVO> myVisitList(int mem_num);
	
	@Delete("delete from visit_place where v_num=#{v_num}")
	public void deleteMyVisit(int v_num);
	
	
}
