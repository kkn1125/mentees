package com.mentees.web.service.product;

import java.util.List;

import com.mentees.web.entity.Likes;
import com.mentees.web.entity.Product;

public interface ProductService {
	Product getProduct(int num);
	void addLike(int num, int pnum);
	void removeLike(int num, int pnum);
	List<Likes> getAllLikeList();
	List<Likes> getLikeListByPnum(int pnum);
	List<Likes> getLikeList(int num);
	
	Integer addProduct(Product product);
	Integer addProductNoCover(Product product);
	Integer editProduct(Product product);
	Integer editProductNoCover(Product product);
	void updateProduct(Product product);
	void deleteProductByNum(int num);
	List<Product> getLikeListToUser(int mnum);
	List<Product> getAllProductList();
	List<Product> getAllProductListByPage(int page, int limit);
}
