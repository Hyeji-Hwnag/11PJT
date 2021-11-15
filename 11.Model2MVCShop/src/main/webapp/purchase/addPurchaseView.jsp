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
   
   
<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>	




<script type="text/javascript">


function fncAddPurchase() {
	$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
}

var kakaopay = function(){
		 
			
	var IMP = window.IMP; // ��������
    IMP.init('imp44681426'); // 'iamport' ��� �ο����� "������ �ĺ��ڵ�"�� ���
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
        name : prnm+"�� "+total+"��",
        amount : price,
        buyer_email : 'flora@naver.com',
        buyer_name : receiverName,
        buyer_tel : receiverPhone,
        buyer_addr : divyAddr,
        buyer_postcode : '123-456',
        //m_redirect_url : 'http://www.naver.com'
    }, function(rsp) {
        if ( rsp.success ) {
            //[1] �����ܿ��� �������� ��ȸ�� ���� jQuery ajax�� imp_uid �����ϱ�
            jQuery.ajax({
                url: "/purchase/json/addPurchase", //cross-domain error�� �߻����� �ʵ��� �������ּ���
                type: 'POST',
                dataType: 'json',
                data: postData
            }).done(function(data) {
                //[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
                if ( everythings_fine ) {
                    msg = '������ �Ϸ�Ǿ����ϴ�.';
                    msg += '\n����ID : ' + rsp.imp_uid;
                    msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
                    msg += '\���� �ݾ� : ' + rsp.paid_amount;
                    msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;
                    
                    alert(msg);
                } else {
                    //[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
                    //[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
                }
            });
            //������ �̵��� ������ 
            location.href="http://127.0.0.1:8080/purchase/listPurchase";
        } else {
            msg = '������ �����Ͽ����ϴ�.';
            msg += '�������� : ' + rsp.error_msg;
            //���н� �̵��� ������
            
            alert(msg);
        }
    });
		
	 }


$(function() {
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	 $( "td.ct_btn01:contains('����')" ).on("click" , function() { 
		 
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
		        	//�ֹ���ȣ �ְ�ʹ�. 
		        	//$('.modal-body').append("�ֹ���ȣ : " +data.tranPurchase.tranNo)"+${item.tranProduct.prodName}+""+${item.stockCnt}+"
		        	//var div="<div class='container'><div class='page-header'>"+
		        	//"<h3 class='text-info'>���ų���</h3></div>";
		        	
		        	
		        	
		        	$.each(data, function(index, item) { // ������ =item
					//alert(item.buyer.userId);
		        		
		        		var div="";
		        		
		        		div += "<div class='row'>"+
		        	  		"<div class='col-xs-4 col-md-2'><strong>��ǰ��</strong></div>"+
		        			"<div class='col-xs-8 col-md-4'>"+item.tranProduct.prodName+"</div>"+
		        		"</div>"+		        		
		        		"<hr/>"+		        		
		        		"<div class='row'>"+
		        	  		"<div class='col-xs-4 col-md-2 '><strong>��ǰ����</strong></div>"+
		        			"<div class='col-xs-8 col-md-4'>"+item.stockCnt+"</div>"+
		        		"</div>"+		        		
		        		"<hr/>"+		      
		        		"<br/></div>";
		        		
		         	
		        	$('.modal-body').append(div);
		        	
		        	
		        	
		        		//$('.modal-body').append("<br>������ ��ǰ : "+item.tranProduct.prodNo + ", ������ ��ǰ�� : "+item.tranProduct.prodName)
		        		
		        	});
		        	//$('.modal-body').append("</div>");
		        	//	$('.modal-body').html(JSON.stringify(data));
		             // Display Modal
		            $('#empModal').modal('show'); 
		             
		            
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("���� �߻�~~ \n" + textStatus + " : " + errorThrown);
		            
		        }
		    }); 

			 }
	});

	$( "td.ct_btn01:contains('���')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('����')" ).html() );
			history.go(-1);
		});
	 $("input:button[name='minus']").on("click" , function() {
			var cnt = $(this).parent().find("#stockCount").val()
			
			if (cnt-1 < 1)
			{
				alert("1������ ���� �����մϴ�.")
			}else
			$(this).parent().find("#stockCount").val(cnt-1)
			
			
		});
	 $("input:button[name='plus']").on("click" , function() {
			
			var cnt = $(this).parent().find("#stockCount").val()
			
			var stockCnt = $(this).parent().find("input[name='stockCnt']").val()
			
			
			var num = cnt*1 + 1 
			
			if ( num > stockCnt*1)
			{
				alert("���Ŵ� �ִ� " +stockCnt+ "�� ���� �����մϴ�.")
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
	       <h3>��ǰ����</h3>
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
			��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
				<input type="hidden" name="price" 	value="${purchase.purchaseProd.price}" />
		
		 ${purchase.purchaseProd.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.purchaseProd.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		
		<td class="ct_write01">
		<input type="button" name="minus" value="-"/>
		<input type="hidden" name="stockCnt" 	value="${purchase.purchaseProd.stockCnt}" />
		<input type="hidden" name="prodName" 	value="${purchase.purchaseProd.prodName}" />
		<input type="text" id="stockCount" name="${purchase.purchaseProd.prodNo}" 	class="ct_input_g" style="width: 80px; height: 19px" maxLength="20" value="1" />
		<input type="button" name="plus" value="+"/>
		&nbsp;(${purchase.purchaseProd.stockCnt}��)</td>
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
			�����ھ��̵� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
		<input type="hidden" name="userId" value="${user.userId}" />
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption"		class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
				<option value="3">īī������</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
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
		<td width="104" class="ct_write">�����ڿ���ó</td>
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
		<td width="104" class="ct_write">�������ּ�</td>
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
		<td width="104" class="ct_write">���ſ�û����</td>
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
		<td width="104" class="ct_write">����������</td>
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
						<!-- <a href="javascript:fncAddPurchase();">����</a> -->
						����
					</td>
					
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					
					<td width="30"></td>
					
					<input type="button" id = "apibtn" value="īī������" />
					<button id="check_module" type="button">���̿���Ʈ</button>

					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:history.go(-1)">���</a> -->
						���
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
        <h4 class="modal-title">���ų���</h4>
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