package com.mentees.web.mapper;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mentees.web.entity.Member;
import com.mentees.web.entity.Recommend;

@Mapper
public interface MemberMapper {
	@Select("SELECT * FROM member")
	List<Member> getAllMemberList();
	
	@Select("SELECT * FROM member WHERE id = #{id}")
	Optional<Member> findById(String id);
	
	@Select("SELECT * FROM member WHERE email = #{email}")
	Optional<Member> findByEmail(String email);
	
	@Select("select recommend.* from recommend left join member on member.num = recommend.referral where recommender=#{num}")
	List<Recommend> findReferralByRecommenderForHome(int num);
	
	@Select("select member.* from recommend left join member on member.num = recommend.referral where recommender=#{num}")
	List<Member> findReferralByRecommender(int num);
	
	@Select("select member.* from recommend left join member on member.num = recommend.recommender where referral=#{num}")
	List<Member> findRecommendersByReferral(int num);
	
	@Insert("INSERT INTO member (name,jumin,id,pw,msg,email,address,zip,gender,interest) VALUES (#{name},#{jumin},#{id},#{pw},#{msg},#{email},#{address},#{zip},#{gender},#{interest})")
	@Options(keyColumn = "num",useGeneratedKeys = true)
	Integer addMember(Member member);
	
	@Update("UPDATE member SET pw=#{pw} WHERE num=#{num}")
	void editMemberForPw(Member member);
	
	@Update("UPDATE member SET id=#{id}, pw=#{pw}, msg=#{msg}, email=#{email}, address=#{address}, zip=#{zip}, interest=#{interest} WHERE num=#{num}")
	void editMember(Member member);
	
	@Update("UPDATE member SET id=#{id}, msg=#{msg}, email=#{email}, address=#{address}, zip=#{zip}, interest=#{interest} WHERE num=#{num}")
	void editMemberNoPw(Member member);
	
	@Delete("DELETE FROM member WHERE num = #{num}")
	void deleteMemberByNum(int num);
	
	@Select("SELECT * FROM recommend")
	List<Recommend> getAllRecommender();
	
	@Insert("INSERT INTO recommend (recommender, referral) VALUES (${recommender}, ${referral})")
	void addRecommend(int recommender, int referral);
	
	@Delete("DELETE FROM recommend WHERE recommender=#{recommender} AND referral=#{referral}")
	void disRecommend(int recommender, int referral);
	
}
