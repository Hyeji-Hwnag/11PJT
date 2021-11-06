package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;


public interface ProductService {
	
	public void addProduct(Product product) throws Exception;

	public Product getProduct(int prodNo) throws Exception;
	
	public Product getProduct2(String prodName) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	//21. 10. 02. 재고관리 위하여 추가시킴 
	public boolean checkDuplicationProduct(String prodName) throws Exception;
	public Map<String,Object> getProductTranList(int prodNo)  throws Exception;
	
	//21. 10. 15 장바구니추가  
	public void addCart(int prodNo, String userId)throws Exception;
	//21. 10. 15 장바구니 유효성 체크 
	public boolean validationCart(int prodNo, String userId)throws Exception;
	//21. 10. 17 장바구니 리스트 
	public Map<String,Object> getCartList(String buyerId) throws Exception;
	//21. 10. 17 delete 
	public void deleteCart(int cartId) throws Exception;
	
	//21. 10. 27 autoComplete
	public List<Product> getAutoProdName(String keyword) throws Exception;

	//21. 11. 6 review
	public List<Review> getReview(int prodNo) throws Exception;
}