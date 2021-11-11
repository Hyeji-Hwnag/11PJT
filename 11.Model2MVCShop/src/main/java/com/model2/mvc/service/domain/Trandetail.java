package com.model2.mvc.service.domain;

import java.sql.Date;

import com.model2.mvc.service.domain.*;


public class Trandetail {
	
	private int tdNo;
	private Purchase tranPurchase;
	private Product tranProduct;
	private User tranUser;
	private int stockCnt;
	
	//private int tranNo;
	//private int prodNo;
	
	//private String buyerId;
	
	
	@Override
	public String toString() {
		return "PurchaseVO [tdNo=" + tdNo + ", tranPurchase=" + tranPurchase
				+ ", tranProduct=" + tranProduct + ", tranUser=" + tranUser
				+ ", stockCnt=" + stockCnt+ "]";
	}

	public int getTdNo() {
		return tdNo;
	}

	public Purchase getTranPurchase() {
		return tranPurchase;
	}

	public Product getTranProduct() {
		return tranProduct;
	}

	public User getTranUser() {
		return tranUser;
	}

	public int getStockCnt() {
		return stockCnt;
	}

	public void setTdNo(int tdNo) {
		this.tdNo = tdNo;
	}

	public void setTranPurchase(Purchase tranPurchase) {
		this.tranPurchase = tranPurchase;
	}

	public void setTranProduct(Product tranProduct) {
		this.tranProduct = tranProduct;
	}

	public void setTranUser(User tranUser) {
		this.tranUser = tranUser;
	}

	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}

	
	
}