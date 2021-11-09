<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


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

function fncAddPurchase() {
	$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
}




$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "td.ct_btn01:contains('구매')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
		fncAddPurchase();
	});
	 $( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
			history.go(-1);
		});
	 $("input:button[name='minus']").on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
			var cnt = $("input:text[name='stockCount']").val()
			if (cnt-1 < 1)
			{
				alert("1개부터 구매 가능합니다.")
			}else
			$("input:text[name='stockCount']").val(cnt-1)
			
		});
	 $("input:button[name='plus']").on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
			var cnt = $("input:text[name='stockCount']").val()
			var stockCnt = $("input:hidden[name='stockCnt']").val()
			
			var num = cnt*1 + 1 
			
			if ( num > stockCnt*1)
			{
				alert("구매는 최대 " +stockCnt+ "개 까지 가능합니다.")
			}else
			$("input:text[name='stockCount']").val(num)
			
		});
	 
	 
	 $("#apibtn").click(function(){
		 
		 var pr =  $("input[name='price']").val()
		 var amount = $("input[name='stockCount']").val()
		 var price = pr * amount;
		 
		 
		 $.ajax({
			url:"/purchase/json/kakaopay",
			data : { price : price, prodName : $("input[name='prodName']").val()
				 },
			dataType : "json",
			success: function(data){
				
				var box = data.next_redirect_pc_url;
				
				//window.open(box, "kakao", "width=480px, height=700px");
				
				window.open(box);
				fncAddPurchase();
			},
			error:function(error){
				alert(error);
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
	       <h3>상품구매</h3>
	    </div>

<form name="addPurchase" class="form-horizontal">



<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}" />
<input type="hidden" name="prodName" value="${purchase.purchaseProd.prodName}" />

<div class="row">
 <div class="col-md-3"><img src="/images/uploadFiles/${purchase.purchaseProd.fileName}" width="300" height="300" /></div>
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
		<input type="text" name="stockCount" 	class="ct_input_g" style="width: 80px; height: 19px" maxLength="20" value="1" />
		<input type="button" name="plus" value="+"/>
		&nbsp;(${purchase.purchaseProd.stockCnt}개)</td>
	</tr>
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
</table>
</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
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
</div>
</body>
</html>