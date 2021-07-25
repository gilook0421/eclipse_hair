<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Form</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function(){
		//alert("jquery in.");
		$("#boardWriteBtn").click(function(){
			$.ajax({
				url:"./boardWrite.api",
				type:"POST",
				data:$("#boradWriteForm").serializeArray(),
				datatype:"json",
				success:function(result){
					console.log(result);
					location.href = "./listView.api";
				},
				error:function(request,status,error){
					alert("[BoardWriteForm]code : " + request.status+"\nerror : " + error);
				}
			})
			
		})
		
	})
</script>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>게시판 글 작성 양식</h3>
			</div>
			<div>
				<form id="boradWriteForm" >
					<input class="w3-input w3-border w3-round" id="bod_subject" name="bod_subject" type="text"   >
					<br />
					<textarea class="w3-input w3-border w3-round" id="bod_content" name="bod_content" rows="10"   style="resize: vertical;"  ></textarea>
					<p class="w3-center">
						<button id="boardWriteBtn" type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">확인</button>
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" onclick="history.go(-1)">취소</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
