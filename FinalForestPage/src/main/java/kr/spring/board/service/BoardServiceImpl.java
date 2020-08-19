package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.domain.BoardVO;

@Service("noticeService")
public class BoardServiceImpl implements BoardService{
	
	@Resource
	private BoardMapper noticeMapper;
	
	
	@Override
	public List<BoardVO> selectList(Map<String,Object> map) {
		return noticeMapper.selectList(map);
	}

	@Override
	public int selectRowCount() {
		return noticeMapper.selectRowCount();
	}

	@Override
	public void insert(BoardVO notice) {
		noticeMapper.insert(notice);
	}

	@Override
	public BoardVO selectBoard(Integer num) {
		return noticeMapper.selectBoard(num);
	}

	@Override
	public void updateHit(Integer num) {
		noticeMapper.updateHit(num);
	}

	@Override
	public void update(BoardVO notice) {
		noticeMapper.update(notice);
	}

	@Override
	public void delete(Integer num) {
		noticeMapper.delete(num);
	}

	@Override
	public String findId(int mem_num) {
		return noticeMapper.findId(mem_num);
	}

}
