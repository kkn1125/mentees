package com.mentees.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mentees.web.entity.Feed;
import com.mentees.web.entity.Feedback;

@Mapper
public interface FeedbackMapper {
	@Select("SELECT * FROM feedback ORDER BY regdate DESC")
	List<Feedback> getAllFeedback();
	
	@Select("SELECT * FROM feedback ORDER BY regdate DESC LIMIT #{page}, #{limit}")
	List<Feedback> getAllFeedbackListByPage(int page, int limit);
	
	@Select("SELECT * FROM feedback WHERE num = #{num}")
	Feedback getFeedbackByNum(int num);
	
	@Select("select feedback.* from feedback left join feed on feed.fnum = feedback.num where mnum = #{mnum}")
	List<Feedback> getFeedbackByMnum(int mnum);
	
	@Insert("INSERT INTO feedback (title, content, author, tags) VALUES (#{title}, #{content}, #{author}, #{tags})")
	void addFeedback(Feedback feedback);
	
	@Update("UPDATE feedback SET title=#{title}, content=#{content}, author=#{author}, tags=#{tags} WHERE num=#{num}")
	void editFeedback(Feedback feedback);
	
	@Delete("DELETE FROM feedback WHERE num=#{num}")
	void deleteFeedback(int num);
	
	@Select("SELECT * FROM feed")
	List<Feed> getAllFeed();
	
	@Insert("INSERT INTO feed VALUES (#{mnum}, #{fnum})")
	void addFeed(int mnum, int fnum);
	
	@Insert("DELETE FROM feed WHERE mnum=#{mnum} AND fnum=#{fnum}")
	void unFeed(int mnum, int fnum);
}
