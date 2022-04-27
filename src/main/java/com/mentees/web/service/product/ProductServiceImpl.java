package com.mentees.web.service.product;

import java.util.List;
import java.util.Optional;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentees.web.entity.Likes;
import com.mentees.web.entity.Product;
import com.mentees.web.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService
{

	@Autowired
	private ProductMapper mapper;
	
	@Override
	public void addLike(int num, int pnum) {
		mapper.addLike(num, pnum);
	}

	@Override
	public Integer addProduct(Product product) {
		return mapper.addProduct(product);
	}

	@Override
	public Integer addProductNoCover(Product product) {
		return mapper.addProductNoCover(product);
	}

	@Override
	public Integer editProduct(Product product) {
		return mapper.editProduct(product);
	}

	@Override
	public Integer editProductNoCover(Product product) {
		return mapper.editProductNoCover(product);
	}

	@Override
	public void updateProduct(Product product) {
		mapper.updateProduct(product);
	}

	@Override
	public void deleteProductByNum(int num) {
		mapper.deleteProductByNum(num);
	}

	@Override
	public List<Product> getLikeListToUser(int mnum) {
		return mapper.getLikeListToUser(mnum);
	}

	@Override
	public void removeLike(int num, int pnum) {
		mapper.removeLike(num, pnum);
	}

	@Override
	public List<Likes> getLikeListByPnum(int pnum) {
		return mapper.getLikeListByPnum(pnum);
	}

	@Override
	public List<Likes> getAllLikeList() {
		return mapper.getAllLikeList();
	}

	@Override
	public List<Likes> getLikeList(int num) {
		return mapper.getLikeList(num);
	}

	@Override
	public Product getProduct(int num) {
		Optional<Product> option= mapper.getProduct(num);
		if(option.isPresent()) {
			return option.get();
		}
		return null;
	}

	@Override
	public List<Product> getAllProductList() {
		return mapper.getAllProductList();
	}

	@Override
	public List<Product> getAllProductListByPage(int page, int limit) {
		return mapper.getAllProductListByPage(page, limit);
	}
	
	

}
