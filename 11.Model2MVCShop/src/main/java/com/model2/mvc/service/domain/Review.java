package com.model2.mvc.service.domain;

public class Review {
	
	//F
	private int reviewId;
	private String userId;
	private int prodNo;
	private int tranNo;
	private String reviewText;
	private int star;
	
    public int getReviewId() {
		return reviewId;
	}

	public String getUserId() {
		return userId;
	}

	public int getProdNo() {
		return prodNo;
	}

	

	public int getStar() {
		return star;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	

	public void setStar(int star) {
		this.star = star;
	}

	public int getTranNo() {
		return tranNo;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public String getReviewText() {
		return reviewText;
	}

	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}

	@Override
    public String toString() {
        return "Review [reviewId=" + reviewId + ", userId=" + userId + ", tranNo=" + tranNo + ", prodNo=" + prodNo + ", review=" + reviewText + ", star="
                + star + "]";
    }
}
