package kr.spring.forest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.domain.BoardVO;
import kr.spring.forest.domain.ForestVO;

public interface ForestMapper {
	//페이징 처리를 위한 휴양림 리스트 출력
	public List<ForestVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//휴양림 등록
	@Insert("insert into placedata (P_NUM,P_NAME,P_CITY,P_DIV,P_SIZE,P_COUNT,P_COST,P_STAY,P_FACILITY,P_LOAD,P_PUBNUM,P_PHONE,P_WEB,P_LATITUDE,P_LONGITUDE,P_REGDATE,P_CODE,P_PUBNAME,P_IMG) "
			+ "values (place_seq.nextval,#{p_name},#{p_city},#{p_div},#{p_size},#{p_count},#{p_cost},#{p_stay},#{p_facility},#{p_load},#{p_pubnum},#{p_phone},#{p_web},#{p_latitude},#{p_longitude},#{p_regdate},#{p_code},#{p_pubname},#{p_img,jdbcType=VARCHAR})")
	public void insertForest(ForestVO forest);
	
	//특정 휴양림 삭제
	@Delete("DELETE FROM placedata WHERE p_num=#{p_num}")
	public void deleteForest(int p_num);

	//특정 휴양림 수정
	@Update("UPDATE placedata SET "
			+ "P_NAME=#{p_name},P_CITY=#{p_city},P_DIV=#{p_div},P_SIZE=#{p_size},P_COUNT=#{p_count},P_COST=#{p_cost},P_STAY=#{p_stay},P_FACILITY=#{p_facility},P_LOAD=#{p_load},"
			+ "P_PUBNUM=#{p_pubnum},P_PHONE=#{p_phone},P_WEB=#{p_web},P_LATITUDE=#{p_latitude},P_LONGITUDE=#{p_longitude},P_REGDATE=#{p_regdate},P_CODE=#{p_code},P_PUBNAME=#{p_pubname},P_IMG=#{p_img,jdbcType=VARCHAR}"
			+ "WHERE p_num=#{p_num}")
	public void updateForest(ForestVO forest);

	//특정 휴양림 상세보기
	@Select("SELECT * FROM placedata WHERE p_num=#{p_num}")
	public ForestVO selectForest(int p_num);

	//지역별 휴양림 리스트
	@Select("SELECT * FROM placedata WHERE p_load LIKE '%'||#{location}||'%' ORDER BY p_name")
	public List<ForestVO> selectForestList(String location);
	
	//선택 지역 휴양림 총 카운트
	@Select("SELECT COUNT(*) FROM placedata WHERE p_load LIKE '%'||#{location}||'%' ORDER BY p_name")
	public int selectForestListCount(String location);
	
	//전국 휴양림 리스트
	@Select("SELECT * FROM placedata order by p_num desc")
	public List<ForestVO> allForestList();
	
	//전국 휴양림 총 카운트
	@Select("SELECT COUNT(*) FROM placedata")
	public int allForestListCount();
	
	
	


}
