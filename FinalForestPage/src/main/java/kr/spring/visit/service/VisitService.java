package kr.spring.visit.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import kr.spring.visit.domain.VisitCount;
import kr.spring.visit.domain.VisitVO;


public interface VisitService {
	public String findForestName(int p_num);
	public List<VisitCount> findVisitCount(int p_num, String start, String end);
	public void insertVisit(VisitVO visit);
	public List<VisitVO> myVisitList(int mem_num);
	public void deleteMyVisit(int v_num);
}
