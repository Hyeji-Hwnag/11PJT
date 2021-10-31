<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>


<title>list product </title>




<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

$(function() {
	 $(".prodpurchase").click(function(){
			
			
			//var tdArr = new Array();
			var checkBtn = $(this);
			
			var tr = checkBtn.parent();
			var td = tr.children();
			
			//var cartId=td.eq(13).text().trim();
			var tranNo=td.eq(0).find("input").val();
			//console.log("cartId: "+cartId);
			self.location="/purchase/getPurchase?tranNo="+tranNo;
	});
	 
	 $( "td.ct_btn01:contains('확인')" ).on("click" , function() {
			 window.close();
		    opener.location.reload();
	});
	 
	 $(".rn").click(function(){
			
			
			//var tdArr = new Array();
			var checkBtn = $(this);
			
			var tr = checkBtn.parent();
			var td = tr.children();
			
			//var cartId=td.eq(13).text().trim();
			var tranNo=td.eq(0).find("input").val();
			var prodNo=td.eq(10).find("input").val();
			
			self.location="/purchase/updateTranCodeByProd?tranNo="+tranNo+"&type=checkProductTranCode&prodNo="+prodNo;
	});
	 
});


/* 
function pclose1(){
	 window.close();
	    opener.location.reload();
   
} */


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >
<!-- action="/purchase/listProdPurchase" method="post" -->

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">판매 이력	</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">구매자ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">구매일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">발송</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>




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
		</c:choose>

	 <c:set var="i" value="${ i+1 }" />	 
	<tr class="ct_list_pop">
		<td align="center" class="prodpurchase">
		<input type="hidden" value="${purchase.tranNo}"/>
		${ i }
			<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${ i }</a> -->
		</td>
		<td></td>
		<td align="left">
			${purchase.purchaseProd.prodName}</a>
		</td>
		<td></td>
		<td align="left">${purchase.buyer.userId}</td>
		<td></td>
		<td align="left">${purchase.orderDate}</td>
		<td></td>
		<td align="left">${tranStatusCode}</td>
		<td></td>
		<td align="left" class="rn">
		<input type="hidden" value="${purchase.purchaseProd.prodNo}"/>
		<c:if test="${tranStatusCode eq '구매완료' }">
		<!-- 
		<a href="/purchase/updateTranCodeByProd?tranNo=${purchase.tranNo}&type=checkProductTranCode&prodNo=${purchase.purchaseProd.prodNo}">배송하기</a> -->
		배송하기
		</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:pclose1()">확인</a> -->
						확인
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>





</form>

</div>
</body>
</html>
