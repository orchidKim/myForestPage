package kr.spring.comment.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.comment.dao.CommentMapper;
import kr.spring.comment.domain.CommentVO;


@Service("CommentService")
public class CommentServiceImpl implements CommentService{

	@Resource
	private CommentMapper commentMapper;
	
	@Override
	public List<CommentVO> selectCommentList(int p_num) {
		return commentMapper.selectCommentList(p_num);
	}

	@Override
	public int selectCommentListCount(int p_num) {
		return commentMapper.selectCommentListCount(p_num);
	}

	@Override
	public void insertComment(CommentVO comment) {
		commentMapper.insertComment(comment);
	}

	@Override
	public void deleteComment(int c_num) {
		commentMapper.deleteComment(c_num);
	}

	@Override
	public List<CommentVO> allCommentList() {
		return commentMapper.allCommentList();
	}

	@Override
	public int allCommentListCount() {
		return commentMapper.allCommentListCount();
	}

	@Override
	public String findId(int mem_num) {
		return commentMapper.findId(mem_num);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return commentMapper.selectRowCount(map);
	}

	@Override
	public List<CommentVO> commentList(Map<String, Object> map) {
		return commentMapper.commentList(map);
	}

	
}
