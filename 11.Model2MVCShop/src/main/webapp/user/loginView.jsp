<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<meta name="google-signin-client_id" content="727326734700-pjadupjtpl0m6tdje5nomsfksla5febn.apps.googleusercontent.com"></meta>

\
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	//Google

	//���� �α���
	  


var googleUser = {};
function init() {
	 gapi.load('auth2', function() {
	  console.log("init()����");
	  auth2 = gapi.auth2.init({
	        client_id: '727326734700-pjadupjtpl0m6tdje5nomsfksla5febn.apps.googleusercontent.com',
	        cookiepolicy: 'single_host_origin',
	      });
	      attachSignin(document.getElementById('google_login'));
	 });
}

//google signin API2
function attachSignin(element) {
	
    auth2.attachClickHandler(element, {},
        function(googleUser) {
    	
    	var profile = googleUser.getBasicProfile();
    	var id_token = googleUser.getAuthResponse().id_token;
	  	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	  	  console.log('ID��ū: ' + id_token);
	  	  console.log('Name: ' + profile.getName());
	  	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	  	
	  	  var id = profile.getId().substring(0,5);
	  	  id += "google";
	  	  
	  	  console.log("id"+id);
	  	 
			$(function() {
				$.ajax({
	                  url : "/user/json/checkDuplication/"+id,
	                  headers : {
	                      "Accept" : "application/json",
	                      "Content-Type" : "application/json"
	                    },
	                    success : function(idChk){
	                        
	                        if(idChk==true){
	                            
	                            $.ajax({
	                                url : "/user/json/addUser",
	                                method : "POST",
	                                headers : {
	                                  "Accept" : "application/json",
	                                  "Content-Type" : "application/json"
	                                },
	                                data : JSON.stringify({
	                                userId : id,
	                                userName : profile.getName(),
	                                password : "1234",
	                                }),
	                                success : function(JSONData){
	                                   alert("ȸ�������� ���������� �Ǿ����ϴ�.");
	                                   $("form").attr("method","POST").attr("action","/user/snsLogin/"+id).attr("target","_parent").submit();
	                                }
	                            })
	                        }
	                        if(idChk==false){ //DB�� ���̵� ������ ��� => �α���
	                            console.log("�α�����...");
	                            $("form").attr("method","POST").attr("action","/user/snsLogin/"+id).attr("target","_parent").submit();
	                        }
	                    }
	              });
			})
        }, function(error) {
          alert(JSON.stringify(error, undefined, 2));
        });
    console.log("����API ��");
  }

	// kakao 
	
	$( function() {
		
		
		
		
	Kakao.init('51615d81a030d0475e576eb41e443c14');
	        
	$("#kakao-login-btn").on("click", function(){
		
	    //1. �α��� �õ�
	    Kakao.Auth.login({
	        success: function(authObj) {
	          //console.log(JSON.stringify(authObj));
	          console.log(Kakao.Auth.getAccessToken());
	        
	          //2. �α��� ������ API�� ȣ��
	          Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(res) {
	              //console.log(JSON.stringify(res));
	              res.id += "kakao";
	              
	              $.ajax({
	                  url : "/user/json/checkDuplication/"+res.id,
	                  headers : {
	                      "Accept" : "application/json",
	                      "Content-Type" : "application/json"
	                    },
	                    success : function(idChk){
	                        
	                        if(idChk==true){
	                            
	                            $.ajax({
	                                url : "/user/json/addUser",
	                                method : "POST",
	                                headers : {
	                                  "Accept" : "application/json",
	                                  "Content-Type" : "application/json"
	                                },
	                                data : JSON.stringify({
	                                userId : res.id,
	                                userName : res.properties.nickname,
	                                password : "1234",
	                                }),
	                                success : function(JSONData){
	                                   alert("ȸ�������� ���������� �Ǿ����ϴ�.");
	                                   $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
	                                }
	                            })
	                        }
	                        if(idChk==false){ //DB�� ���̵� ������ ��� => �α���
	                            console.log("�α�����...");
	                            $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
	                        }
	                    }
	              })
	            },
	            fail: function(error) {
	              alert(JSON.stringify(error));
	            }
	          });
	                  
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	        
	})//e.o.kakao
	});
	
	
		//============= "�α���"  Event ���� =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
			
	
		});
		
		
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">�� �� ��</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/uploadFiles/10.jpg" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">�� &nbsp;&nbsp;�� &nbsp;&nbsp;��</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">�� �� ��</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">�� �� �� ��</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >�� &nbsp;�� &nbsp;��</button>
					      <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
					    </div>
					  </div>
			
					</form>
			   	 </div>
			<div id="kakaoLogin" align="center">
    <a id="kakao-login-btn">
    <img src="/images/uploadFiles/kakaologin.png" width="60%"/>
    </a>
    <a href="http://developers.kakao.com/logout"></a>
</div>
	<div id="googleLogin" align="center">   
	 <a id="google_login">
    <img src="/images/uploadFiles/googlelogin.png" width="60%"/>
    </a>                                                 
    </div>
   
    
</div>





			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>