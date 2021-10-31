package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface ProductDao {
	
	// INSERT
	public void addProduct(Product product) throws Exception;
	
	// SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	
	public Product getProduct2(String prodName) throws Exception;
	
	
	public void updateProduct(Product product) throws Exception;
	
	public List<Product> getProductList(Search search) throws Exception;
	
	public List<Product> getProductTranList(int prodNo) throws Exception;
	
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;

	public void addCart(Map map) throws Exception;
	public String validationCart(Map map) throws Exception;
	
	// 21. 10. 17 
	public Map<String,Object> getCartList(Search search,String buyerId) throws Exception;
	public void deleteCart(int cartId) throws Exception;

	//21. 10. 27 
	public List<Product> getAutoProdName(String keyword) throws Exception; 

}