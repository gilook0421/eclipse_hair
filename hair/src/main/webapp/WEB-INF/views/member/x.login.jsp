<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Login Form</title>
</head>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	$("#findId").hide();// 아이디 찾기
	$("#findPw").hide();// 비번 찾기

	// 아이디 찾기
	$("#findIdBtnLink").click(function(){
		$("#findId").show();	
	})
	// 아이디 찾기 취소
	$("#findBtnX").click(function(){
		$("#findId").hide();
	})
	
	// 비밀번호 찾기
	$("#findPwBtnLink").click(function(){
		$("#findPw").show();
	})
	// 비밀번호 찾기 취소
	$("#findPwBtnX").click(function(){
		$("#findPw").hide();
	})
	
	// 로그인
	$("#loginBtn").click(function(){
		if ( $("#mem_id").val() == "" ){
			alert("ID를 입력하세요");
			return false;
		} 
		
		if( $("#mem_pw").val() == "" ){
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		$.ajax({
			url:"./login.api",
			type:"POST",
			data:$("#loginForm").serializeArray(),
			datatype:"json",
			success:function(result){
				console.log(result);
				alert(result.data.id+"님 반갑습니다.");
				location.href = "../";
			},
			error:function(request,status,error){
				alert("[login]code"+request.status+"\nerror"+error);
			}
		});
		
	});
	
	// 아이디찾기
	$("#findBtn").click(function(){
		if ( $("#mem_email").val() == "" ){
			alert("이메일을 입력해주세요.");
			return false;
		} 	
		
		$.ajax({
			url:"./findId.api",
			type:"POST",
			data:$("#findIdForm").serializeArray(),
			datatype:"json",
			success:function(result){
				console.log(result);
				alert(JSON.stringify(result));
				alert(result);
				alert("검색된 아이디 : "+ result.data);
			},
			error:function(request,status,error){
				alert("[findId]code:"+requst.status+"\nerror"+error);
			}
		
		})
		
	})
	
	// 비밀번호 찾기
	$("#findPwBtn").click(function(){
		if ( $("#pw_id").val() == null ){
			alert("아이디를 입력하세요.");
			return false;
		}
		
		if ( $("#pw_email").val() == null ){
			alert("이메일을 입력하세요.");
			return false;
		}
		
		$.ajax({
			url:"./findPw.api",
			type:"POST",
			data://$("#findPwForm").serializeArray(),
			{
				mem_id:$("#pw_id").val(),
				mem_email:$("#pw_email").val()
			},
			datatype:"json",
			success:function(result){
				console.log(result);
				//alert(JSON.stringify(result));
				alert(result.msg.resultMsg);
				
			},
			error:function(request,status,error){
				alert("[findPw]code:"+request.status+"\nerror:"+error);
			}
		})
		
		
	})
	
	
})
	
</script>

<body>

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>Log In</h3>
			</div>
			<div>
				<form id="loginForm" action="../member/login.api" method="post">
					<p>
						<label>ID</label>
						<span class="w3-right w3-button w3-hover-white" title="아이디 찾기" id="findIdBtnLink">
							<i class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
						</span>
						<input class="w3-input" id="mem_id" name="mem_id" type="text" required>
					</p>
					<p>
						<label>Password</label>
						<span class="w3-right w3-button w3-hover-white" title="비밀번호 찾기" id="findPwBtnLink">
							<i class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
						</span>
						<input class="w3-input" id="mem_pw" name="mem_pw" type="password" required>
					</p>
					<p class="w3-center">
						<button id="loginBtn" type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Log in</button>
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" onclick="history.go(-1)">Cancel</button>
					</p>
				</form>
			</div>
		</div>
	</div>
	
	<div id="findId" class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form id="findIdForm" >
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<p>
						<label>Email</label>
						<input class="w3-input" type="text" id="mem_email" name="mem_email" required>
					</p>
					<p class="w3-center">
						<button type="button" id=findBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" id=findBtnX class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
				
			</form>
		</div>
	</div>
	
	<div id="findPw" class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form id="findPwForm" >
				<div class="w3-center w3-large w3-margin-top">
					<h3>비밀번호 찾기</h3>
				</div>
				<div>
					<p>
						<label>ID</label>
						<input class="w3-input" type="text" id="pw_id" name="pw_id" required>
					</p>
					<p>
						<label>Email</label>
						<input class="w3-input" type="text" id="pw_email" name="pw_email" required>
					</p>
					<p class="w3-center">
						<button type="button" id=findPwBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" id=findPwBtnX class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>

