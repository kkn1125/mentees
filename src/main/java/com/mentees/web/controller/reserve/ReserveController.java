package com.mentees.web.controller.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mentees.web.entity.Reserve;
import com.mentees.web.service.reserve.ReserveServiceImpl;

@RestController
@RequestMapping("/reserve")
public class ReserveController {
	
	@Autowired
	private ReserveServiceImpl service;
	
	@PostMapping("/list")
	public List<Reserve> getAllReserveByMnum(@PathVariable("num") int num) {
		List<Reserve> list = service.getAllReserveByMnum(num);
		if(list!=null) {
			return list;
		}
		return null;
	}
	
	@PostMapping("")
	public void addReserve(int mnum, int pnum) {
		service.addReserve(mnum, pnum);
	}

	@DeleteMapping("")
	public void deleteReserve(int mnum, int pnum) {
		service.deleteReserve(mnum, pnum);
	}
	
}
