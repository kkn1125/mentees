package com.mentees.web.service.feedback;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentees.web.entity.Feed;
import com.mentees.web.entity.Feedback;
import com.mentees.web.mapper.FeedbackMapper;

@Service
public class FeedbackServiceImpl implements FeedbackService
{

	@Autowired
	private FeedbackMapper mapper;
	
	@Override
	public List<Feedback> getAllFeedback() {
		return mapper.getAllFeedback();
	}

	@Override
	public List<Feedback> getAllFeedbackListByPage(int page, int limit) {
		return mapper.getAllFeedbackListByPage(page, limit);
	}

	@Override
	public Feedback getFeedbackByNum(int num) {
		return mapper.getFeedbackByNum(num);
	}

	@Override
	public List<Feedback> getFeedbackByMnum(int mnum) {
		return mapper.getFeedbackByMnum(mnum);
	}

	@Override
	public void addFeedback(Feedback feedback) {
		mapper.addFeedback(feedback);
	}

	@Override
	public void editFeedback(Feedback feedback) {
		mapper.editFeedback(feedback);
	}

	@Override
	public void deleteFeedback(int num) {
		mapper.deleteFeedback(num);
	}

	@Override
	public List<Feed> getAllFeed() {
		return mapper.getAllFeed();
	}

	@Override
	public void addFeed(int mnum, int fnum) {
		mapper.addFeed(mnum, fnum);
	}

	@Override
	public void unFeed(int mnum, int fnum) {
		mapper.unFeed(mnum, fnum);
	}

}
