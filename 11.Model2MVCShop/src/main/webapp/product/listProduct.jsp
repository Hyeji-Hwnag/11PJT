<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html  lang="ko">
<head>
<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />





<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- 아래 2줄  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />




<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
<!-- jQuery UI toolTip 사용 CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip 사용 JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	

<style>
.ui-autocomplete{
	position: absolute; 
    cursor: default; 
    height: 200px; 
    overflow-y: scroll; 
    overflow-x: hidden;}
    
    body {
            padding-top : 50px;
        }
</style>


<script type="text/javascript">

function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	var menu = $("input[name='menu']").val()
	
   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
} 

function fncGetOrderList(currentPage, orderColurm){
	$("#currentPage").val(currentPage)
	$("#orderColurm").val(orderColurm)
	var menu = $("input[name='menu']").val()
	
	
	//$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
   	
}


$(function() {
	


	 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
		 fncGetUserList('1');
	});
	 
	 $( "input[value='가격낮은순']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.price')
		 fncGetOrderList('1', 'p.price');
	});
	 
	 $( "input[value='가격높은순']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.price desc')
	 
		 fncGetOrderList('1', 'p.price desc');
	});
	 
	 $( "input[value='상품명낮은순']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.prod_name asc')
	 
		 fncGetOrderList('1', 'p.prod_name asc');
	});
	 
	 $( "input[value='상품명높은순']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.prod_name desc')
		 fncGetOrderList('1', 'p.prod_name desc');
	});
	 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	
	$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		var menu = $("input[name='menu']").val()
		var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
				
		var prodNo = td.eq(2).find("input").val();
		
				
		self.location ="/product/getProduct?menu="+menu+"&prodNo="+prodNo;
	});
	
	

	
	/* $("a:contains('상세정보')").on("click" , function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=search&prodNo="+prodNo;
	});  */
	
	$("body").on("click", ".detail_btn1", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=search&prodNo="+prodNo;
	}); 
	
	
	//$("a:contains('상품수정')").on("click" , function() {
	$("body").on("click", ".detail_btn2", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=manage&prodNo="+prodNo;
	}); 
	
	
	//$("a:contains('판매관리')").on("click" , function() {
	$("body").on("click", ".detail_btn3", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		popWin 
		= window.open("/purchase/checkProductTranCode?prodNo="+prodNo,
									"popWin", 
									"left=300,top=200,width=700,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	}); 
	
	
	//$("a:contains('장바구니')").on("click" , function() {
	$("body").on("click", ".detail_btn4", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		var userId = $(this).parent().find("input[name='userId']").val();
		
		self.location = "/product/addCart?prodNo="+prodNo+"&userId="+userId;
	}); 
	
	
	//$("a:contains('구매')").on("click" , function() {
	$("body").on("click", ".detail_btn5", function() {	
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		var stockCnt=$(this).parent().find("input[name='stockCnt']").val();
		
		if (stockCnt<=0){
			alert("수량이 부족하여 구매를 할 수 없습니다. ");
			return;
		}else{
			self.location ="/purchase/addPurchaseView?prodNo="+prodNo;
			

		}
		
	}); 
	
	
	
	
	
	
	
	
	
	
	
	$("td.checkT:contains('판매관리')").on("click" , function() {
		
			var checkBtn = $(this);
			var tr = checkBtn.parent();
			var td = tr.children();
						
			var prodNo = td.eq(2).find("input").val();
			
		//alert($("td.ct_btn:contains('ID중복확인')").html());
		popWin 
		= window.open("/purchase/checkProductTranCode?prodNo="+prodNo,
									"popWin", 
									"left=300,top=200,width=700,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	});
 
	
	
	$("#autoCompl").autocomplete({
		
		source : function(request, response) {
			//var keyword = $("#autoCompl").val();
			$.ajax({

				url : "/product/json/autoProduct",
				method : "POST",
				dataType : "json",
				contentType: "application/x-www-form-urlencoded;",  
				data : { keyword : $("#autoCompl").val() },
				success : function(data) {

					var result = data;

					response(result);

				},

				error : function(data) {
	

					alert("에러가 발생하였습니다.")

				},
				
			});
		}
	});
	
	

});


 
 
 
var page=2;
$(window).scroll(function() {
	
	//alert("window.scrollY"+window.scrollY)
    //if ($(window).scrollTop()  == $(document).height() - $(window).height()) {
	if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
	
	    loadList();
      
    }
});



var loadList = function(){
		var userId = $("input[name='userId']").val()
		var menu = $("input[name='menu']").val()
		
	 $.ajax({

	 	url : "/product/json/listProduct",
	 	method : "POST",
	 	dataType : "json",
	 	data : { currentPage : page, 
	 		searchCondition : $("select[name='searchCondition']").val(),
	 		searchKeyword : $("#autoCompl").val(),
	 		orderColurm : $("input[name='orderColurm']").val()
	 		},
	 	
	 	//contentType:"application/json;charset=UTF-8", 
	 	contentType: "application/x-www-form-urlencoded;", 
	 	success : function(jsonData) {
	 		page++;
	 		var list = jsonData.list;
	 		
	 		for(var i=0; i<list.length; i++){
	 			var div="";
	 			
	 			div += 
	 				"<div class='col-sm-6 col-md-4'>"+
	 				"<div class='thumbnail'>"+
	 			    "<img src='/images/uploadFiles/"+list[i].fileName+"' width='200' height='200' alt='...' />"+
	 			      
	 			      "<div class='caption'>"+
	 			        "<h3>"+list[i].prodName+"</h3>"+
	 			        "<input type='hidden' id='prodNo' name='prodNo' value='"+list[i].prodNo+"'/>"+
	 			        "<p>가격 : "+list[i].price+"원</p>";
	 			if (list[i].stockCnt==0){
	 				div += "<p>재고없음 </p>";
	 			}else if (list[i].stockCnt!=0){
	 				div += "<p>수량: "+list[i].stockCnt+"개</p> ";
	 			}
	 			div += "<p>"+
	 			"<input type='hidden' id='prodNo' name='prodNo' value='"+list[i].prodNo+"'/>"+
	 			"<input type='hidden' id='userId' name='userId' value='"+userId+"'/>"+
	 			"<input type='hidden' id='stockCnt' name='stockCnt' value='"+list[i].stockCnt+"'/>"+
	 			"<a href='#' class='btn btn-default detail_btn1' role='button'>상세정보</a>";
	 			
	 			
	 			if (userId !== ""){
	 			
	 			if( userId == 'admin' && menu == 'manage'){
	 				div += "<a href='#' class='btn btn-default detail_btn2' role='button'>상품수정</a>"+
	 				"<a href='#' class='btn btn-default detail_btn3' role='button'>판매관리</a>";
	 			}
	 			
	 			if(  userId != 'admin' && menu == 'search'){
	 				div += "<a href='#' class='btn btn-default detail_btn4' role='button'>장바구니</a>"+
	 				"<a href='#' class='btn btn-default detail_btn5' role='button'>구매</a>";
	 			}
	 			
	 			}
	 			
	 			div +=  "</p> </div> </div> </div>";
	 			$('.row').append(div);
	 		  
	 			
	 		}
	 		
	 		
	 		

	 	},

	 	error : function() {

	 		alert("1에러가 발생하였습니다.")

	 	},
	 	
	 });
  

}
		
		


</script>
</head>

<body bgcolor="#ffffff" text="#000000">


<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	


<div class="container">
<div class="page-header text-info">
	       <h3><c:if test="${menu eq 'manage'}">
						상품 관리
					</c:if>
					<c:if test="${menu eq 'search'}">
						상품 검색
					</c:if></h3>
	    </div>



<!-- <form name="detailForm" action="/product/listProduct?menu=${menu}" method="post"> -->
<form name="detailForm">



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<!-- <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option> -->
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			
			</select>
			<input type="text" id="autoCompl" name="searchKeyword"  value="${search.searchKeyword}"  class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetUserList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<p>전체  ${resultPage.totalCount } 건수<!-- , 현재 ${resultPage.currentPage}  페이지--></p>
<input name="menu" type="hidden" value="${menu}"/>
		<input type="hidden" id="orderColurm" name="orderColurm" value="${search.orderColurm}"/>
		<input type="hidden" id="orderKey" name="orderKey" value=""/>
		<input type="hidden" id="tranStatusCode" name="tranStatusCode" value=""/>
		
			 

		<!-- <a href="javascript:fncGetOrderList('1', 'p.price');">▲가격낮은순</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.price desc');">▼가격높은순</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name asc');">▲상품명</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name desc');">▼상품명</a>&nbsp;&nbsp;&nbsp;
		 -->
		<input type="button" value="가격낮은순"/>
		<input type="button" value="가격높은순"/>
		<input type="button" value="상품명낮은순"/>
		<input type="button" value="상품명높은순"/>
