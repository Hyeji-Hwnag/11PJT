
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
	
	
$("td.checkT:contains('리뷰작성') ").on("click" , function() {
	
	
	// 1. 모달창에서 뿌려줄 것 
	// ===> 모달창에서 보여주면 좀 이상해짐 ㅜ.ㅜ..? 
			// 걍 팝업창으로 변경하꺄 , ,, ,,,,,,,,,,        ,        ,, ,, , 
		var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
						
		var tranNo = td.eq(0).text().trim();
		var userId =  $("input[name='userId']").val();
		
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
						
						var div="";
						$.each(JSONData, function(index, item) {
						
							
							div += "<form id='detailForm"+index+"' class='productReview'>"+
							"주문번호 :"+tranNo+" 상품코드 :"+item.tranProduct.prodNo+" 평점 : "+
							"<select 	name='star'		class='ct_input_g' style='width: 100px; height: 19px' maxLength='20'>"+
										"<option value='0' selected='selected'>☆☆☆☆☆</option>"+
										"<option value='1' >★☆☆☆☆</option>"+
										"<option value='2' >★★☆☆☆</option>"+
										"<option value='3' >★★★☆☆</option>"+
										"<option value='4' >★★★★☆</option>"+
										"<option value='5' >★★★★★</option>"+
							"</select>"+
						   "<textarea name='reviewText' class='form-control' rows='2'></textarea>"+
						   " <input type='hidden' name='prodNo' value='"+item.tranProduct.prodNo+"'/>"+
						    "<input type='hidden' name='userId' value='"+userId+"'/>"+
						    "<input type='hidden' name='tranNo' value='"+tranNo+"'/>"+
						   
						"</form>";
						      
						
						
						//alert(item.tranProduct.prodNo)
						});
						$('.modal-body').html(div);
						$('#empModal').modal('show'); 
					}
					
			});
	
	
	//$('#empModal').modal('show'); 
	

		
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
	
	$(".btn-default").on("click" , function() {
		$(".productReview").each(function(index, item){ 
			
			//var params = $("#detailForm"+index).find("input[name='prodNo']").val();
			
			$.ajax(
					{
						url : "/purchase/json/addReview",
						method : "POST",
					 	dataType : "json",
					 	contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
						data :{
						 star : $("#detailForm"+index).find("select[name='star']").val(),
						prodNo : $("#detailForm"+index).find("input[name='prodNo']").val(),
						userId : $("#detailForm"+index).find("input[name='userId']").val(),
						tranNo : $("#detailForm"+index).find("input[name='tranNo']").val(),
						reviewText : $("#detailForm"+index).find("textarea[name='reviewText']").val()
				 		},
						success : function(data)
								{
									//alert(data.reviewText)
									//alert(" 상품의 리뷰 작성이 완료되었습니다. ")
									
									$('#empModal').modal('hide'); 
									window.location.reload();
								}
							 	
					});//end ajax
		});//end each

		
		
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
			  	<i class="glyphicon glyphicon-music" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  	<input type="hidden" name="userId" value="${user.userId}">
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

<div class="modal fade" id="empModal" role="dialog">
    <div class="modal-dialog">
 
     <!-- Modal content-->
     <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">한줄평</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
      
      	
      
      
      
 
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-default" >이거 누르면 저장 </button>
      </div>
     </div>
    </div>
   </div>

</body>
</html>