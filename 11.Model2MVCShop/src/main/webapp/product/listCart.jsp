
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html lang="ko">
<head>
<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script type="text/javascript" src="../javascript/calendar.js">
</script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>





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
	




<script type="text/javascript">

function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
   	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/listCart").submit();
} 
/* 
function fncGetUserList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}
 */


 function fncCheckStockCnt(stockCnt, prodNo) {
 	// Form 유효성 검증
 	//var name=document.detailForm.userName.value;
 	
 	if (stockCnt<=0){
 		alert("수량이 부족하여 구매를 할 수 없습니다. ");
 		return;
 	}else{
 		
 		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView?prodNo="+prodNo).submit();

 	}
 	
 }
 
 
 $(function() {
	 
	
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		//==> userId LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert( "1" );
				self.location ="/product/getProduct?menu=search&prodNo="+$(this).text().trim();
		});
		
		/* $( ".ct_list_pop td:nth-child(9)" ).on("click" , function() {
			//Debug..
			var tr = $(this);
			var td = tr.children();
			console.log("dd"+td.text());
			
			var prodNo = td.eq(3).text();
			
			alert(prodNo+":::");
			fncCheckStockCnt('${product.stockCnt }', '${product.prodNo}' );
			
	}); */
		 $(".checkBtn:contains('구매')").click(function(){
				var str = "";
				//var tdArr = new Array();
				var checkBtn = $(this);
				
				var tr = checkBtn.parent();
				var td = tr.children();
				
				var prodNo = td.eq(2).text().trim();
				var stockCnt = td.eq(6).text().trim();
				
				//console.log("prodNo : "+prodNo+", stockCnt: "+stockCnt);
				fncCheckStockCnt(stockCnt, prodNo);
		});
		 $(".checkBtn:contains('삭제')").click(function(){
				
				
				//var tdArr = new Array();
				var checkBtn = $(this);
				
				var tr = checkBtn.parent();
				var td = tr.children();
				
				//var cartId=td.eq(13).text().trim();
				var cartId=td.eq(12).find("input").val();
				
				self.location="/product/deleteCart?cartId="+cartId;
		});
		 
		 $( "input[name='allPurchase']" ).on("click" , function() {
				
			 
			var prodParam = [];
			var stkcntParam = [];
			$( "input[name='chklist']:checked" ).each(function(i){
				prodParam.push($(this).val());
				
			});
			
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView?prodNo="+prodParam).submit();
			
			
			//var postData = {"checkArray" : prodParam};
			
			
		   /*  $.ajax({
		        url:"/purchase/json/addPurchaseView",
		        type:"GET",
		        dataType : "json",
		        data: postData,
		        success:function(data){
		        	//JSON.stringify(data)
		        	
		        	//var list = data.list;
		        	//alert(list)
		            
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		            
		        }
		    }); */
 
			 
			 
		});
});	
 

 




</script>
<style>

  
   body {
            padding-top : 50px;
        }
        
        
  </style>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	
	<div class="container">
<div class="page-header text-info">
	       <h3>장바구니</h3>
	    </div>


<form name="detailForm">


<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<!-- <tr>
		<td colspan="11">전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지</td>
	</tr> -->
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">구매</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">삭제</td>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>




	<c:forEach var="product" items="${list}">
		
	<c:set var="i" value="${ i+1 }" />	 
	<tr class="ct_list_pop">
		<td align="center">
		<c:if test="${product.stockCnt gt 0}">
			<input type="checkbox" name="chklist" value="${product.prodNo}" />
		</c:if>
		<c:if test="${product.stockCnt eq 0}">
			<input type="checkbox" name="chklist" value="${product.prodNo}" disabled/>
			</c:if>
		</td>
		<td></td>
		<td align="left">
		<!-- 
			<a href="/user/getUser?userId=${user.userId}">${product.prodNo}</a> -->
			${product.prodNo}
		</td>
		<td></td>
		<td align="left">${product.prodName}</td>
		<td></td>
		<td align="left">${product.stockCnt}</td>
		<td></td>
		<td align="left" class="checkBtn">
		<!-- 
		<input type="button" class="checkBtn" value="구매" />
		<a href="javascript:fncCheckStockCnt('${product.stockCnt }', '${product.prodNo} }')">구매버튼</a></td> -->
		구매</td>
		
		<td></td>
		<td align="left" class="checkBtn">
		<!-- <a href="/product/deleteCart?cartId=${product.cartId}">삭제버튼</a>-->
		삭제</td>
		<td></td>
		<td><input type="hidden" value="${product.cartId}"/></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>
<input type="button" value="구매" name="allPurchase"/>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>