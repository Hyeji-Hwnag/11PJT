package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	

	

	//@RequestMapping( value="json/autoProduct/{keyword}", method=RequestMethod.POST)
	@RequestMapping( value="json/autoProduct", method=RequestMethod.POST)
	//public ArrayList AutoProduct( @PathVariable String keyword, Locale locale, Model model, HttpServletRequest request,
	public ArrayList AutoProduct(  Locale locale, Model model, HttpServletRequest request,
			 HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		System.out.println("/json/AutoProduct : GET");
		String keyword = request.getParameter("keyword");
		List<Product> list = productService.getAutoProdName(keyword);
	
		ArrayList ja = new ArrayList();
		
		
		
		for(int i=0; i<list.size(); i++) {
			
			ja.add(list.get(i).getProdName());
			
		}
		System.out.println("ja: "+ja);
		return ja;
	
	}
	
	
	
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public Map listProduct(  HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		System.out.println("/product/listProduct : GET11111111111111111");
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String orderColurm = "p.prod_no";
		if (request.getParameter("orderColurm") != null || request.getParameter("orderColurm") != "") {
			orderColurm = request.getParameter("orderColurm");
		}
//		String keyword = request.getParameter("keyword");
	System.out.println("c : "+currentPage);
	System.out.println("orderColurm : "+orderColurm);
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setOrderColurm(orderColurm);
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		//manuDate 그냥 들어가나? 안들어갈 것 같아서 처리 
		System.out.println("product : "+product);
		String manuDate = product.getManuDate().substring(0,4)+product.getManuDate().substring(5,7)+product.getManuDate().substring(8);
		product.setManuDate(manuDate);
		System.out.println("1");
		
		String temDir = "E:\\workspace_hhj\\07.Model2MVCShop(URI,pattern)_h\\src\\main\\webapp\\images\\uploadFiles\\";
		
		
		
//		if(!file.getOriginalFilename().isEmpty()) {
//			file.transferTo(new File(temDir, file.getOriginalFilename()));
//			
//		}
		//product.setFileName(file.getOriginalFilename());
		
		productService.addProduct(product);
		//model.addAttribute("product", product);

	
		//return "forward:/product/addProduct.jsp";
		return productService.getProduct(10010);
	    // prodNo 로 받아오기
	}
	
	

	
	
	
	
	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="json/getProduct/{prodNm}/{menu}")
	public Product getProduct( @PathVariable String prodNm ,  @PathVariable String menu , HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// Cookie 처리 해야 함 
		
	System.out.println("/product/getProduct : GET / POST");
		//Business Logic
		//System.out.println("proTranCode :"+proTranCode);
		int prodNo = Integer.parseInt(prodNm);
		Product product = productService.getProduct(prodNo);
		
		 
//		System.out.println("product.get::::::"+product.getProTranCode());
		//model.addAttribute("product", product);
		
		if (menu.equals("manage")) {
			
			//return "forward:/product/updateProductView.do";
			//혹시 GET 방식으로 합칠 수 있는지 확인해보기.
			//일단...... 해보기! updateProduct로. 
			//return "forward:/product/updateProductView";
			System.out.println("manage로 넘어옴");
		}
		System.out.println("search로 넘어옴");
//		String ckHistory = "";
//		  
//		for (Cookie c: request.getCookies()){


		      //if (c.getName().equals("history")){

		    	//  ckHistory=c.getValue();       
		     // }
		 // }
		   
//		System.out.println("cookie "+ ckHistory);
	//	   Cookie cookie = new Cookie("history", prodNo+","+ckHistory);   // 쿠키 생성
		//   cookie.setMaxAge(60*60);   // 헌재 Cookie의 유지기간
		 //  cookie.setPath("/");
		  // response.addCookie(cookie);
		   //model.addAttribute("cookie", cookie);
		   // Model 과 View 연결
		   
		   // 쿠키 => 장바구니 -> session 
		
		//return "forward:/product/getProduct.jsp";
		   return productService.getProduct(prodNo);
	}

}