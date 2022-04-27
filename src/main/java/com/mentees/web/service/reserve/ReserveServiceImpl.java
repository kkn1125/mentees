package com.mentees.web.service.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentees.web.entity.Product;
import com.mentees.web.entity.Reserve;
import com.mentees.web.mapper.ReserveMapper;

@Service
public class ReserveServiceImpl implements ReserveService
{
	@Autowired
	private ReserveMapper mapper;

	@Override
	public List<Product> getAllProductByReserveAsMnum(int mnum) {
		return mapper.getAllProductByReserveAsMnum(mnum);
	}

	@Override
	public List<Reserve> getAllReserve() {
		return mapper.getAllReserve();
	}

	@Override
	public List<Reserve> getAllReserveByMnum(int mnum) {
		return mapper.getAllReserveByMnum(mnum);
	}

	@Override
	public void addReserve(int mnum, int pnum) {
		mapper.addReserve(mnum, pnum);
	}

	@Override
	public void deleteReserve(int mnum, int pnum) {
		mapper.deleteReserve(mnum, pnum);
	}

}
