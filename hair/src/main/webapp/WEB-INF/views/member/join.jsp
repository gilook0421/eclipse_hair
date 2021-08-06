<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
	
		// email
		$("#memManagerTr").hide();
		
		// 회원가입
		$("#joinBtn").click(function() {
			
			// 필수체크
			if ( !doJoinValid() ){
				return false;
			}
			
			var inParam = $('#joinForm').serializeArray();
			gl_ajax("./join.api", inParam, function(result) {joinCallBack(result);} );
	
		});
		
		// id변경시
		$("#mem_id").keyup(function() {
			
			var inParam = $('#joinForm').serializeArray();
			gl_ajax("./checkId.api", inParam, function(result) {checkIdCallBack(result);} );
			
		});
		
		// email변경시
		$("#mem_email").keyup(function(){
		
			var inParam = $('#joinForm').serializeArray();
			gl_ajax("./checkEmail.api", inParam, function(result) {checkEmailCallBack(result);} );
			
		});
		
		var memManager = function(){
			console.log("관리자구분 : " + $(this).val());
			if ( $(this).val() == 'Y'){
				$("#memManagerTr").show();//removeClass("hide");
			}
			else{
				$("#memManagerTr").hide();//addClass("hide");
			}
		};
		$("input[type=radio]").on("click", memManager);
		
	})
	
	
/*
* joinCallBack
*/
function joinCallBack(result){

	console.log("joinCallBack : " + JSON.stringify(result));

	alert("반갑습니다 회원님!\n메인화면으로 이동합니다.");
	location.href = "../";
		
}

/*
* checkIdCallBack
*/
function checkIdCallBack(result){

	console.log("checkIdCallBack : " + JSON.stringify(result));
	/*
	if (result.id == 1) {
		//$("#id_check").html("중복된 아이디가 있습니다.");
		alert("중복된 아이디가 있습니다.");
		$("#joinBtn").attr("disabled", "disabled");
	} else {
		console.log(JSON.stringify(result));
		//$("#id_check").html("");
		$("#joinBtn").removeAttr("disabled");
	}
	*/
					
}

/*
* checkEmailCallBack
*/
function checkEmailCallBack(result){

	console.log("checkEmailCallBack : " + JSON.stringify(result));
	/*
	if (result.email == 1) {
		//$("#email_check").html("중복된 이메일이 있습니다.");
		alert("중복된 이메일이 있습니다.");
		$("#joinBtn").attr("disabled", "disabled");
	} else {
		//$("#email_check").html("");
		$("#joinBtn").removeAttr("disabled");
	}
	*/
		
}

/*
* doJoinValid
*/
function doJoinValid(){
	var rtn = false;
	
	/*
	if($.trim($("#mem_pw").val()) !== $("#mem_pw").val() 
	|| $.trim($("#mem_email").val()) !== $("#mem_email").val() ){
		alert("공백은 입력이 불가능합니다.");
		return false;
	}
	*/
	
	// id
	if ($("#mem_id").val().length < 8) {
		alert("id는 8자 이상으로 설정해야 합니다.");
		$("#mem_id").val("").focus();
		return false;
	}
	// id
	if($.trim($("#mem_id").val()) !== $("#mem_id").val()){
		alert("id는 공백 입력이 불가능합니다.");
		return false;
	}
	
	// 성함
	if ($("#mem_name").val().length < 2) {
		alert("성함은 2자 이상으로 설정해야 합니다.");
		$("#mem_name").val("").focus();
		return false;
	}
	// 성함
	if($.trim($("#mem_name").val()) !== $("#mem_name").val()){
		alert("성함은 공백입력이 불가능합니다.");
		return false;
	}
	
	// pw
	if ($("#mem_pw").val().length < 8) {
		alert("비밀번호는 8자 이상으로 설정해야 합니다.");
		$("#mem_pw").focus();
		return false;
	}
	// pw
	if($("#mem_pw").val() !== $("#mem_pw2").val()){
		alert("비밀번호가 다릅니다.");
		$("#mem_pw").focus();
		$("#mem_pw2").val("");
		return false;
	}
	// pw
	if($.trim($("#mem_pw").val()) !== $("#mem_pw").val() ){
		alert("비밀번호는 공백 입력이 불가능합니다.");
		return false;
	}
	
	// 연락처
	if ($("#mem_phone1").val().length < 10) {
		alert("연락처는 10자 이상으로 설정해야 합니다.");
		$("#mem_phone1").focus();
		return false;
	}
	// 연락처
	if($.trim($("#mem_phone1").val()) !== $("#mem_phone1").val()){
		alert("연락처는 공백입력이 불가능합니다.");
		return false;
	}
	
	return true;
}
</script>


<div id="content">

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<p class="w3-right">
				<button id="joinBtn" class="w3-button w3-green w3-round" >Join</button>
		      	<button type="button" class="w3-button w3-red w3-round" onclick="history.go(-1);">Cancel</button>
			</p>
			<div class="w3-center w3-large w3-margin-top">
				<h3>회원가입</h3>
			</div>
		</div>
		
		<div class="w3-content w3-container w3-margin-top w3-container w3-card-4">
		
			<form id="joinForm" action="./join.api" method="post">
				<table style="width:100%;font-size: small;" >
					<tr>
						<td>
							<p>
								<label><font color="red">*</font>ID</label> 
								<input class="w3-input" type="text" id="mem_id" name="mem_id" required maxlength="12" placeholder="8자리이상, 숫자 및 영문자 조합으로 구성해주세요."> 
							</p>
						</td>
						<td>
							<p>
								<label><font color="red">*</font>성함</label> 
								<input class="w3-input" type="text" id="mem_name" name="mem_name" required maxlength="10" placeholder="2자리이상으로 구성해주세요."> 
							</p>
						</td>
					</tr>
					
					<tr>
						<td>
							<p>
								<label><font color="red">*</font>비밀번호</label> 
								<input class="w3-input" id="mem_pw" name="mem_pw" type="password" required placeholder="9자리이상, 숫자 및 영문자 조합으로 구성해주세요.">
							</p>
						</td>
						<td>
							<p>
								<label><font color="red">*</font>비밀번호 확인</label> 
								<input class="w3-input" id="mem_pw2" type="password" required  placeholder="9자리이상, 숫자 및 영문자 조합으로 구성해주세요.">
							</p>
						</td>
					</tr>
					
					<tr>
						<td>
							<p>
								<label><font color="red"></font>관리자구분(사업주는 비관리자)</label> <br>
								<input type="radio" id="mem_manager_yn0" name="mem_manager_yn" tabindex="0" value="Y">관리자
								<input type="radio" id="mem_manager_yn1" name="mem_manager_yn" tabindex="1" value="N" checked="checked">비관리자
							</p>
						</td>
						<td>
							<p>
								<label><font color="red">*</font>연락처</label> 
								<input class="w3-input" type="text" id="mem_phone1" name="mem_phone1" required placeholder="예. 01012345678"> 
							</p>
						</td>
					</tr>
					
					<tr id="memManagerTr" >
						<td colspan="2" >
							<p>
								<label><font color="red">*</font>Email(daum, naver, gmail)</label>
								<input type="text" id="mem_email" name="mem_email" class="w3-input" required placeholder="이메일 인증 후 로그인이 가능합니다.">
							</p>
						</td>
					</tr>
				</table>
				<p class="w3-center">
					<!-- <button type="submit" id="submitBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Submit</button>-->
					<!-- <button type="button" id="joinBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Join</button>
					<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button> -->
				</p>
			</form>
			
		</div>
		
	</div>
	
</div>
