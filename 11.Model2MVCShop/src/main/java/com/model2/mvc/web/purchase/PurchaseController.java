package com.model2.mvc.web.purchase;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping( value="addPurchaseView")
	public ModelAndView addPurchase( @RequestParam("prodNo") String prodNumber) throws Exception {

		System.out.println("/purchase/addPurchase.do   : GET");
		System.out.println("prodNumber: "+prodNumber);
		
		String[] prodNm = prodNumber.split(",");
		List<Purchase> list = new ArrayList<>();
		for (int i=0; i<prodNm.length; i++)
		{
			int prodNo = Integer.parseInt(prodNm[i]);
			Purchase purchase = purchaseService.getPurchase(prodNo);
			list.add(purchase);
		}
		System.out.println("list : "+list);
	//	int prodNo = Integer.parseInt(prodNumber);
		//System.out.println("prodNo: "+prodNo);
	//	Purchase purchase = purchaseService.getPurchase(prodNo);
		
		//System.out.println("purchase ::: "+purchase);
		//model.addAttribute("purchase", purchase);
		
		//return "forward:/purchase/addPurchaseView.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("list", list);
		return modelAndView;
		
		
	}
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping( value="addPurchase")
	public void addPurchase( @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product,  @ModelAttribute("user") User user) throws Exception {

		System.out.println("/purchase/addPurchase   : POST");
		System.out.println("purchase : "+purchase);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
	
		System.out.println("purchase : "+purchase);
//		purchaseService.addPurchase(purchase);
//		purchaseService.updateStockCntProduct(product.getProdNo(), product.getStockCnt()-purchase.getStockCount());
		
//		
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/addPurchase.jsp";
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("/purchase/addPurchase.jsp");
//		modelAndView.addObject("purchase", purchase);
//		return modelAndView;
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping( value="getPurchase")
	public ModelAndView getPurchase( @RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/purchase/getPurchase    : GET/POST");

		Purchase purchase = purchaseService.getPurchase2(tranNo);
		
		System.out.println("purchase : "+purchase);
		//System.out.println("purchase.getDivyRequest : "+purchase);
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/getPurchase.jsp"; //// jsp getPurchase로 보냄 
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}
	
	

	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping( value="listPurchase" )
	public ModelAndView listPurchase( @ModelAttribute("search") Search search , HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase  : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		String buyerId=((User)session.getAttribute("user")).getUserId();
		
		search.setPageSize(pageSize);
		System.out.println("search"+search);
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, buyerId);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);
//		return "forward:/purchase/listPurchase.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
		
	}
	
	
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )	
	public ModelAndView updatePurchase( @RequestParam("tranNo") String tranNumber) throws Exception{

		
		System.out.println("/purchase/updatePurchase   :: GET ");
		int tranNo = Integer.parseInt(tranNumber);
		Purchase purchase = purchaseService.getPurchase2(tranNo);
		
		
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/updatePurchaseView.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}
	
	
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )	
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") String tranNumber) throws Exception{


		System.out.println("/purchase/updatePurchase   : POST");
		System.out.println("trnNumber"+tranNumber);

		
		int tranNo = Integer.parseInt(tranNumber);
		System.out.println("trNO : "+tranNo);

		purchase.setTranNo(tranNo);
		System.out.println("purchase : "+purchase);
		//Business Logic
		String dlvyDate = purchase.getDivyDate().substring(0,4)+purchase.getDivyDate().substring(5,7)+purchase.getDivyDate().substring(8,10);

		purchase.setDivyDate(dlvyDate);
		
		purchaseService.updatePurchase(purchase);
//		model.addAttribute("purchase", purchase);
//		model.addAttribute("tranNo", tranNo);
//		return "forward:/getPurchase.do";
		// 이전... //return "forward:/getPurchase.do?tranNo="+tranNo;
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase");
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("tranNo", tranNo);
		return modelAndView;
	}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	//public ModelAndView updateTranCode( @ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode) throws Exception{
	public ModelAndView updateTranCode( @ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") int tranNo) throws Exception{

		
		System.out.println("/purchase/updateTranCode       :: GET ");
		
		purchase.setTranCode("3"); 
		purchase.setTranNo(tranNo);
		
		purchaseService.updateTranCode(purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
		//return "redirect:/listPurchase.do";
		return modelAndView;
	}
	
//	@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping( value="updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(  @RequestParam("tranNo") int tranNo, @RequestParam("type") String url, @RequestParam("prodNo") String prodNo) throws Exception{

		
		System.out.println("/purchase/updateTranCodeByProd");
		Purchase purchase=new Purchase();
		

		purchase.setTranCode("2"); // 1-> 2로 변경된거니까?!!!!!!!!!! ^^...
		purchase.setTranNo(tranNo);
		
		purchaseService.updateTranCode(purchase);

		//return "redirect:/checkProductTranCode.do?prodNo="+prodNo;
		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("redirect:/purchase/checkProductTranCode?prodNo="+prodNo);
		modelAndView.setViewName("redirect:/purchase/"+url);
		modelAndView.addObject("prodNo", prodNo);
		return modelAndView;
	}
	
//	@RequestMapping("/checkProductTranCode.do")
	@RequestMapping( value="checkProductTranCode", method=RequestMethod.GET )
	public ModelAndView checkProductTranCode( @RequestParam("prodNo") String prodNumber ) throws Exception{
		
		System.out.println("/purchase/checkProductTranCode  :: GET");
		//Business Logic
		int prodNo = Integer.parseInt(prodNumber);
		Map<String , Object> map=purchaseService.getProductPurchaseList(prodNo);
		
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProdPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value="listTransaction")
	public ModelAndView listTransaction(@ModelAttribute("search") Search search , HttpSession session) throws Exception{
		
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
				
		search.setPageSize(pageSize);
		// Business logic 수행
		Map<String , Object> map=purchaseService.getTransactionList(search);
		
		System.out.println("map: "+map);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+((Integer)map.get("totalCount")).intValue());
		System.out.println("list : "+map.get("list"));

		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listTransaction.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="addReviewView")
	public ModelAndView addReviewView( @RequestParam("tranNo") String tranNumber, @RequestParam("prodNo") String prodNumber, HttpSession session) throws Exception {
		System.out.println("/purchase/addReviewView.do   : GET");
		
		int tranNo = Integer.parseInt(tranNumber);
		int prodNo = Integer.parseInt(prodNumber);
		String userId=((User)session.getAttribute("user")).getUserId();
		
		System.out.println("userId: "+userId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("tranNo", tranNo);
		modelAndView.addObject("prodNo", prodNo);
		modelAndView.addObject("userId", userId);

		boolean result = purchaseService.validationReview(tranNo);
		if (result == true) { // 적은게 없으면 
			System.out.println("적은거 없어");
			modelAndView.setViewName("/product/productReview.jsp");
		}else {//적은게 있으면 
			System.out.println("적은거 잇으.......");
			modelAndView.setViewName("/product/productReview.jsp");
		}
		
		
		return modelAndView;
		
	}
	
	
	
	//21. 11. 6 review
	//@RequestMapping("/addPurchase.do")
//	@RequestMapping( value="addReview")
//	public void addReview( @ModelAttribute("review") Review review) throws Exception {
//
//		System.out.println("/purchase/addReview   : POST");
//		System.out.println("review : "+review);
//		
//		purchaseService.addReview(review);
//		
//		Purchase purchase = purchaseService.getPurchase2(review.getTranNo());
//		purchase.setTranCode("4"); 
//		purchaseService.updateTranCode(purchase);  
//		
//		
//		
//	}
	
	
	
	
}