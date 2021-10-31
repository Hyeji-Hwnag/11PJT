package com.model2.mvc.service.domain;

import java.sql.Date;


public class Product {
	
	//Field
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	private int stockCnt; // 21.10.02 수량 추가 
	//con
	
	// cart 관련 
	// 이걸 따로 dao 를 만들어야하나? 
	// 고민..
	private int cartId;
	private String flag; 
	
	public Product(){
	}
	
	//met
	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	/* 
	 * 21.10.02 stockCnt 추가.
	 */
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}

	public int getCartId() {
		return cartId;
	}

	public String getFlag() {
		return flag;
	}

	
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	

	// Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo+"[proTranCode]"+proTranCode+"[stockCnt]"+stockCnt;
	}	
}