package com.mentees.web.service.comment;

import java.util.List;

import com.mentees.web.entity.Comment;

public interface CommentService {
	List<Comment> getAllCommentByPnum(int pnum);
	Comment getCommentByNum(int num);
	void addComment(Comment comment);
	void updateComment(Comment origin);
	void addReplyComment(Comment comment);
	void editComment(Comment comment);
	void deleteComment(int num);
}
