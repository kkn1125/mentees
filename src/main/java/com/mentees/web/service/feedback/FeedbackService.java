package com.mentees.web.service.feedback;

import java.util.List;

import com.mentees.web.entity.Feed;
import com.mentees.web.entity.Feedback;

public interface FeedbackService {
	List<Feedback> getAllFeedback();
	List<Feedback> getAllFeedbackListByPage(int page, int limit);
	Feedback getFeedbackByNum(int num);
	List<Feedback> getFeedbackByMnum(int mnum);
	void addFeedback(Feedback feedback);
	void editFeedback(Feedback feedback);
	void deleteFeedback(int num);
	List<Feed> getAllFeed();
	void addFeed(int mnum, int fnum);
	void unFeed(int mnum, int fnum);
}
