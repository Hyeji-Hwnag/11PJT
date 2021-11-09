package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface PurchaseDao {
	
	// INSERT
	public void addPurchase(Purchase purchase) throws Exception ;	
	// SELECT ONE
	public Purchase getPurchase(int ProdNo) throws Exception;	
	public Purchase getPurchase2(int tranNo) throws Exception;
	public void  updatePurchase(Purchase purchase) throws Exception;
	public void  updateTranCode(Purchase purchase) throws Exception;
	public void  updateStockCntProduct(Product product) throws Exception;
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception;
	public List<Purchase> getSaleList(Search search) throws Exception;
	
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	// 21.10.13
	public Map<String, Object> getProductPurchaseList(int prodNo) throws Exception;
	//21. 10. 14
	public Map<String, Object> getTransactionList(Search search) throws Exception;
	//21. 11. 6
	public void addReview(Review review) throws Exception;
	public String validationReview(int tranNo)  throws Exception;
	
	//21.11.9
	public int getTrannoSq() throws Exception;
	public void addTranDetail(int tranNo, int prodNo, int stockCnt, String userId) throws Exception;
}