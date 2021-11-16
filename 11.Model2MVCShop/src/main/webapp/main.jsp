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
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
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
        console.log("현재온도 : "+ (resp.main.temp- 273.15) );
        console.log("현재습도 : "+ resp.main.humidity);
        console.log("날씨 : "+ resp.weather[0].main );
        console.log("상세날씨설명 : "+ resp.weather[0].description );
        console.log("날씨 이미지 : "+ resp.weather[0].icon );
        console.log("바람   : "+ resp.wind.speed );
        console.log("나라   : "+ resp.sys.country );
        console.log("도시이름  : "+ resp.name );
        console.log("구름  : "+ (resp.clouds.all) +"%" );  
        
        var div = "";
        div += "<p>도시 이름: "+resp.name+"</p>"
        div += "<p>현재 온도: "+(resp.main.temp- 273.15)+"</p>"
        div += "<p>현재 날씨: "+resp.weather[0].main+"/ "+resp.weather[0].description+"</p>"
        div += "<p>현재 바람: "+resp.wind.speed+"</p>"
      	$('.jumbotron').append(div)
    }
}); */
window.onload = function() {
	
	findLocation();   		
};

function findLocation(){

	// Geolocation API, 위도 경도 찾기 
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showYourLocation, showErrorMsg);
	}
	else {
		
	}


	// 위치 확인 내부 함수 정의
	function showYourLocation(position) {
		var userLat = position.coords.latitude;
		var userLng = position.coords.longitude;    			
		
		// openWeather 적용 	
		getDataByLocating(userLat, userLng);
		
		

		//구글 맵 로드해 사용자 위치 마커 표시 실시
		var userLocation = new google.maps.LatLng(userLat, userLng);
		var loc = document.getElementById("map-canvas"); //구글 맵을 표시해줄 객체 지정

		var mapOptions = { //구글 맵 옵션값 설정
			center: userLocation, 
			zoom: 15, 
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			mapTypeControl: false, 
			navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL}
		}

		var map = new google.maps.Map(loc, mapOptions);
		var marker = new google.maps.Marker({position:userLocation,map:map,title:"현재 위치"});    			
	}


	// 에러 확인 내부 함수 정의
	function showErrorMsg(error) {
		console.log("");
		console.log("showErrorMsg : error : " + error.code);
		 switch(error.code) {
		 	case error.PERMISSION_DENIED:
		 		console.log("showErrorMsg : error : " + "Geolocation API의 사용 요청을 거부했습니다");
		 		break;

		 	case error.POSITION_UNAVAILABLE:
		 		console.log("showErrorMsg : error : " + "위치 정보를 사용할 수 없습니다");
		 		break;

		 	case error.TIMEOUT:
		 		console.log("showErrorMsg : error : " + "위한 요청이 허용 시간을 초과했습니다");
		 		break;

		 	case error.UNKNOWN_ERROR:
		 		console.log("showErrorMsg : error : " + "알 수 없는 오류가 발생했습니다");
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
		        console.log("현재온도 : "+ resp.main.temp );
		        console.log("현재습도 : "+ resp.main.humidity);
		        console.log("날씨 : "+ resp.weather[0].main );
		        console.log("상세날씨설명 : "+ resp.weather[0].description );
		        console.log("날씨 이미지 : "+ resp.weather[0].icon );
		        console.log("바람   : "+ resp.wind.speed );
		        console.log("나라   : "+ resp.sys.country );
		        console.log("도시이름  : "+ resp.name );
		        console.log("구름  : "+ (resp.clouds.all) +"%" );  
		        
		        var div = "";
		        div += "<p>위도: "+la+", 경도: "+lon+"</p>"
		        div += "<p>도시 이름: "+resp.name+"</p>"
		        div += "<p>현재 온도: "+resp.main.temp+"</p>"
		        div += "<p>현재 날씨: "+resp.weather[0].main+"/ "+resp.weather[0].description+"</p>"
		        div += "<p>현재 바람: "+resp.wind.speed+"</p>"
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

	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<div class="container ">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>세모당 </h1>
        <p>세상의 모든 당근</p>
        <p>------------------------------------------------	</p>
     </div>
    </div>

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
        <h3> 당그니 </h3>
        <div id="map-canvas" style="width: 80%;height: 300px;"></div>
        <div></div>
  	 </div>
	
	
</body>

</html>