package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.user.UserDao;



@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.addProduct", product);
	}

	public Product getProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}
	
	public Product getProduct2(String prodName) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProduct2", prodName);
	}
	
	
	
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct", product);
	}

	public List<Product> getProductList(Search search) throws Exception {
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}
	
	public List<Product> getProductTranList(int prodNo) throws Exception {
		return sqlSession.selectList("ProductMapper.getProductTranList", prodNo);
	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	// 21. 10. 15 장바구니 
	public void addCart(Map map) throws Exception {
		sqlSession.insert("ProductMapper.addCart", map);
		
	}
	public String validationCart(Map map) throws Exception{
		return sqlSession.selectOne("ProductMapper.validationCart", map);
	}
	
	//21. 10. 17 
	public Map<String,Object> getCartList(String buyerId) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();

		List<Product> list = sqlSession.selectList("ProductMapper.getCartList", buyerId); 
		//map.put("totalCount", sqlSession.selectOne("ProductMapper.getTotalCount", buyerId));

		map.put("list", list);

	return map;
	}
	
	public void deleteCart(int cartId) throws Exception {
		sqlSession.update("ProductMapper.deleteCart", cartId);
	}
	
	public List<Product> getAutoProdName(String keyword) throws Exception {
		return sqlSession.selectList("ProductMapper.getAutoProdName", keyword);
	}
	
	//21. 11. 6
	public List<Review> getReview(int prodNo) throws Exception{
		return sqlSession.selectList("ReviewMapper.getReviewList", prodNo); 
	}

}