
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
   
   
<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	

<script type="text/javascript">


function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/purchase/listTransaction").submit();
} 




$(function() {
	$("td.checkT:contains('����ϱ�')").on("click" , function() {
	
		
		 var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
						
		var tranNo = td.eq(0).text().trim();
		
		var prodNo = td.eq(10).find("input").val();
			
		self.location="/purchase/updateTranCodeByProd?tranNo="+tranNo+"&type=listTransaction&prodNo="+prodNo;
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
	       <h3>��۸����ȸ</h3>
	    </div>

<form name="detailForm" >


<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">�ֹ���ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">������ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�߼������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�߼��ϱ�</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>




	<c:forEach var="purchase" items="${list}">
		<c:set var="tranStatusCode" value="�Ǹ���"/>
		<c:set var="tranCode" value="${fn:trim(purchase.tranCode)}"/>
		<c:choose>
			<c:when test="${ ! empty tranCode && tranCode eq '1'}">
				<c:set var="tranStatusCode" value="���ſϷ�"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '2'}">
				<c:set var="tranStatusCode" value="�����"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '3'}">
				<c:set var="tranStatusCode" value="��ۿϷ�"/>
			</c:when>
		</c:choose>

	 <c:set var="i" value="${ i+1 }" />	 
	<tr class="ct_list_pop">
		<td align="center">
			${purchase.tranNo }</a>
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
		<td align="left">${purchase.divyDate}</td>
		<td></td>
		<td align="left" class="checkT">
		<!-- 
		<a href="/purchase/updateTranCodeByProd?tranNo=${purchase.tranNo}&type=listTransaction&prodNo=${purchase.purchaseProd.prodNo}">����ϱ�</a>
		 -->
		 <input type="hidden" value=${purchase.purchaseProd.prodNo }/>
			����ϱ�
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
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>