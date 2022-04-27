package com.mentees.web.service.member;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentees.web.entity.Member;
import com.mentees.web.entity.Recommend;
import com.mentees.web.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService
{
	@Autowired
	public MemberMapper mapper;
	
	@Override
	public List<Member> getAllMemberList() {
		return mapper.getAllMemberList();
	}

	@Override
	public Member findById(String id) {
		Optional<Member> option = mapper.findById(id);
		if(option.isPresent()) {
			return option.get();
		}
		return null;
	}

	@Override
	public Member findByEmail(String email) {
		Optional<Member> option = mapper.findByEmail(email);
		if(option.isPresent()) {
			return option.get();
		}
		return null;
	}

	@Override
	public List<Recommend> getAllRecommender() {
		return mapper.getAllRecommender();
	}

	@Override
	public void addRecommend(int recommender, int referral) {
		mapper.addRecommend(recommender, referral);
	}

	@Override
	public void disRecommend(int recommender, int referral) {
		mapper.disRecommend(recommender, referral);
	}

	@Override
	public List<Recommend> findReferralByRecommenderForHome(int num) {
		return mapper.findReferralByRecommenderForHome(num);
	}
	
	@Override
	public List<Member> findReferralByRecommender(int num) {
		return mapper.findReferralByRecommender(num);
	}
	
	@Override
	public List<Member> findRecommendersByReferral(int num) {
		return mapper.findRecommendersByReferral(num);
	}

	@Override
	public Integer addMember(Member member) {
		Integer result = null;
		result = mapper.addMember(member);
		return result;
	}

	@Override
	public void editMemberNoPw(Member member) {
		mapper.editMemberNoPw(member);
	}
	
	@Override
	public void editMemberForPw(Member member) {
		mapper.editMemberForPw(member);
	}

	@Override
	public void editMember(Member member) {
		mapper.editMember(member);
	}

	@Override
	public void deleteMemberByNum(int num) {
		mapper.deleteMemberByNum(num);
	}
	
}
