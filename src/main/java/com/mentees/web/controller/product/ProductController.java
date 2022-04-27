package com.mentees.web.controller.product;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mentees.web.entity.Comment;
import com.mentees.web.entity.Likes;
import com.mentees.web.entity.Member;
import com.mentees.web.entity.Product;
import com.mentees.web.entity.Reserve;
import com.mentees.web.service.comment.CommentServiceImpl;
import com.mentees.web.service.member.MemberServiceImpl;
import com.mentees.web.service.product.ProductServiceImpl;
import com.mentees.web.service.reserve.ReserveServiceImpl;

@Controller
@RequestMapping("/program/")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ProductController {
	
	private static final int limit = 5;
	
	@Autowired
	private ProductServiceImpl service;

	@Autowired
	private ReserveServiceImpl reserveService;
	
	@Autowired
	private CommentServiceImpl commentService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@ModelAttribute("referer")
	private String referer(HttpServletRequest request) {
		if(request.getHeader("referer")!=null) {
			return request.getHeader("referer").split(request.getHeader("host"))[1];
		}
		return null;
	}
	
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
	
	@ModelAttribute("doRecommend")
	private List<Member> recommenders(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member member = (Member) session.getAttribute("mentee");
			List<Member> recommenders = memberService.findReferralByRecommender(member.getNum());
			return recommenders;
		}
		return null;
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

	@ModelAttribute("allLikeList")
	public List<Likes> likeList(){
		return service.getAllLikeList();
	}
	
	@ModelAttribute("likeList")
	public List<Likes> likeList(HttpSession session){
		if(session.getAttribute("mentee")!=null) {
			Member mentee = (Member) session.getAttribute("mentee");
			return service.getLikeList(mentee.getNum());
		}
		return null;
	}
	
	@ModelAttribute("productList")
	public List<Product> productList(@RequestParam(value = "page",defaultValue = "1") int page){
		int paging = (page-1) * limit;
		return service.getAllProductListByPage(paging, limit);
	}
	
	@PostMapping("like")
	@ResponseBody
	public String like(int pnum, int num) {
		service.addLike(num, pnum);
		return "true";
	}
	
	@PostMapping("dislike")
	@ResponseBody
	public String dislike(int pnum, int num) {
		service.removeLike(num, pnum);
		return "false";
	}
	
	@GetMapping("form")
	public String form() {
		return "product.form";
	}
	
	@GetMapping("form/{num}")
	public String form(@PathVariable("num") int num, Model model) {
		model.addAttribute("edit", service.getProduct(num));
		return "product.form";
	}
	
	@GetMapping("list")
	public String list() {
		return "product.list";
	}
	
	@PostMapping("list")
	public String addProduct(HttpServletRequest request, Product product, String dstart, String dend, String duntil, @ModelAttribute("referer") String referer, @RequestParam("file") MultipartFile cover) {
		dstart = dstart.replace("T"," ")+":00.000";
		dend = dend.replace("T"," ")+":00.000";
		duntil = duntil.replace("T"," ")+":00.000";
		product.setStart(Timestamp.valueOf(dstart));
		product.setEnd(Timestamp.valueOf(dend));
		product.setUntil(Timestamp.valueOf(duntil));
		
		if(!cover.isEmpty()) {
			String fileName = ""; // 파일 이름
			String web_path = "/resources/img/upload"; // DB 저장될 경로명
			String absolutePath = request.getServletContext().getRealPath(web_path); // 절대경로
//			String originalFileExtension = ""; // 확장자명
//			String encType = "utf-8";
			
			int maxSize = 5 * 1024 * 1024;
			File file = new File(absolutePath);
			
			if(!file.exists()) {
				System.out.println(file.mkdirs());
			}
			
			String contentType = cover.getContentType();
			if(!ObjectUtils.isEmpty(contentType)) {
				fileName = cover.getOriginalFilename();
//				if(contentType.contains("image/jpeg")) {
//					originalFileExtension = ".jpg";
//				} else if(contentType.contains("image/png")) {
//					originalFileExtension = ".png";
//				} else if(contentType.contains("image/gif")) {
//					originalFileExtension = ".gif";
//				}
			}
			String coverName = web_path + "/" + fileName;
			product.setCover(coverName);
			file = new File(absolutePath + "/" + fileName);
			
			System.out.println(coverName);
			System.out.println(file.getAbsolutePath());
			
			try {
				cover.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		if(product.getCover()==null){
			service.addProductNoCover(product);
		} else {
			service.addProduct(product);
		}
		return "redirect:/program/list";
	}
	
	@PutMapping("list/{num}")
	public String editProduct(HttpServletRequest request, Product product, String dstart, String dend, String duntil, @ModelAttribute("referer") String referer, @RequestParam("file") MultipartFile cover, @PathVariable("num") int num) {
		dstart = dstart.replace("T"," ")+":00.000";
		dend = dend.replace("T"," ")+":00.000";
		duntil = duntil.replace("T"," ")+":00.000";
		product.setStart(Timestamp.valueOf(dstart));
		product.setEnd(Timestamp.valueOf(dend));
		product.setUntil(Timestamp.valueOf(duntil));
		if(!cover.isEmpty()) {
			String fileName = ""; // 파일 이름
			String web_path = "/resources/img/upload"; // DB 저장될 경로명
			String absolutePath = request.getServletContext().getRealPath(web_path); // 절대경로
//			String originalFileExtension = ""; // 확장자명
//			String encType = "utf-8";
			
			int maxSize = 5 * 1024 * 1024;
			File file = new File(absolutePath);
			
			if(!file.exists()) {
				System.out.println(file.mkdirs());
			}
			
			String contentType = cover.getContentType();
			if(!ObjectUtils.isEmpty(contentType)) {
				fileName = cover.getOriginalFilename();
//				if(contentType.contains("image/jpeg")) {
//					originalFileExtension = ".jpg";
//				} else if(contentType.contains("image/png")) {
//					originalFileExtension = ".png";
//				} else if(contentType.contains("image/gif")) {
//					originalFileExtension = ".gif";
//				}
			}
			String coverName = web_path + "/" + fileName;
			product.setCover(coverName);
			file = new File(absolutePath + "/" + fileName);
			
			System.out.println(coverName);
			System.out.println(file.getAbsolutePath());
			
			try {
				cover.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		product.setNum(num);
		if(product.getCover()==null){
			service.editProductNoCover(product);
		} else {
			service.editProduct(product);
		}
		return "redirect:/program/list";
	}
	
	@DeleteMapping("list/{num}")
	public String deleteProduct(@PathVariable("num") int num, @ModelAttribute("referer") String referer) {
		service.deleteProductByNum(num);
		return "redirect:"+referer;
	}
	
	@GetMapping("list/{num}")
	public String product(@PathVariable("num") int num, Model model) {
		model.addAttribute("product", service.getProduct(num));
		List<Comment> commentList = commentService.getAllCommentByPnum(num);
		model.addAttribute("commentList", commentList);
		return "product.detail";
	}
	
}