<div class="row">

<c:forEach var="product" items="${list}">

  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
    <img src="/images/uploadFiles/${product.fileName}" width="200" height="200" alt="..." />
      
      <div class="caption">
        <h3>${product.prodName}</h3>
        <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
        <p>가격 : ${product.price }원</p>
        <c:if test="${product.stockCnt == 0}">
		<p>재고없음 </p>
		</c:if>
		<c:if test="${product.stockCnt != 0}">
		<p>수량: ${product.stockCnt}개</p> 
		</c:if>
		<p>
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		<input type="hidden" id="userId" name="userId" value="${user.userId}"/>
		<input type="hidden" id="stockCnt" name="stockCnt" value="${product.stockCnt}"/>
		
			<a href="#" class="btn btn-default detail_btn1" role="button">상세정보</a>
		
		
		
		
		<c:if test="${!empty user && user.userId eq 'admin' && menu eq 'manage'}">
        <a href="#" class="btn btn-default detail_btn2" role="button">상품수정</a> 
        <a href="#" class="btn btn-default detail_btn3" role="button">판매관리</a>
        </c:if>
        
        <c:if test="${!empty user && user.role eq 'user' && menu eq 'search'}">
        <a href="#" class="btn btn-default detail_btn4" role="button">장바구니</a> 
        <a href="#" class="btn btn-default detail_btn5" role="button">구매</a> 
        </c:if>
        
        
       
      </p>
        
      	 
      </div>
    </div>
  </div>

