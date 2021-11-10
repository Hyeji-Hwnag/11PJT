package com.model2.mvc.service.domain;

import java.sql.Date;

import com.model2.mvc.service.domain.*;


public class Trandetail {
	
	private int tdNo;
	private int tranNo;
	private int prodNo;
	private int stockCnt;
	private String buyerId;
	
	
	public int getTdNo() {
		return tdNo;
	}

	public int getTranNo() {
		return tranNo;
	}

	public int getProdNo() {
		return prodNo;
	}

	public int getStockCnt() {
		return stockCnt;
	}

	public String getBuyerId() {
		return buyerId;
	}

	public void setTdNo(int tdNo) {
		this.tdNo = tdNo;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}

	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	
	@Override
	public String toString() {
		return "PurchaseVO [tdNo=" + tdNo + ", tranNo=" + tranNo
				+ ", prodNo=" + prodNo + ", stockCnt=" + stockCnt
				+ ", buyerId=" + buyerId+ "]";
	}

	
	
}