package com.mentees.web.service.reserve;

import java.util.List;

import com.mentees.web.entity.Product;
import com.mentees.web.entity.Reserve;

public interface ReserveService {
	List<Reserve> getAllReserve();
	List<Product> getAllProductByReserveAsMnum(int mnum);
	List<Reserve> getAllReserveByMnum(int mnum);
	void addReserve(int mnum, int pnum);
	void deleteReserve(int mnum, int pnum);
}
