<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
<head>


<link rel="stylesheet" href="/css/admin.css" type="text/css">
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
<script type="text/javascript">





$(function() {
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	$(".btn-primary").on("click" , function() {
		var params = $("#detailForm").serialize();
		
		$.ajax(
		{
			url : "/purchase/json/addReview",
			method : "POST",
		 	dataType : "json",
		 	contentType: "application/x-www-form-urlencoded;", 
			data :{
			star : $("select[name='star']").val(),
			prodNo : $("input[name='prodNo']").val(),
			userId : $("input[name='userId']").val(),
			tranNo : $("input[name='tranNo']").val(),
			reviewText : $("textarea[name='reviewText']").val(),
	 		},
			success : function(data)
					{
						//alert(data.reviewText)
						alert(data.prodNo+" ��ǰ�� ���� �ۼ��� �Ϸ�Ǿ����ϴ�. ")
						opener.location.reload();
						window.close();
					}
				 	
		});
		
	});
});



</script>
<style>
  label {
    display: inline-block;
    width: 5em;
  }
  

        
  </style>
</head>


<body bgcolor="#ffffff" text="#000000">


<div class="container"></div>
<div class="page-header text-info">
	       <h3>������</h3>
</div>





<form id="detailForm">
	�ֹ���ȣ : ${param.tranNo }, ��ǰ�ڵ� : ${param.prodNo }, ���� : 
	<select 	name="star"		class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="0" selected="selected">�١١١١�</option>
				<option value="1" >�ڡ١١١�</option>
				<option value="2" >�ڡڡ١١�</option>
				<option value="3" >�ڡڡڡ١�</option>
				<option value="4" >�ڡڡڡڡ�</option>
				<option value="5" ">�ڡڡڡڡ�</option>
	</select>
    <textarea name="reviewText" class="form-control" rows="5"></textarea>

    <!-- ���� ����â -->
    <input type="hidden" name="prodNo" value="${param.prodNo }"/>
    <input type="hidden" name="userId" value="${userId }"/>
    <input type="hidden" name="tranNo" value="${param.tranNo}"/>
    <button class="btn btn-block btn-primary" type="submit">������</button>

</form>



</body>
</html>