package com.mentees.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.mentees.web.entity.Product;
import com.mentees.web.entity.Reserve;

@Mapper
public interface ReserveMapper {
	@Select("SELECT * FROM reserve ORDER BY regdate DESC")
	List<Reserve> getAllReserve();
	
	@Select("SELECT product.* FROM product left join reserve on reserve.pnum = product.num WHERE reserve.mnum=#{mnum} ORDER BY regdate DESC;")
	List<Product> getAllProductByReserveAsMnum(int mnum);
	
	@Select("SELECT * FROM reserve WHERE mnum=#{mnum} ORDER BY regdate DESC")
	List<Reserve> getAllReserveByMnum(int mnum);
	
	@Insert("INSERT INTO reserve (mnum, pnum) VALUES (#{mnum}, #{pnum})")
	void addReserve(int mnum, int pnum);
	
	@Delete("DELETE FROM reserve WHERE mnum=#{mnum} AND pnum=#{pnum}")
	void deleteReserve(int mnum, int pnum);
}
