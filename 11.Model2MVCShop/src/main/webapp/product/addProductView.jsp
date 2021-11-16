<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<html lang="ko">
<head>
<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
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
 
	
	
function fncAddProduct(){
	//Form 유효성 검증
 	//var name = document.detailForm.prodName.value;
	//var detail = document.detailForm.prodDetail.value;
	//var manuDate = document.detailForm.manuDate.value;
	//var price = document.detailForm.price.value;
	var name = $("input[name='prodName']").val();
	var detail = $("input[name='prodDetail']").val();
	var manuDate = $("input[name='manuDate']").val();
	var price = $("input[name='price']").val();
	var uploadFile = $("input[name='uploadFile']").val();
	var checkR = $("#checkR").val();
	
	if(checkR == 'false'){
		alert("사용 불가능한 상품명입니다.");
		return;
	}
	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}

	$("form").attr("method" , "POST").attr("action" , "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	
}

$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "button.btn.btn-primary" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
		fncAddProduct();
	});
	
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	

		//var checkAjaxSetTimeout;
		    $('#keyup').keyup(function(){
		    var inputLength = $(this).val().length;
		    //alert($(this).val())
		       
		        if ( inputLength > 1) {
		        	
		            var id = $(this).val();
		            
		            // ajax 실행
		            $.ajax({
		                type : 'POST',
		                contentType: "application/x-www-form-urlencoded;",  
		                url : '/product/json/checkProductDuplication/',
		               	data : {prodName : id},
		                success : function(result) {
		                	
		                    if (result) {
		                        $("#result_id_msg").html(id+": 사용 가능한 상품명 입니다.");
		                        $("#keyup").css({"border-color":"#347BD9"});
		                        $("#checkR").val(result);
		                    } else {
		                        $("#result_id_msg").html(id+": 사용 불가능한 상품명 입니다.");
		                        $("#keyup").css({"border-color":"red"});
		                        $("#checkR").val(result);
		                    }
		                }
		            }); // end ajax
		            } //end setTimeout
		       
		    }); // end keyup

});	

$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('취소')" ).html() );
			$("form")[0].reset();
	});
});	

/*
function fncCheckDuplication() {
	popWin 
		= window.open("/product/checkDuplicationProduct.jsp","popWin", "left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}*/


$(function() {
		
	 $("td.ct_btn:contains('상품명중복확인')").on("click" , function() {
		//alert($("td.ct_btn:contains('ID중복확인')").html());
		popWin 
		= window.open("/product/checkDuplicationProduct.jsp",
									"popWin", 
									"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	});
});	

/* function resetData(){
	document.detailForm.reset();
} */
$( function() {
    $( document ).tooltip();
  } );
  
  
</script>
<style>
  label {
    display: inline-block;
    width: 100%;
  }
  
   body {
            padding-top : 50px;
        }
        
    body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }     
  </style>
</head>

<body bgcolor="#ffffff" text="#000000">


<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
<div class="container">
	<h1 class="bg-primary text-center">상 품 등 록</h1>


<!--<form name="detailForm">
 
<form name="detailForm" method="post" enctype="multipart/form-data" >
 -->
	<form name="detailForm" class="form-horizontal">

		<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		    <input 	type="text" id="keyup" name="prodName" class="form-control">
		       <span id="result_id_msg" class="help-block">
		      	
		      </span>
		    </div>
		  </div>

		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <label for="detail">
		    	<input type="text" name="prodDetail" class="form-control" title="그냥..툴팁을 써보았다."/>
		    </label>
		
		    </div>
		  </div>
			
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		    	<input type="text" name="manuDate" readonly="readonly" class="form-control"  
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
				&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
										onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		    </div>
		  </div>

		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" >
		    </div>
		  </div>

	<div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input		type="file" name="uploadFile" class="form-control" />
		    </div>
		  </div>
	<input type="hidden" id="checkR"/>



		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		  
	

</form>
</div>
</body>
</html>