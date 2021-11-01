package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
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
	
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	/*
	//@RequestMapping("/addProduct.do")
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product , Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		//manuDate 그냥 들어가나? 안들어갈 것 같아서 처리 
		System.out.println("product : "+product);
		//String manuDate = product.getManuDate().substring(0,4)+product.getManuDate().substring(5,7)+product.getManuDate().substring(8);
		//product.setManuDate(manuDate);
		System.out.println("1");
		
		if(FileUpload.isMultipartContent(request)) {
			String temDir = "F:\\workspace_hhj\\07.Model2MVCShop(URI,pattern)_h\\src\\main\\webapp\\images\\uploadFiles\\";
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024*1024*100);
			fileUpload.setSizeThreshold(1024*100);
			System.out.println("2");
			if (request.getContentLength() < fileUpload.getSizeMax()) {
				StringTokenizer token = null;
				System.out.println("3");
				List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				for(int i=0; i<Size ; i++) {
					System.out.println("4");
					FileItem fileItem = (FileItem)fileItemList.get(i);
					if(fileItem.isFormField()){
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							String manuDate = token.nextToken()+token.nextToken()+token.nextToken();
							product.setManuDate(manuDate);
						}else if(fileItem.getFieldName().equals("prodName"))
							product.setProdName(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("prodDetail"))
							product.setProdDetail(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("price"))
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));						
					}else {
						if(fileItem.getSize()>0) {
							System.out.println("5");
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx==-1) {
								idx=fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx+1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							}catch(IOException e) {
								System.out.println(e);
							}
						}else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				}
				
				productService.addProduct(product);
				model.addAttribute("product", product);

				
			}else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alert('파일의 크기는 1MB까지 입니다. 올리신 파일 용량은"+overSize+"MB 입니다.');");
				System.out.println("history.back();</script>");
			}
		}else {
			System.out.println("인코딩 타입이 multipart/form-data가 아이다");
		}
		
		
		
		
		
		
		
		
		
		
		
		return "forward:/product/addProduct.jsp";
	}
	
	*/
	
	
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product , @RequestParam("uploadFile") MultipartFile file, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		//manuDate 그냥 들어가나? 안들어갈 것 같아서 처리 
		System.out.println("product : "+product);
		String manuDate = product.getManuDate().substring(0,4)+product.getManuDate().substring(5,7)+product.getManuDate().substring(8);
		product.setManuDate(manuDate);
		System.out.println("1");
		
		//String temDir = "E:\\workspace_hhj\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
		String temDir = "C:\\Users\\HHJ\\git\\repository\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
		
		
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(temDir, file.getOriginalFilename()));
			
		}
		product.setFileName(file.getOriginalFilename());
		productService.addProduct(product);
		model.addAttribute("product", product);

	
		return "forward:/product/addProduct.jsp";
	}
	
	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct")
	public String getProduct( @RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// Cookie 처리 해야 함 
		
		System.out.println("/product/getProduct : GET / POST");
		//Business Logic
		//System.out.println("proTranCode :"+proTranCode);
		Product product = productService.getProduct(prodNo);
		
		 
//		System.out.println("product.get::::::"+product.getProTranCode());
		model.addAttribute("product", product);
		
		if (menu.equals("manage")) {
			
			//return "forward:/product/updateProductView.do";
			//혹시 GET 방식으로 합칠 수 있는지 확인해보기.
			//일단...... 해보기! updateProduct로. 
			//return "forward:/product/updateProductView";
			return "/product/updateProduct";
		}
		
		String ckHistory = "";
		  
		for (Cookie c: request.getCookies()){


		      if (c.getName().equals("history")){

		    	  ckHistory=c.getValue();       
		      }
		  }
		   
			System.out.println("cookie "+ ckHistory);
		   Cookie cookie = new Cookie("history", prodNo+","+ckHistory);   // 쿠키 생성
		   cookie.setMaxAge(60*60);   // 헌재 Cookie의 유지기간
		   cookie.setPath("/");
		   response.addCookie(cookie);
		   //model.addAttribute("cookie", cookie);
		   // Model 과 View 연결
		   
		   // 쿠키 => 장바구니 -> session 
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/updateProductView.do")
	
	//public String updateProductView( @RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, @RequestParam("proTranCode") String proTranCode, Model model ) throws Exception{
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )	
	public String updateProduct( @RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu,  Model model ) throws Exception{
		System.out.println("/product/updateProduct : GET (updateProductView)");
		//Business Logic
		
		Product product = productService.getProduct(prodNo);
		//product.setProTranCode(proTranCode);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product , Model model) throws Exception{
		// , HttpSession session 있는거 삭제 1014

		System.out.println("product/updateProduct : POST");
		//System.out.println("proTranCode111 : "+product.getProTranCode());

		//Business Logic
		productService.updateProduct(product);
		//product.setProTranCode(product.getProTranCode());		
		
		return "forward:/product/getProduct?menu=search";	
	}
	
	//@RequestMapping("/checkProductDuplication.do")
	@RequestMapping( value="checkProductDuplication", method=RequestMethod.POST )	
	public String checkProductDuplication( @RequestParam("prodName") String prodName , Model model ) throws Exception{
		
		System.out.println("/product/checkProductDuplication : POST");
		//Business Logic
		boolean result=productService.checkDuplicationProduct(prodName);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("prodName", prodName);

		return  "forward:/product/checkDuplicationProduct.jsp";
	}
	

	
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , Model model ,  @RequestParam("menu") String menu,HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		if(search.getOrderColurm()=="" || search.getOrderColurm() == null) {
			search.setOrderColurm("p.prod_no");
		}
		
		
		
		System.out.println("tranCode: "+search.getTranStatusCode());
		System.out.println("search"+search);
		search.setPageSize(pageSize);
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println("list : "+map.get("list"));

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	// 21.10.15 cart 기능 
	@RequestMapping( value="addCart")
	public String addCart(@RequestParam("userId") String userId, @RequestParam("prodNo") String prodNumber) throws Exception {

		System.out.println("/product/addCart   : POST");

		int prodNo = Integer.parseInt(prodNumber);
		System.out.println("userid: "+userId);
		System.out.println("prodNo : "+prodNo);
		///boolean result = productService.validationCart(prodNo, userId);
		//System.out.println("result : "+result);
		//if (result == true) {
			//System.out.println("purchase : "+purchase);
		productService.addCart(prodNo, userId);
		
		//return "forward:/product/getProduct?prodNo="+prodNo+"&menu=search";
		
		return "redirect:/product/listCart";
		
	//	}else
	//	return "";
	}
	
	@RequestMapping( value="listCart" )
	public ModelAndView listCart( @ModelAttribute("search") Search search , HttpSession session) throws Exception{
		
	System.out.println("/product/listCart  : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		String buyerId=((User)session.getAttribute("user")).getUserId();
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getCartList(search, buyerId);
		Page resultPage = new Page( search.getCurrentPage(), 0, pageUnit, pageSize);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listCart.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
	}
	
	@RequestMapping( value="deleteCart" )
	public String deleteCart( @RequestParam("cartId") String cart_id) throws Exception{
		
	System.out.println("/product/deleteCart  : GET / POST");
		int cartId= Integer.parseInt(cart_id);
		
		productService.deleteCart(cartId);
		
		return "/product/listCart";
	}
	
	

}