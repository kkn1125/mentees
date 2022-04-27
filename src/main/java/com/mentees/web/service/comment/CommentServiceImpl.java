package com.mentees.web.service.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentees.web.entity.Comment;
import com.mentees.web.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService
{
	
	@Autowired
	private CommentMapper mapper;

	@Override
	public List<Comment> getAllCommentByPnum(int pnum) {
		return mapper.getAllCommentByPnum(pnum);
	}

	@Override
	public Comment getCommentByNum(int num) {
		return mapper.getCommentByNum(num);
	}

	@Override
	public void updateComment(Comment origin) {
		mapper.updateComment(origin);
	}

	@Override
	public void addComment(Comment comment) {
		mapper.addComment(comment);
	}

	@Override
	public void addReplyComment(Comment comment) {
		mapper.addReplyComment(comment);
	}

	@Override
	public void editComment(Comment comment) {
		mapper.editComment(comment);
	}

	@Override
	public void deleteComment(int num) {
		mapper.deleteComment(num);
	}

}
