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
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
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
	
	
	
	
	
	
	
	
	
	
	
}