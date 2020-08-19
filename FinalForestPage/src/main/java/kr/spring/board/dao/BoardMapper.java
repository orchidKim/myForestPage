package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.domain.BoardVO;

public interface BoardMapper {
	public List<BoardVO> selectList(Map<String,Object> map);
	public int selectRowCount();
	
	@Insert("INSERT INTO notice (n_num,n_title,notice,mem_num) "
			+ "VALUES(notice_seq.nextval,#{n_title},#{notice},#{mem_num})")
	public void insert (BoardVO notice);
	
	@Select("SELECT * FROM notice b JOIN member m ON b.mem_num=m.mem_num WHERE b.n_num=#{n_num}")
	public BoardVO selectBoard(Integer num);
	
	@Update("UPDATE notice SET n_hit=n_hit+1 WHERE n_num=#{n_num}")
	public void updateHit(Integer num);
	
	@Update("UPDATE notice SET n_title=#{n_title},notice=#{notice},modify_date=SYSDATE WHERE n_num=#{n_num}")
	public void update(BoardVO notice);
	
	@Delete("DELETE FROM notice WHERE n_num=#{n_num}")
	public void delete(Integer num);
	
	@Select("select id from member where mem_num=#{mem_num}")
	public String findId(int mem_num);
}