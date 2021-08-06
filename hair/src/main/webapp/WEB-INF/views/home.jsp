<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(document).ready(function(){

	// 로그인
	$("#homeLogin").click(function(){
		if ( $("#id").val() == "" ){
			alert("ID를 입력하세요");
			return false;
		} 
		
		if( $("#pw").val() == "" ){
			alert("비밀번호를 입력하세요");
			return false;
		}

		var inParam = {
			mem_id:$("#id").val()
			,mem_pw:$("#pw").val()
		};
		gl_ajax("./login.api", inParam, function(result) {
			console.log("findPwCallBack : " + JSON.stringify(result));
			
			alert(result.mem_id+"님 반갑습니다.");
			location.href = "/main/dashView.api";
				
		} );
		
	});
	
})

	
</script>

	<div id = "Progress_Loading"><!-- 로딩바 -->
		<img src="../resources/gif/progressBar.gif"/>
	</div>

	<!-- 슬라이드쇼 시작 -->
	<div class="container" style="width: 100%;">
		<!-- h2>Hello!</h2-->
	  	<h2></h2>
	  	<div id="myCarousel" class="carousel slide" data-ride="carousel"  style="float: left;width: 75%;">
	    	<!-- Indicators -->
	    	<ol class="carousel-indicators">
	      		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      		<li data-target="#myCarousel" data-slide-to="1"></li>
	      		<li data-target="#myCarousel" data-slide-to="2"></li>
	      		<li data-target="#myCarousel" data-slide-to="3"></li>
	      		<li data-target="#myCarousel" data-slide-to="4"></li>
	      		<li data-target="#myCarousel" data-slide-to="5"></li>
    		</ol>
	
	    	<!-- Wrapper for slides -->
	    	<div class="carousel-inner">
	
	      		<div class="item active">
	        		<img src="../resources/img/mainSlide1.png" alt="mainSlide1" style="width:100%;height:600px;">
	      		</div>
	  
	      		<div class="item">
	        		<img src="../resources/img/mainSlide2.png" alt="mainSlide2" style="width:100%;height:600px;">
	      		</div>
	      
	      		<div class="item">
	        		<img src="./resources/img/mainSlide3.png" alt="mainSlide3" style="width:100%;height:600px;">
	      		</div>
	      
	      		<div class="item">
	        		<img src="../resources/img/mainSlide4.png" alt="mainSlide4" style="width:100%;height:600px;">
	      		</div>
	      
	      		<div class="item">
	        		<img src="../resources/img/mainSlide5.png" alt="mainSlide5" style="width:100%;height:600px;">
	      		</div>
	      
	      		<div class="item">
	        		<img src="../resources/img/mainSlide6.png" alt="mainSlide6" style="width:100%;height:600px;">
	      		</div>
	      
	    	</div>
	
	    	<!-- Left and right controls -->
	    	<a class="left carousel-control" href="#myCarousel" data-slide="prev">
	      		<span class="glyphicon glyphicon-chevron-left"></span>
	      		<span class="sr-only">Previous</span>
	    	</a>
	    	<a class="right carousel-control" href="#myCarousel" data-slide="next">
	      		<span class="glyphicon glyphicon-chevron-right"></span>
	      		<span class="sr-only">Next</span>
    		</a>
	  	</div>
	  
		<!-- 로그인 -->
		<div id="loginBody" style="float: right;width: 23%;">
    		<div class="loginForm">
				<h2>Login</h2>
	      		<div class="idForm">
	        		<input type="text" class="id" placeholder="ID" id="id">
	      		</div>
	      		
	      		<div class="passForm">
	        		<input type="password" class="pw" placeholder="PW" id="pw">
	      		</div>
	      		<button type="button" class="btn" id="homeLogin">LOG IN</button>
	      		<div class="bottomText">
	        		Don't you have ID? <a href="#">sign up</a>
	      		</div>
      		</div>
	  	</div>
	  	<!--// 로그인 -->
	  
	</div>
	<!-- 슬라이드쇼 종료 -->
	
<style>
#loginBody {
  background-color: white;
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;
  border-radius: 15px;
}

.loginForm {
  height:560px;
  text-align:center;
}

.loginForm h2{
  text-align: center;
  margin: 30px;
}

.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.passForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn:hover {
  background-position: right;
}

.bottomText {
  text-align: center;
}
</style>
  