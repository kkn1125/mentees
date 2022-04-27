package com.mentees.web.controller.feedback;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mentees.web.entity.Feed;
import com.mentees.web.entity.Feedback;
import com.mentees.web.entity.Member;
import com.mentees.web.entity.Product;
import com.mentees.web.service.feedback.FeedbackServiceImpl;
import com.mentees.web.service.member.MemberServiceImpl;

@Controller
@RequestMapping("/feedback/")
public class FeedbackController {
	
	private static final int limit = 5;
	
	@Autowired
	private FeedbackServiceImpl service;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@ModelAttribute("feedbackList")
	public List<Feedback> productList(@RequestParam(value = "page",defaultValue = "1") int page){
		int paging = (page-1) * limit;
		return service.getAllFeedbackListByPage(paging, limit);
	}
	
	@ModelAttribute("getRecommend")
	private List<Member> myRecommenders(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Member> myRecommenders = memberService.findRecommendersByReferral(member.getNum());
			return myRecommenders;
		}
		return null;
	}
	
	@ModelAttribute("allFeedbackList")
	public List<Feedback> getAllFeedbackList(){
		return service.getAllFeedback();
	}
	
	@ModelAttribute("allFeedList")
	public List<Feed> getAllFeed(){
		return service.getAllFeed();
	}
	
	@GetMapping("form")
	public String form() {
		return "feedback.form";
	}
	
	@GetMapping("form/{num}")
	public String formByNum(@PathVariable("num") int num, Model model) {
		model.addAttribute("feed", service.getFeedbackByNum(num));
		return "feedback.form";
	}
	
	@GetMapping("list")
	public String list() {
		return "feedback.list";
	}
	
	@GetMapping("list/{num}")
	public String list(@PathVariable("num") int num, Model model) {
		model.addAttribute("feed", service.getFeedbackByNum(num));
		return "feedback.detail";
	}
	
	@PostMapping("list")
	public String add(Feedback feedback) {
		service.addFeedback(feedback);
		return "redirect:/feedback/list";
	}
	
	@PutMapping("list/{num}")
	public String edit(@PathVariable("num") int num, Feedback feedback) {
		service.editFeedback(feedback);
		return "redirect:/feedback/list";
	}
	
	@DeleteMapping("list/{num}")
	public String delete(@PathVariable("num") int num) {
		service.deleteFeedback(num);
		return "redirect:/feedback/list";
	}
	
	@PostMapping("feed")
	@ResponseBody
	public String feed(int mnum, int fnum) {
		service.addFeed(mnum, fnum);
		return "true";
	}
	
	@DeleteMapping("feed")
	@ResponseBody
	public String unfeed(int mnum, int fnum) {
		service.unFeed(mnum, fnum);
		return "false";
	}
	
}