</c:forEach>
</div>

<%-- 
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격 </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">수량</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
		<td class="ct_line02"></td>
		<td class="ct_list_b">판매관리</td>	
		</c:if>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:forEach var="product" items="${list}">
	
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		21/9/29
			proTranCode를 보냄 / 구매에서 쓰려고
		<td align="left">
		<!-- <a href="/product/getProduct?prodNo=${product.prodNo }&menu=${menu}">${product.prodName }</a> -->
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		${product.prodName}
		</td>
		<td></td>
		<td align="left">${product.price }</td>
		<td></td>
		<td align="left">${product.manuDate }</td>
		<td></td>
		<td align="left">
		<c:if test="${product.stockCnt == 0}">
			재고없음 
		</c:if>
		<c:if test="${product.stockCnt != 0}">
			${product.stockCnt} 
		</c:if>
		
		
		
		<!--<c:if test="${tranStatusCode eq '구매완료' && user.userId eq 'admin' && menu eq 'manage'}">
		 <a href="javascript:fncCheckTransaction('${product.prodNo}');" id="prodNo">배송하기</a> 
		</c:if>-->
		</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
			<td></td>
			<td align="left" class="checkT">
			<!-- <a href="javascript:fncCheckTransaction('${product.prodNo}');">판매관리</a> -->
			판매관리
			</td>
		</c:if>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
</table>
 --%>
<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		 
		 <jsp:include page="../common/pageNavigator.jsp"/>	
		 
    	</td>
	</tr>
</table> -->
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
