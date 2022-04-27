package com.mentees.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mentees.web.entity.Comment;

@Mapper
public interface CommentMapper {
	@Select("SELECT * FROM comment WHERE pnum=#{pnum} ORDER BY cnum DESC, `order`, regdate DESC")
	List<Comment> getAllCommentByPnum(int pnum);
	
	@Select("SELECT * FROM comment WHERE num=#{num}")
	Comment getCommentByNum(int num);
	
	@Insert("INSERT INTO comment (pnum, cnum, author, content, visible) VALUES (#{pnum}, (select ifnull(max(num),0)+1 from comment as temp), #{author}, #{content}, #{visible})")
	void addComment(Comment comment);
	
	@Insert("insert into comment (pnum, cnum, author, content, `order`, `layer`) VALUES (#{pnum},#{cnum},#{author},#{content},#{order},#{layer})")
	void addReplyComment(Comment comment);
	
	@Update("UPDATE comment SET `order` = #{order} + 1 where cnum=#{cnum} and `order`>#{order}")
	void updateComment(Comment comment);
	
	@Update("UPDATE comment SET content=#{content}, visible=#{visible} WHERE num=#{num}")
	void editComment(Comment comment);
	
	@Delete("DELETE FROM comment WHERE num=#{num}")
	void deleteComment(int num);
}
