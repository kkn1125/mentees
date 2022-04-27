package com.mentees.web.controller.member;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mentees.web.entity.Feed;
import com.mentees.web.entity.Feedback;
import com.mentees.web.entity.Likes;
import com.mentees.web.entity.Member;
import com.mentees.web.entity.Product;
import com.mentees.web.entity.Recommend;
import com.mentees.web.entity.Reserve;
import com.mentees.web.service.feedback.FeedbackServiceImpl;
import com.mentees.web.service.member.MemberServiceImpl;
import com.mentees.web.service.product.ProductServiceImpl;
import com.mentees.web.service.reserve.ReserveServiceImpl;

@Controller
@RequestMapping("/mentees")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl service;

	@Autowired
	private FeedbackServiceImpl feedbackService;
	
	@Autowired
	private ProductServiceImpl productService;
	
	@Autowired
	private ReserveServiceImpl reserveService;
	
	// reserve
	@ModelAttribute("allReserve")
	private List<Reserve> getListByMnum(){
		return reserveService.getAllReserve();
	}

	@ModelAttribute("myReserveAsProduct")
	private List<Product> getAllProductByReserveAsMnum(HttpSession session){
		Member member = (Member) session.getAttribute("mentee");
		if(member!=null) {
			int mnum = member.getNum();
			List<Product> list = reserveService.getAllProductByReserveAsMnum(mnum);
			return list;
		}
		return null;
	}
	
	@ModelAttribute("myReserve")
	private List<Reserve> getListByMnum(HttpSession session){
		Member member = (Member) session.getAttribute("mentee");
		if(member!=null) {
			int mnum = member.getNum();
			List<Reserve> list = reserveService.getAllReserveByMnum(mnum);
			return list;
		}
		return null;
	}
	
//	For Member
	@ModelAttribute("mentee")
	private Member mentee(HttpSession session, HttpServletResponse response, Model model) {
		Member mentee = session.getAttribute("mentee")!=null?(Member)session.getAttribute("mentee"):null;
		if(mentee==null) {
			try {
				response.sendRedirect("/"); // 로그인 끊기면 홈으로 돌아감
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return mentee;
	}
	
//	For FeedList
	@ModelAttribute("myFeedList")
	public List<Feedback> getAllFeed(HttpSession session){
		Member member;
		if(session.getAttribute("mentee")!=null) {
			member = (Member) session.getAttribute("mentee");
			return feedbackService.getFeedbackByMnum(member.getNum());
		}
		return null;
	}
	
//	For Recommend
	@ModelAttribute("doRecommend")
	private List<Member> recommenders(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Member> recommenders = service.findReferralByRecommender(member.getNum());
			return recommenders;
		}
		return null;
	}
	
	@ModelAttribute("getRecommend")
	private List<Member> myRecommenders(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Member> myRecommenders = service.findRecommendersByReferral(member.getNum());
			return myRecommenders;
		}
		return null;
	}
	
//	For Product
	@ModelAttribute("likeList")
	public List<Likes> likeList(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member mentee = (Member) session.getAttribute("mentee");
			return productService.getLikeList(mentee.getNum());
		}
		return null;
	}

	@ModelAttribute("allLikeList")
	public List<Likes> likeList(){
		return productService.getAllLikeList();
	}
	
	@ModelAttribute("productList")
	public List<Product> productList(){
		return productService.getAllProductList();
	}
	
	@ModelAttribute("userLikeList")
	public List<Product> userProductList(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member mentee = (Member) session.getAttribute("mentee");
			return productService.getLikeListToUser(mentee.getNum());
		}
		return null;
	}
	
	@GetMapping("")
	public String mentees() {
		return "mentees.mentees";
	}
	
	@GetMapping("/setting")
	public String setting() {
		return "mentees.setting";
	}
	
	@PutMapping("/setting/{num}")
	public String update(@PathVariable("num") int num, String pw, String checkPw, Member member, HttpSession session, Model model) {
		member.setNum(num);
		Member origin = service.findByEmail(member.getEmail());
		if(origin.checkPw(pw)) {
			model.addAttribute("err", 7); // 회원정보 수정 
			service.editMemberNoPw(member);
			Member m = service.findByEmail(member.getEmail());
			session.setAttribute("mentee", m);
		} else {
			model.addAttribute("err", 5); // 비번 틀림
			if(pw.equals(checkPw)){
				service.editMemberForPw(member);
				model.addAttribute("err", 6); // 비번 변경
				session.invalidate();
				return "redirect:/signin";
			}
		}
		return "redirect:/mentees/setting";
	}
	
	@DeleteMapping("/setting/{num}")
	public String delete(@PathVariable("num") int num, Model model, HttpSession session) {
		model.addAttribute("err", 4);
		service.deleteMemberByNum(num);
		session.invalidate();
		return "redirect:/";
	}
	
//	recommend Handler
	@PostMapping("/recommend")
	@ResponseBody
	public String addRecommend(int recommender, int referral) {
		service.addRecommend(recommender, referral);
		return "true";
	}
	
	@DeleteMapping("/recommend")
	@ResponseBody
	public String disRecommend(int recommender, int referral) {
		service.disRecommend(recommender, referral);
		return "false";
	}
	
	
}
