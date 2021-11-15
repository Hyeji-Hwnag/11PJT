<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>	




<script type="text/javascript">


function fncAddPurchase() {
	$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
}

var kakaopay = function(){
		 
			
	var IMP = window.IMP; // 생략가능
    IMP.init('imp44681426'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    var msg;
    
    var price=0;
	 var prnm = $("input[name='prodName']").val(); 
	 var total = 0;
	 var prodParam = [];
	var stkcntParam = [];
	
	 $( "input[name='chklist']:checked" ).each(function(i){
			var chk = $(this).val();
			//alert($(this).parents('div').find("input[name='stockCount']").val())
			var amount = $(this).parents('div').find("input[name='"+chk+"']").val()
		
			var pr = $(this).parent().find("input[name='price']").val()
		
			prodParam.push($(this).val());
			stkcntParam.push(amount);
			price += pr * amount;
			
			total++;
		});
    
	 var paymentOption = $("select[name='paymentOption']").val();
		var receiverName =  $("input[name='receiverName']").val();
		var receiverPhone =  $("input[name='receiverPhone']").val();
		var divyAddr =  $("input[name='divyAddr']").val();
		var divyRequest =  $("input[name='divyRequest']").val();
		var divyDate =  $("input[name='divyDate']").val();
		
    
    
		var postData = { "prodParam" : prodParam, 
				"stkcntParam" :stkcntParam, 
				"paymentOption" : paymentOption, 
				"receiverName" : receiverName,
				"receiverPhone" : receiverPhone,
				"divyAddr" : divyAddr,
				"divyRequest" : divyRequest, 
				"divyDate" : divyDate,
				"totalPrice" : price }
    
    
    
    IMP.request_pay({
        pg : 'kakaopay',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : prnm+"외 "+total+"건",
        amount : price,
        buyer_email : 'flora@naver.com',
        buyer_name : receiverName,
        buyer_tel : receiverPhone,
        buyer_addr : divyAddr,
        buyer_postcode : '123-456',
        //m_redirect_url : 'http://www.naver.com'
    }, function(rsp) {
        if ( rsp.success ) {
            //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
            jQuery.ajax({
                url: "/purchase/json/addPurchase", //cross-domain error가 발생하지 않도록 주의해주세요
                type: 'POST',
                dataType: 'json',
                data: postData
            }).done(function(data) {
                //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                if ( everythings_fine ) {
                    msg = '결제가 완료되었습니다.';
                    msg += '\n고유ID : ' + rsp.imp_uid;
                    msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                    msg += '\결제 금액 : ' + rsp.paid_amount;
                    msg += '카드 승인번호 : ' + rsp.apply_num;
                    
                    alert(msg);
                } else {
                    //[3] 아직 제대로 결제가 되지 않았습니다.
                    //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                }
            });
            //성공시 이동할 페이지 
            location.href="http://127.0.0.1:8080/purchase/listPurchase";
        } else {
            msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            //실패시 이동할 페이지
            
            alert(msg);
        }
    });
		
	 }


$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "td.ct_btn01:contains('구매')" ).on("click" , function() { 
		 
			 var paymentOption = $("select[name='paymentOption']").val();
			 
			 if (paymentOption == '3'){
				 
				 kakaopay();
			 }else{
		
			var prodParam = [];
			var stkcntParam = [];
			var price = 0;
			$( "input[name='chklist']:checked" ).each(function(i){
				var chk = $(this).val();
				var amount = $(this).parents('div').find("input[name='"+chk+"']").val()
				//alert($(this).parents('div').find("input[name='stockCount']").val())
				prodParam.push($(this).val());
				stkcntParam.push(amount);
				
				
				var pr = $(this).parent().find("input[name='price']").val()
				price += pr * amount;
				
				
			});
			
			
			var receiverName =  $("input[name='receiverName']").val();
			var receiverPhone =  $("input[name='receiverPhone']").val();
			var divyAddr =  $("input[name='divyAddr']").val();
			var divyRequest =  $("input[name='divyRequest']").val();
			var divyDate =  $("input[name='divyDate']").val();
			
			
			var postData = { "prodParam" : prodParam, 
					"stkcntParam" :stkcntParam, 
					"paymentOption" : paymentOption, 
					"receiverName" : receiverName,
					"receiverPhone" : receiverPhone,
					"divyAddr" : divyAddr,
					"divyRequest" : divyRequest, 
					"divyDate" : divyDate,
					"totalPrice" : price }
			
				
		     $.ajax({
		        url:"/purchase/json/addPurchase",
		        type:"POST",
		        
		        dataType : "json",
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",

		        
		        data: postData,
		        success:function(data){
		        	//주문번호 넣고싶당. 
		        	//$('.modal-body').append("주문번호 : " +data.tranPurchase.tranNo)"+${item.tranProduct.prodName}+""+${item.stockCnt}+"
		        	//var div="<div class='container'><div class='page-header'>"+
		        	//"<h3 class='text-info'>구매내역</h3></div>";
		        	
		        	
		        	
		        	$.each(data, function(index, item) { // 데이터 =item
					//alert(item.buyer.userId);
		        		
		        		var div="";
		        		
		        		div += "<div class='row'>"+
		        	  		"<div class='col-xs-4 col-md-2'><strong>상품명</strong></div>"+
		        			"<div class='col-xs-8 col-md-4'>"+item.tranProduct.prodName+"</div>"+
		        		"</div>"+		        		
		        		"<hr/>"+		        		
		        		"<div class='row'>"+
		        	  		"<div class='col-xs-4 col-md-2 '><strong>상품수량</strong></div>"+
		        			"<div class='col-xs-8 col-md-4'>"+item.stockCnt+"</div>"+
		        		"</div>"+		        		
		        		"<hr/>"+		      
		        		"<br/></div>";
		        		
		         	
		        	$('.modal-body').append(div);
		        	
		        	
		        	
		        		//$('.modal-body').append("<br>구매한 상품 : "+item.tranProduct.prodNo + ", 구매한 상품명 : "+item.tranProduct.prodName)
		        		
		        	});
		        	//$('.modal-body').append("</div>");
		        	//	$('.modal-body').html(JSON.stringify(data));
		             // Display Modal
		            $('#empModal').modal('show'); 
		             
		            
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		            
		        }
		    }); 

			 }
	});

	$( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
			history.go(-1);
		});
	 $("input:button[name='minus']").on("click" , function() {
			var cnt = $(this).parent().find("#stockCount").val()
			
			if (cnt-1 < 1)
			{
				alert("1개부터 구매 가능합니다.")
			}else
			$(this).parent().find("#stockCount").val(cnt-1)
			
			
		});
	 $("input:button[name='plus']").on("click" , function() {
			
			var cnt = $(this).parent().find("#stockCount").val()
			
			var stockCnt = $(this).parent().find("input[name='stockCnt']").val()
			
			
			var num = cnt*1 + 1 
			
			if ( num > stockCnt*1)
			{
				alert("구매는 최대 " +stockCnt+ "개 까지 가능합니다.")
			}else
				$(this).parent().find("#stockCount").val(num)
			
			
		});
	 
	 
	
	 
	 
	 $("#empModal").on('hide.bs.modal', function(e){

			self.location="/purchase/listPurchase"

			e.stopImmediatePropagation();

		});
	 
	 $("#check_module").click(function () {
			
			
		    
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
	       <h3>상품구매</h3>
	    </div>



<c:forEach var="purchase" items="${list}">
<form name="addPurchase" class="form-horizontal">

<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}" />
<input type="hidden" name="prodName" value="${purchase.purchaseProd.prodName}" />

<div class="row">
<div class="col-md-3">
	<input type="hidden" name="stockCnt" 	value="${purchase.purchaseProd.stockCnt}" />	
	<input type="checkbox" name="chklist" checked="true" value="${purchase.purchaseProd.prodNo}" />&nbsp;&nbsp;
	<input type="hidden" name="price" value="${purchase.purchaseProd.price}" />
	 <img src="/images/uploadFiles/${purchase.purchaseProd.fileName}" width="200" height="200" /></div>
	<div class="col-md-9">

	<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${purchase.purchaseProd.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
				<input type="hidden" name="price" 	value="${purchase.purchaseProd.price}" />
		
		 ${purchase.purchaseProd.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			수량 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		
		<td class="ct_write01">
		<input type="button" name="minus" value="-"/>
		<input type="hidden" name="stockCnt" 	value="${purchase.purchaseProd.stockCnt}" />
		<input type="hidden" name="prodName" 	value="${purchase.purchaseProd.prodName}" />
		<input type="text" id="stockCount" name="${purchase.purchaseProd.prodNo}" 	class="ct_input_g" style="width: 80px; height: 19px" maxLength="20" value="1" />
		<input type="button" name="plus" value="+"/>
		&nbsp;(${purchase.purchaseProd.stockCnt}개)</td>
	</tr>
	
</table>
</div>
</div>
</c:forEach>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
		<input type="hidden" name="userId" value="${user.userId}" />
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption"		class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
				<option value="3">카카오페이</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyAddr" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" 	value="${user.addr}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input		type="text" name="divyRequest" 	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20"/>
			<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
						onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncAddPurchase();">구매</a> -->
						구매
					</td>
					
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					
					<td width="30"></td>
					
					<input type="button" id = "apibtn" value="카카오페이" />
					<button id="check_module" type="button">아이엠포트</button>

					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:history.go(-1)">취소</a> -->
						취소
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

<div class="modal fade" id="empModal" role="dialog">
    <div class="modal-dialog">
 
     <!-- Modal content-->
     <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">구매내역</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
      
      	
      
      
      
      
 
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
     </div>
    </div>
   </div>


</body>
</html>