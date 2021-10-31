package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;


public interface PurchaseService {

	public void addPurchase(Purchase purchase) throws Exception;
	
	public Purchase getPurchase(int ProdNo) throws Exception;
	
	public Purchase getPurchase2(int tranNo) throws Exception;
	
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception;
	
	public Map<String,Object> getSaleList(Search search) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	//21.10.02
	public void updateStockCntProduct(int prodNo, int stockCnt) throws Exception;

	//21.10.13 product -> ¿Ãµø 
	public Map<String, Object> getProductPurchaseList(int prodNo) throws Exception;

	//21.10.14 
	public Map<String, Object> getTransactionList(Search search) throws Exception;
}