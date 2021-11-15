<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html  lang="ko">
<head>
<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />





<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- �Ʒ� 2��  -->
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
   
   
<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
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
	


	 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
		 fncGetUserList('1');
	});
	 
	 $( "input[value='���ݳ�����']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.price')
		 fncGetOrderList('1', 'p.price');
	});
	 
	 $( "input[value='���ݳ�����']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.price desc')
	 
		 fncGetOrderList('1', 'p.price desc');
	});
	 
	 $( "input[value='��ǰ������']" ).on("click" , function() {
		 $("input[name='orderColurm']").val('p.prod_name asc')
	 
		 fncGetOrderList('1', 'p.prod_name asc');
	});
	 
	 $( "input[value='��ǰ�������']" ).on("click" , function() {
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
	
	

	
	/* $("a:contains('������')").on("click" , function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=search&prodNo="+prodNo;
	});  */
	
	$("body").on("click", ".detail_btn1", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=search&prodNo="+prodNo;
	}); 
	
	
	//$("a:contains('��ǰ����')").on("click" , function() {
	$("body").on("click", ".detail_btn2", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		self.location ="/product/getProduct?menu=manage&prodNo="+prodNo;
	}); 
	
	
	//$("a:contains('�ǸŰ���')").on("click" , function() {
	$("body").on("click", ".detail_btn3", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		popWin 
		= window.open("/purchase/checkProductTranCode?prodNo="+prodNo,
									"popWin", 
									"left=300,top=200,width=700,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	}); 
	
	
	//$("a:contains('��ٱ���')").on("click" , function() {
	$("body").on("click", ".detail_btn4", function() {
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		var userId = $(this).parent().find("input[name='userId']").val();
		
		self.location = "/product/addCart?prodNo="+prodNo+"&userId="+userId;
	}); 
	
	
	//$("a:contains('����')").on("click" , function() {
	$("body").on("click", ".detail_btn5", function() {	
		var prodNo = $(this).parent().find("input[name='prodNo']").val();
		var stockCnt=$(this).parent().find("input[name='stockCnt']").val();
		
		if (stockCnt<=0){
			alert("������ �����Ͽ� ���Ÿ� �� �� �����ϴ�. ");
			return;
		}else{
			self.location ="/purchase/addPurchaseView?prodNo="+prodNo;
			

		}
		
	}); 
	
	
	
	
	
	
	
	
	
	
	
	$("td.checkT:contains('�ǸŰ���')").on("click" , function() {
		
			var checkBtn = $(this);
			var tr = checkBtn.parent();
			var td = tr.children();
						
			var prodNo = td.eq(2).find("input").val();
			
		//alert($("td.ct_btn:contains('ID�ߺ�Ȯ��')").html());
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
	

					alert("������ �߻��Ͽ����ϴ�.")

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
	 			        "<p>���� : "+list[i].price+"��</p>";
	 			if (list[i].stockCnt==0){
	 				div += "<p>������ </p>";
	 			}else if (list[i].stockCnt!=0){
	 				div += "<p>����: "+list[i].stockCnt+"��</p> ";
	 			}
	 			div += "<p>"+
	 			"<input type='hidden' id='prodNo' name='prodNo' value='"+list[i].prodNo+"'/>"+
	 			"<input type='hidden' id='userId' name='userId' value='"+userId+"'/>"+
	 			"<input type='hidden' id='stockCnt' name='stockCnt' value='"+list[i].stockCnt+"'/>"+
	 			"<a href='#' class='btn btn-default detail_btn1' role='button'>������</a>";
	 			
	 			
	 			if (userId !== ""){
	 			
	 			if( userId == 'admin' && menu == 'manage'){
	 				div += "<a href='#' class='btn btn-default detail_btn2' role='button'>��ǰ����</a>"+
	 				"<a href='#' class='btn btn-default detail_btn3' role='button'>�ǸŰ���</a>";
	 			}
	 			
	 			if(  userId != 'admin' && menu == 'search'){
	 				div += "<a href='#' class='btn btn-default detail_btn4' role='button'>��ٱ���</a>"+
	 				"<a href='#' class='btn btn-default detail_btn5' role='button'>����</a>";
	 			}
	 			
	 			}
	 			
	 			div +=  "</p> </div> </div> </div>";
	 			$('.row').append(div);
	 		  
	 			
	 		}
	 		
	 		
	 		

	 	},

	 	error : function() {

	 		alert("1������ �߻��Ͽ����ϴ�.")

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
						��ǰ ����
					</c:if>
					<c:if test="${menu eq 'search'}">
						��ǰ �˻�
					</c:if></h3>
	    </div>



<!-- <form name="detailForm" action="/product/listProduct?menu=${menu}" method="post"> -->
<form name="detailForm">



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<!-- <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option> -->
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			
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
						<!-- <a href="javascript:fncGetUserList('1');">�˻�</a> -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<p>��ü  ${resultPage.totalCount } �Ǽ�<!-- , ���� ${resultPage.currentPage}  ������--></p>
<input name="menu" type="hidden" value="${menu}"/>
		<input type="hidden" id="orderColurm" name="orderColurm" value="${search.orderColurm}"/>
		<input type="hidden" id="orderKey" name="orderKey" value=""/>
		<input type="hidden" id="tranStatusCode" name="tranStatusCode" value=""/>
		
			 

		<!-- <a href="javascript:fncGetOrderList('1', 'p.price');">�㰡�ݳ�����</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.price desc');">�尡�ݳ�����</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name asc');">���ǰ��</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name desc');">���ǰ��</a>&nbsp;&nbsp;&nbsp;
		 -->
		<input type="button" value="���ݳ�����"/>
		<input type="button" value="���ݳ�����"/>
		<input type="button" value="��ǰ������"/>
		<input type="button" value="��ǰ�������"/>
<div class="row">

<c:forEach var="product" items="${list}">

  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
    <img src="/images/uploadFiles/${product.fileName}" width="200" height="200" alt="..." />
      
      <div class="caption">
        <h3>${product.prodName}</h3>
        <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
        <p>���� : ${product.price }��</p>
        <c:if test="${product.stockCnt == 0}">
		<p>������ </p>
		</c:if>
		<c:if test="${product.stockCnt != 0}">
		<p>����: ${product.stockCnt}��</p> 
		</c:if>
		<p>
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		<input type="hidden" id="userId" name="userId" value="${user.userId}"/>
		<input type="hidden" id="stockCnt" name="stockCnt" value="${product.stockCnt}"/>
		
			<a href="#" class="btn btn-default detail_btn1" role="button">������</a>
		
		
		
		
		<c:if test="${!empty user && user.userId eq 'admin' && menu eq 'manage'}">
        <a href="#" class="btn btn-default detail_btn2" role="button">��ǰ����</a> 
        <a href="#" class="btn btn-default detail_btn3" role="button">�ǸŰ���</a>
        </c:if>
        
        <c:if test="${!empty user && user.role eq 'user' && menu eq 'search'}">
        <a href="#" class="btn btn-default detail_btn4" role="button">��ٱ���</a> 
        <a href="#" class="btn btn-default detail_btn5" role="button">����</a> 
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
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">���� </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">����</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
		<td class="ct_line02"></td>
		<td class="ct_list_b">�ǸŰ���</td>	
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
			proTranCode�� ���� / ���ſ��� ������
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
			������ 
		</c:if>
		<c:if test="${product.stockCnt != 0}">
			${product.stockCnt} 
		</c:if>
		
		
		
		<!--<c:if test="${tranStatusCode eq '���ſϷ�' && user.userId eq 'admin' && menu eq 'manage'}">
		 <a href="javascript:fncCheckTransaction('${product.prodNo}');" id="prodNo">����ϱ�</a> 
		</c:if>-->
		</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
			<td></td>
			<td align="left" class="checkT">
			<!-- <a href="javascript:fncCheckTransaction('${product.prodNo}');">�ǸŰ���</a> -->
			�ǸŰ���
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
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
