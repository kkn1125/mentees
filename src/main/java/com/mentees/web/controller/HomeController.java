package com.mentees.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
import com.mentees.web.service.feedback.FeedbackServiceImpl;
import com.mentees.web.service.member.MemberServiceImpl;
import com.mentees.web.service.product.ProductServiceImpl;

@Controller
@RequestMapping("/")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class HomeController {
	
	@Autowired
	MemberServiceImpl memberService;
	
	@Autowired
	ProductServiceImpl productService;
	
	@Autowired
	FeedbackServiceImpl feedbackService;
	
	@ModelAttribute("referer")
	private String referer(HttpServletRequest request) {
		String referer = request.getHeader("referer");
		if(referer!=null && request.getHeader("host").equals("https://menteesprj.herokuapp.com/"))
			return request.getHeader("referer").split(request.getHeader("host"))[1];
		return null;
	}
	
	@ResponseBody
	@PostMapping(value = "find/{userId}", produces = "application/text; charset=utf8")
	public String findId(@PathVariable("userId") String id) {
		ObjectMapper mapper = new ObjectMapper();
		Member member = memberService.findById(id);
		member.initImportant();
		String parsing = "";
		
		try {
			parsing = mapper.writeValueAsString(member);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return parsing;
	}
	
	@ModelAttribute("allMemberList")
	private List<Member> getAllMembers(){
		return memberService.getAllMemberList();
	}
	
	@ModelAttribute("allRecommender")
	private List<Recommend> allRecommenders(){
		List<Recommend> recommenders = memberService.getAllRecommender();
		return recommenders;
	}
	
	@ModelAttribute("myReferralList")
	private List<Recommend> getMyReferralList(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Recommend> recommenders = memberService.findReferralByRecommenderForHome(member.getNum());
			return recommenders;
		}
		return null;
	}
	
	@ModelAttribute("getRecommend")
	private List<Member> recommenders(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Member> recommenders = memberService.findRecommendersByReferral(member.getNum());
			return recommenders;
		}
		return null;
	}
	
	@ModelAttribute("allLikeList")
	public List<Likes> likeList(){
		return productService.getAllLikeList();
	}
	
	@ModelAttribute("likeList")
	public List<Likes> likeList(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member mentee = (Member) session.getAttribute("mentee");
			return productService.getLikeList(mentee.getNum());
		}
		return null;
	}
	
	@ModelAttribute("productList")
	public List<Product> productList(){
		return productService.getAllProductList();
	}
	// feedback
	@ModelAttribute("allFeedbackList")
	public List<Feedback> getAllFeedbackList(){
		return feedbackService.getAllFeedback();
	}
	
	@ModelAttribute("allFeedList")
	public List<Feed> getAllFeed(){
		return feedbackService.getAllFeed();
	}
	
	@GetMapping("")
	public String home() {
		return "root.home";
	}
	
	@GetMapping("about")
	public String about() {
		return "root.about";
	}
	
	@GetMapping("signin")
	public String signin(@ModelAttribute("referer") String referer) {
		return "secu.signin";
	}
	
	@PostMapping("signin")
	public String signin(String email, String pw, Model model, HttpSession session, String referer) {
		Member member = memberService.findByEmail(email);
		boolean result = member!=null?true:false;;
		if(result && member.checkPw(pw)) {
			model.addAttribute("err", 0);
			session.setAttribute("mentee", member);
			if(referer.equals("/mentees/setting") || referer.equals("/signout")) {
				referer = "/";
			}
			return "redirect:"+referer;
		} else {
			model.addAttribute("err", 1);
		}
		return "secu.signin";
	}
	
	@GetMapping("signup")
	public String signup() {
		return "secu.signup";
	}
	
	@PostMapping("signup")
	public String signup(Member member, Model model) {
		memberService.addMember(member);
		model.addAttribute("err", 2);
		return "root.home";
	}
	
	@GetMapping("signout")
	public String signup(HttpSession session, Model model) {
		model.addAttribute("err", 3);
		session.invalidate();
		return "root.home";
	}
	
}
