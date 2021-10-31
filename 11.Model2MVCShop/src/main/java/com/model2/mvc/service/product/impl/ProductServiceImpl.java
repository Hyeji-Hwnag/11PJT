package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.domain.Product;



@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	public void addProduct(Product product) throws Exception {
		productDao.addProduct(product);
	}


	public Product getProduct(int prodNo) throws Exception {
		return productDao.getProduct(prodNo);
	}
	public Product getProduct2(String prodName) throws Exception {
		return productDao.getProduct2(prodName);
	}

	public Map<String,Object> getProductList(Search search) throws Exception {
		//return productDAO.getProductList(search);
		System.out.println("search:::: "+search);
		List<Product> list= productDao.getProductList(search);
		//int totalCount = productDao.getTotalCount(search);
		System.out.println("list"+list);
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("search.getOrderColurm"+search.getOrderColurm());
		map.put("list",list);
		map.put("totalCount", productDao.getTotalCount(search));
		
		return map;
	}
	
	public Map<String,Object> getProductTranList(int prodNo)  throws Exception {
		
		List<Product> list= productDao.getProductTranList(prodNo);
		//int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		//map.put("totalCount", new Integer(totalCount));
		
		
		return map;
	}
	
	
	
	

	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}
	
	/* inventory 관리를 위하여 product에 추가시킴 */
	
	public boolean checkDuplicationProduct(String prodName) throws Exception{

			boolean result=true;
			Product product=productDao.getProduct2(prodName);
			if(product != null) {
				result=false;
			}
			System.out.println("result: "+result);
			return result;
	}

	// 21. 10. 15 
	public void addCart(int prodNo, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prodNo", prodNo);
		map.put("userId", userId);
		productDao.addCart(map);
		
	}
	
	public boolean validationCart(int prodNo, String userId)throws Exception {
		boolean result = true;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prodNo", prodNo);
		map.put("userId", userId);
		//System.out.println("prodNo :"+prodNo+" userId :"+userId);
		//String res = productDao.validationCart(map);
		//System.out.println("res: "+res);
		//if ( res.equals("Y")) {
		//	result = false;
		//}
		return result;
	}
	
	//21. 10. 17 
	public Map<String,Object> getCartList(Search search,String buyerId) throws Exception {
		
		return productDao.getCartList(search, buyerId);
	}
	
	public void deleteCart(int cartId) throws Exception{
		productDao.deleteCart(cartId);
	}
	
	//21. 10. 27 
	public List<Product> getAutoProdName(String keyword) throws Exception{
		return productDao.getAutoProdName(keyword);
	}
}

	
	
