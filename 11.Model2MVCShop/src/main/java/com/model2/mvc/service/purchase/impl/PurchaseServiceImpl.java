package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductDao;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
		//PurchaseDao=new PurchaseDao();
	}

	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
	}
	
	public Purchase getPurchase(int prodNo) throws Exception {
		return purchaseDao.getPurchase(prodNo);
	}
	
	public Purchase getPurchase2(int tranNo) throws Exception{
			return purchaseDao.getPurchase2(tranNo);
	}
	
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception {
		
		return purchaseDao.getPurchaseList(search, buyerId);
	}
	
	public Map<String,Object> getSaleList(Search search) throws Exception {
		return null;//purchaseDao.getSaleList(search);
	}

	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}
	
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

	//21. 10. 02  inventory count 숫자 증가 
	public void updateStockCntProduct(int prodNo, int stockCnt) throws Exception {
		Product product = new Product();
		product.setProdNo(prodNo);
		product.setStockCnt(stockCnt);
		System.out.println("prodNo: "+product.getProdNo());
		System.out.println("stockCnt: "+product.getStockCnt());
		purchaseDao.updateStockCntProduct(product);
	}
	
	//21. 10. 13 
	public Map<String, Object> getProductPurchaseList(int prodNo) throws Exception{
		return purchaseDao.getProductPurchaseList(prodNo);
	}
	
	//21. 10. 14
	public Map<String, Object> getTransactionList(Search search) throws Exception{
		return purchaseDao.getTransactionList(search);
	}
	
	//21. 11. 6
	public void addReview(Review review) throws Exception{
		purchaseDao.addReview(review);
	}

	public boolean validationReview(int tranNo) throws Exception{
		boolean result = true;
		String res = purchaseDao.validationReview(tranNo);
		System.out.println("Res: "+res);
		
		if ( res == "" || res == null || res.equals("") || res.equals(null)) {
			result = true;
		}else {
			result= false;
		}
		return result;
	}
	//21. 11. 9 
	public int getTrannoSq() throws Exception{
		//System.out.println("오닝?");
		return purchaseDao.getTrannoSq();
	}
	public void addTranDetail(int tranNo, int prodNo, int stockCnt, String userId) throws Exception {
		purchaseDao.addTranDetail(tranNo, prodNo, stockCnt, userId);
	}
	
	

}