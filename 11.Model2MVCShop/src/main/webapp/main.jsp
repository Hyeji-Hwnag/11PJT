<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- google -->    
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqWPYtQyM3eS3xjLTGzTGSbiXqfTaIbEM&x	v=3.exp"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">	 	
//var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=seoul&appid=be78cfd9bc9ce8e44adfd5004caf3134";

/* $.ajax({
    url: apiURI,
    dataType: "json",
    type: "GET",
    async: "false",
    success: function(resp) {
        console.log(resp);
        console.log("����µ� : "+ (resp.main.temp- 273.15) );
        console.log("������� : "+ resp.main.humidity);
        console.log("���� : "+ resp.weather[0].main );
        console.log("�󼼳������� : "+ resp.weather[0].description );
        console.log("���� �̹��� : "+ resp.weather[0].icon );
        console.log("�ٶ�   : "+ resp.wind.speed );
        console.log("����   : "+ resp.sys.country );
        console.log("�����̸�  : "+ resp.name );
        console.log("����  : "+ (resp.clouds.all) +"%" );  
        
        var div = "";
        div += "<p>���� �̸�: "+resp.name+"</p>"
        div += "<p>���� �µ�: "+(resp.main.temp- 273.15)+"</p>"
        div += "<p>���� ����: "+resp.weather[0].main+"/ "+resp.weather[0].description+"</p>"
        div += "<p>���� �ٶ�: "+resp.wind.speed+"</p>"
      	$('.jumbotron').append(div)
    }
}); */
window.onload = function() {
	
	findLocation();   		
};

function findLocation(){

	// Geolocation API, ���� �浵 ã�� 
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showYourLocation, showErrorMsg);
	}
	else {
		
	}


	// ��ġ Ȯ�� ���� �Լ� ����
	function showYourLocation(position) {
		var userLat = position.coords.latitude;
		var userLng = position.coords.longitude;    			
		
		// openWeather ���� 	
		getDataByLocating(userLat, userLng);
		
		

		//���� �� �ε��� ����� ��ġ ��Ŀ ǥ�� �ǽ�
		var userLocation = new google.maps.LatLng(userLat, userLng);
		var loc = document.getElementById("map-canvas"); //���� ���� ǥ������ ��ü ����

		var mapOptions = { //���� �� �ɼǰ� ����
			center: userLocation, 
			zoom: 15, 
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			mapTypeControl: false, 
			navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL}
		}

		var map = new google.maps.Map(loc, mapOptions);
		var marker = new google.maps.Marker({position:userLocation,map:map,title:"���� ��ġ"});    			
	}


	// ���� Ȯ�� ���� �Լ� ����
	function showErrorMsg(error) {
		console.log("");
		console.log("showErrorMsg : error : " + error.code);
		 switch(error.code) {
		 	case error.PERMISSION_DENIED:
		 		console.log("showErrorMsg : error : " + "Geolocation API�� ��� ��û�� �ź��߽��ϴ�");
		 		break;

		 	case error.POSITION_UNAVAILABLE:
		 		console.log("showErrorMsg : error : " + "��ġ ������ ����� �� �����ϴ�");
		 		break;

		 	case error.TIMEOUT:
		 		console.log("showErrorMsg : error : " + "���� ��û�� ��� �ð��� �ʰ��߽��ϴ�");
		 		break;

		 	case error.UNKNOWN_ERROR:
		 		console.log("showErrorMsg : error : " + "�� �� ���� ������ �߻��߽��ϴ�");
		 		break;
		 }    			    			    			
		console.log("");
	}
	
	
	
	

};
function getDataByLocating(la, lon){
	  var URL = "https://api.openweathermap.org/data/2.5/weather?lat="+la+"&lon="+lon+"&units=metric&appid=be78cfd9bc9ce8e44adfd5004caf3134";
			  
		  
		   $.ajax({
		    url: URL,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		        console.log(resp);
		        console.log("����µ� : "+ resp.main.temp );
		        console.log("������� : "+ resp.main.humidity);
		        console.log("���� : "+ resp.weather[0].main );
		        console.log("�󼼳������� : "+ resp.weather[0].description );
		        console.log("���� �̹��� : "+ resp.weather[0].icon );
		        console.log("�ٶ�   : "+ resp.wind.speed );
		        console.log("����   : "+ resp.sys.country );
		        console.log("�����̸�  : "+ resp.name );
		        console.log("����  : "+ (resp.clouds.all) +"%" );  
		        
		        var div = "";
		        div += "<p>����: "+la+", �浵: "+lon+"</p>"
		        div += "<p>���� �̸�: "+resp.name+"</p>"
		        div += "<p>���� �µ�: "+resp.main.temp+"</p>"
		        div += "<p>���� ����: "+resp.weather[0].main+"/ "+resp.weather[0].description+"</p>"
		        div += "<p>���� �ٶ�: "+resp.wind.speed+"</p>"
		      	$('.jumbotron').append(div)
		    }
		}); 
	}
  </script>
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
   	<div class="container ">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>����� </h1>
        <p>������ ��� ���</p>
        <p>------------------------------------------------	</p>
     </div>
    </div>

	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
        <h3> ��״� </h3>
        <div id="map-canvas" style="width: 80%;height: 300px;"></div>
        <div></div>
  	 </div>
	
	
</body>

</html>