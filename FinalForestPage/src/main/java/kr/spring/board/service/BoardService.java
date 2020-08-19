package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.domain.BoardVO;

public interface BoardService {
	public List<BoardVO> selectList(Map<String,Object> map);
	
	public int selectRowCount();
	
	public void insert (BoardVO notice);
	
	public BoardVO selectBoard(Integer num);
	
	public void updateHit(Integer num);
	
	public void update(BoardVO notice);
	
	public void delete(Integer num);
	
	public String findId(int mem_num);
}
