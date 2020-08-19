package kr.spring.visit.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.visit.dao.VisitMapper;
import kr.spring.visit.domain.VisitCount;
import kr.spring.visit.domain.VisitVO;


@Service("VisitService")
public class VisitServiceImpl implements VisitService{
	
	@Resource
	private VisitMapper visitMapper;
	
	public String findForestName(int p_num) {
		return visitMapper.findForestName(p_num);
	}

	@Override
	public List<VisitCount> findVisitCount(int p_num, String start, String end) {
		return visitMapper.findVisitCount(p_num, start, end);
	}

	@Override
	public void insertVisit(VisitVO visit) {
		visitMapper.insertVisit(visit);
		
	}

	@Override
	public List<VisitVO> myVisitList(int mem_num) {
		return visitMapper.myVisitList(mem_num);
	}

	@Override
	public void deleteMyVisit(int v_num) {
		visitMapper.deleteMyVisit(v_num);
	}


}
