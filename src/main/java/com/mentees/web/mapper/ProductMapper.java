package com.mentees.web.mapper;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mentees.web.entity.Likes;
import com.mentees.web.entity.Product;

@Mapper
public interface ProductMapper {
	
	@Select("SELECT * FROM product WHERE num=#{num}")
	Optional<Product> getProduct(int num);
	
	@Select("SELECT * FROM product ORDER BY regdate DESC")
	List<Product> getAllProductList();
	
	@Select("SELECT * FROM product ORDER BY regdate DESC LIMIT #{page}, #{limit}")
	List<Product> getAllProductListByPage(int page, int limit);
	
	@Select("select * from product where num in (select pnum from likes where mnum=${mnum})")
	List<Product> getLikeListToUser(int mnum);
	
	@Insert("INSERT INTO product (tags, cover, address, type, id, title, content, capacity, start, end, until) VALUES (#{tags}, #{cover}, #{address}, #{type}, #{id}, #{title}, #{content}, #{capacity}, #{start}, #{end}, #{until})")
	@Options(useGeneratedKeys = true, keyColumn = "num")
	Integer addProduct(Product product);
	
	@Insert("INSERT INTO product (tags, address, type, id, title, content, capacity, start, end, until) VALUES (#{tags}, #{address}, #{type}, #{id}, #{title}, #{content}, #{capacity}, #{start}, #{end}, #{until})")
	@Options(useGeneratedKeys = true, keyColumn = "num")
	Integer addProductNoCover(Product product);
	
	@Update("UPDATE product SET tags=#{tags}, cover=#{cover}, address=#{address}, type=#{type}, id=#{id}, title=#{title}, content=#{content}, capacity=#{capacity}, start=#{start}, end=#{end}, until=#{until} WHERE num=#{num}")
	@Options(useGeneratedKeys = true, keyColumn = "num")
	Integer editProduct(Product product);
	
	@Update("UPDATE product SET tags=#{tags}, address=#{address}, type=#{type}, id=#{id}, title=#{title}, content=#{content}, capacity=#{capacity}, start=#{start}, end=#{end}, until=#{until} WHERE num=#{num}")
	@Options(useGeneratedKeys = true, keyColumn = "num")
	Integer editProductNoCover(Product product);
	
	@Update("")
	void updateProduct(Product product);
	
	@Delete("DELETE FROM product WHERE num = #{num}")
	void deleteProductByNum(int num);
	
	@Select("SELECT * FROM likes")
	List<Likes> getAllLikeList();
	
	@Select("SELECT * FROM likes WHERE pnum = #{pnum}")
	List<Likes> getLikeListByPnum(int pnum);
	
	@Select("SELECT * FROM likes WHERE mnum = #{num}")
	List<Likes> getLikeList(int num);
	
	@Insert("INSERT INTO likes (mnum, pnum) VALUES (#{num}, #{pnum})")
	void addLike(int num, int pnum);
	
	@Delete("DELETE FROM likes WHERE mnum = #{num} AND pnum = #{pnum}")
	void removeLike(int num, int pnum);
}
