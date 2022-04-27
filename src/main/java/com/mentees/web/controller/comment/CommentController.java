package com.mentees.web.controller.comment;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mentees.web.entity.Comment;
import com.mentees.web.service.comment.CommentServiceImpl;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	CommentServiceImpl service;
	
	@ModelAttribute("referer")
	private String referer(HttpServletRequest request) {
		if(request.getHeader("referer")!=null) {
			return request.getHeader("referer").split(request.getHeader("host"))[1];
		}
		return null;
	}
	
	@PostMapping("{pnum}")
	public String addComment(Comment comment, @PathVariable("pnum") int pnum, String vis, @ModelAttribute("referer") String referer) {
		int visible = 1;
		if(vis==null) {
			visible = 0;
		}
		comment.setVisible(visible);
		service.addComment(comment);
		return "redirect:"+referer+"#comment";
	}
	
	@PostMapping("/reply")
	public String addReplyComment(Comment comment, int ori, int pnum, String vis, @ModelAttribute("referer") String referer) {
		Comment origin = service.getCommentByNum(ori);
		System.out.println(origin);
		service.updateComment(origin);
		comment.setPnum(pnum);
		comment.setCnum(origin.getCnum());
		comment.setOrder(origin.getOrder()+1);
		comment.setLayer(origin.getLayer()+1);
		int visible = 1;
		if(vis==null) {
			visible = 0;
		}
		comment.setVisible(visible);
		System.out.println(comment);
		service.addReplyComment(comment);
		return "redirect:"+referer+"#comment";
	}
	
	@PutMapping("{num}")
	public void editComment(Comment comment, @PathVariable("num") int num) {
		comment.setNum(num);
		service.editComment(comment);
	}
	
	@DeleteMapping("{num}")
	public void deleteComment(@PathVariable("num") int num) {
		service.deleteComment(num);
	}
	
}
