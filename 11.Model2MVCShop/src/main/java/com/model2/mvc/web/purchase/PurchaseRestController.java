package com.model2.mvc.web.purchase;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping( value="json/kakaopay")
	@ResponseBody
	public String kakaopay(HttpServletRequest request) {
		System.out.println("111");
		try {
			int price = Integer.parseInt(request.getParameter("price"));
			String prodName = request.getParameter("prodName");
			
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK 2bc6f55f268ffcd4fadc8ac1eb6edc7a");
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			con.setDoOutput(true);
			String param ="cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name="+prodName+"&quantity=1&total_amount="+price+"&vat_amount=200&tax_free_amount=0&approval_url=http://127.0.0.1:8080/purchase/comPurchase.jsp&fail_url=http://127.0.0.1:8080&cancel_url=http://127.0.0.1:8080";
			OutputStream output = con.getOutputStream();
			DataOutputStream dataoutput = new DataOutputStream(output);
			
			dataoutput.writeBytes(param);
			dataoutput.close();
			
			int resultcode = con.getResponseCode();
			InputStream inputstream;
			if(resultcode == 200) {
				inputstream = con.getInputStream();
			}else {
				inputstream = con.getErrorStream();
			}
			InputStreamReader inputstreamR = new InputStreamReader(inputstream);
			BufferedReader br = new BufferedReader(inputstreamR);
			return br.readLine();
			
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "{\"result\":\"NO\"}";
	}
	
	
	

	
	@RequestMapping( value="json/addReview", method=RequestMethod.POST)
	public Review addReview( HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/purchase/addReview   : POST");
		request.setCharacterEncoding("UTF-8");
		
		int star = Integer.parseInt(request.getParameter("star"));
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		String userId = request.getParameter("userId");
		String reviewText = request.getParameter("reviewText");
		
		Review review = new Review();
		review.setProdNo(prodNo);
		review.setTranNo(tranNo);
		review.setStar(star);
		review.setUserId(userId);
		review.setReviewText(reviewText);
		
		System.out.println("review : "+review);
		
		purchaseService.addReview(review);
		
		Purchase purchase = purchaseService.getPurchase2(review.getTranNo());
		purchase.setTranCode("4"); 
		purchaseService.updateTranCode(purchase);  
		
		
		return review;
	}
	
	
	
	@RequestMapping( value="json/addPurchase", method=RequestMethod.POST)
	public List<Purchase> addPurchaseView( @RequestParam(value="prodParam[]") List<String> prodParam, @RequestParam(value="stkcntParam[]") List<String> stkcntParam, @RequestParam(value="paymentOption") String paymentOption, @RequestParam(value="receiverName") String receiverName, @RequestParam(value="receiverPhone") String receiverPhone,@RequestParam(value="divyAddr") String divyAddr, @RequestParam(value="divyRequest") String divyRequest, @RequestParam(value="divyDate") String divyDate, HttpServletRequest request, HttpServletResponse response,  HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase.do   : post");
		request.setCharacterEncoding("UTF-8");

		System.out.println("prodParam: "+prodParam);
		String buyerId=((User)session.getAttribute("user")).getUserId();
		User user = new User();
		user.setUserId(buyerId);
		
		Purchase purchase = new Purchase();
		purchase.setBuyer(user);
		purchase.setPaymentOption(paymentOption);
		purchase.setReceiverName(receiverName);
		purchase.setReceiverPhone(receiverPhone);
		purchase.setDivyAddr(divyAddr);
		purchase.setDivyRequest(divyRequest);
		purchase.setDivyDate(divyDate);
		
		// tranNo를 받아올 시퀀스를 불러와야함 
		int tranNo = purchaseService.getTrannoSq();
		//System.out.println(purchaseService.getTrannoSq()+"purchaseService.getTrannoSq()");
		//System.out.println("tranNo : "+tranNo);
		purchase.setTranNo(tranNo);
		purchaseService.addPurchase(purchase);
		
		List<Purchase> list = new ArrayList<>();

		int prodNo;
		int stockCnt;
		
		for (int i=0; i<prodParam.size(); i++) {
			prodNo = Integer.parseInt(prodParam.get(i));
			stockCnt = Integer.parseInt(stkcntParam.get(i));
			System.out.println("stockCnt : "+stockCnt);
			purchaseService.addTranDetail(tranNo, prodNo, stockCnt, buyerId);
			Product product = productService.getProduct(prodNo);
			System.out.println("product: "+product);
			System.out.println("product.getStockCnt()-stockCnt"+(product.getStockCnt()-stockCnt));
			purchaseService.updateStockCntProduct(prodNo, product.getStockCnt()-stockCnt);
		}
			

	      
		return list;
		
		//Purchase purchase = new Purchase();
		//return purchase;
		
		//System.out.println("purchase ::: "+purchase);
		//model.addAttribute("purchase", purchase);
		
		//return "forward:/purchase/addPurchaseView.jsp";
		
	//	ModelAndView modelAndView = new ModelAndView();
	//	modelAndView.setViewName("/product/listProduct.jsp");
	//	modelAndView.addObject("purchase", purchase);
	//	return modelAndView;
		
		
	}
	
	
	
	
}