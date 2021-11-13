
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
	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
} 

$(function() {
	$("td.checkT:contains('물건도착')").on("click" , function() {
	
		
		var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
						
		var tranNo = td.eq(0).text().trim();
		
		
		//console.log("tranNo: " +tranNo)
		self.location="/purchase/updateTranCode?tranNo="+tranNo;
		//self.location="/purchase/updateTranCode;
	});
	
	$( "td:nth-child(1)" ).css("color" , "blue");
	$( "td:nth-child(1)" ).on("click" , function() {
		self.location ="/purchase/getPurchase?tranNo="+$(this).text().trim();
});	
	
	$( "td:nth-child(2)" ).css("color" , "red");
	$( "td:nth-child(2)" ).on("click" , function() {
		var prodNo = $(this).find("input").val();
		self.location ="/product/getProduct?menu=search&prodNo="+prodNo;
});	
	
$("td.checkT:contains('리뷰작성') ").on("click" , function() {
	
	
	// 1. 모달창에서 뿌려줄 것 
	
	
	
	
	
	$.ajax( 
			{
				url : "/purchase/json/addReviewView/"+tranNo,
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status) {
					var displayValue="";
					$.each(JSONData, function(index, item) {
					
					displayValue += "<h6>"
									+"상품명 : "+item.tranProduct.prodName+"<br/>"
									+"가격 : "+item.tranProduct.price+"<br/>"
									+"수량 : "+item.stockCnt+"<br/>"
									+"</h6>";
					});
					$("h6").remove();
					$( "#"+tranNo+"" ).html(displayValue);
				}
		});
	
	/* 
	
		var td = $(this).parent().children();
		var prodNo = td.eq(1).find("input").val();
		var tranNo = td.eq(0).text().trim();
		
		popWin 
		//= window.open("/product/productReview.jsp?prodNo="+prodNo+"&tranNo="+tranNo,
		= window.open("/purchase/addReviewView?prodNo="+prodNo+"&tranNo="+tranNo,
									"popWin", 
									"left=300,top=200,width=800,height=300,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	 
 */
		
	});
		
	$(  "td:nth-child(6) > i" ).on("click" , function() {
		var tranNo = $(this).next().val();
		$.ajax( 
				{
					url : "/purchase/json/getTranDetail/"+tranNo ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						var displayValue="";
						$.each(JSONData, function(index, item) {
						
						displayValue += "<h6>"
										+"상품명 : "+item.tranProduct.prodName+"<br/>"
										+"가격 : "+item.tranProduct.price+"<br/>"
										+"수량 : "+item.stockCnt+"<br/>"
										+"</h6>";
						});
						$("h6").remove();
						$( "#"+tranNo+"" ).html(displayValue);
					}
			});
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
	       <h3>구매목록조회</h3>
	    </div>
<form name="detailForm">


<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">주문번호</th>
            <th align="left">금액</th>
            <th align="left">구매일</th>
            <th align="left">배송현황</th>
            <th align="left">정보수정</th>
            <th align="left">상세정보</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  	<c:forEach var="purchase" items="${list}">
		<c:set var="tranStatusCode" value="판매중"/>
		<c:set var="tranCode" value="${fn:trim(purchase.tranCode)}"/>
		<c:choose>
			<c:when test="${ ! empty tranCode && tranCode eq '1'}">
				<c:set var="tranStatusCode" value="구매완료"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '2'}">
				<c:set var="tranStatusCode" value="배송중"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '3'}">
				<c:set var="tranStatusCode" value="배송완료"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '4'}">
				<c:set var="tranStatusCode" value="리뷰작성완료"/>
			</c:when>
		</c:choose>
	
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" title="Click : 주문번호 확인">${purchase.tranNo}</td>
			  <td align="left">
			  <input type="hidden" class="chkprodNo" value="${purchase.purchaseProd.prodNo}"/>
			 ${purchase.totalPrice}</td>
			  <td align="left">${purchase.orderDate}</td>
			  <td align="left">현재 ${tranStatusCode } 상태입니다.</td>
			  <td align="left" class="checkT">
			  	<input type="hidden" id="tranCode" value="${purchase.tranCode }"/>
		<c:if test="${tranStatusCode eq '배송중' && user.userId ne 'admin'}">
		<!-- 
		<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=${purchase.tranCode}">물건도착</a>
		 -->물건도착
		</c:if>
		<c:if test="${tranStatusCode eq '배송완료' && user.userId ne 'admin'}">
		<!-- 
		<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=${purchase.tranCode}">물건도착</a>
		 -->리뷰작성
		</c:if>
			  </td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>