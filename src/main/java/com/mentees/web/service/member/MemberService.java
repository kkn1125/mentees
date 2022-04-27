package com.mentees.web.service.member;

import java.util.List;
import java.util.Optional;

import com.mentees.web.entity.Member;
import com.mentees.web.entity.Recommend;

public interface MemberService {
	List<Member> getAllMemberList();
	Member findById(String id);
	Member findByEmail(String email);
	List<Recommend> getAllRecommender();
	void addRecommend(int recommender, int referral);
	void disRecommend(int recommender, int referral);
	Integer addMember(Member member);
	void editMemberForPw(Member member);
	void editMember(Member member);
	void editMemberNoPw(Member member);
	void deleteMemberByNum(int num);
	List<Recommend> findReferralByRecommenderForHome(int num);
	List<Member> findReferralByRecommender(int num);
	List<Member> findRecommendersByReferral(int num);
}
