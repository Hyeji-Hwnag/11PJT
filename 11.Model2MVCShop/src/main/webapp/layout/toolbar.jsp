<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">세 모 당</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                         
	                        
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li><a href="#">배송관리</a></li>
		                         
		                         
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role != 'admin'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                        
	                     </ul>
	                 </li>
	                 
	                
	             </ul>
	             <c:if test="${sessionScope.user.role != 'admin'}">
	                         <ul class="nav navbar-nav">
	                <li><a href="#">장바구니</a></li>
	            </ul>
	                         </c:if>
	                         
	                         
	              <c:if test="${!empty user }">
	              <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	                <!-- <li><a href="javascript:kakaoLogout();">카카오로그아웃</a></li> -->
	           		 </ul>
	                 </c:if>
	                 <c:if test="${empty user }">
	              <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그인</a></li>
	                <!-- <li><a href="javascript:kakaoLogout();">카카오로그아웃</a></li> -->
	           		 </ul>
	                 </c:if>
	             
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	<meta name="google-signin-client_id" content="727326734700-pjadupjtpl0m6tdje5nomsfksla5febn.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
   	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
   	<script type="text/javascript">
   	
   	// kakao
 	Kakao.init('51615d81a030d0475e576eb41e443c14');
	Kakao.isInitialized();
	 
	 Kakao.API.request({
		 url:'/v1/user/unlink',
		 success:function(response){
			 callbackFunction();
		 },
		 fail:function(error){
			 //alert("?");
		 }
	 });

	
		function signOut(){
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.signOut().then(function(){
				console.log('User logout');
			});
			auth2.disconnect();
		}
   	
   	
		//============= logout Event  처리 =============	
		 $(function() {
			 
	
			 
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
		 		
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
		
		
		
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","../product/addProductView.jsp");
		});
	 	
	 	$( "a:contains('판매상품관리')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
	 	$( "a:contains('배송관리')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/purchase/listTransaction");
		});
	 	
	 	$( "a:contains('상 품 검 색')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/listProduct?menu=search");
		});
		
		$( "a:contains('구매이력조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/purchase/listPurchase");
		});
		
		$( "a:contains('장바구니')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/listCart");
		});
		
		//============= 로그인 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('로그인')").on("click" , function() {
				self.location = "/user/login"
			});
		});
		
	
		
		
	</script>  