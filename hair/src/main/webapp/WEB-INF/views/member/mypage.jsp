<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
	
		var inParam = {};
		gl_ajax("./mypageInfo.api", inParam, function(result) {mypageInfoCallBack(result);} );
			
		// 회원정보변경
		 $("#myInfoUpd").click(function(){
			
			var inParam = {};
			gl_ajax("./mypageUpd.api", inParam, function(result) {mypageUpdCallBack(result);} );
		
		}) 
		
		// 비밀번호변경
		 $("#updatePw").click(function(){
			
			var inParam = {};
			gl_ajax("./updatePw.api", inParam, function(result) {updatePwCallBack(result);} );
		
		}) 
		
		// 회원탈퇴
		$("#memberLeave").click(function(){
		
			if ( $("#old_pw").val() == "" ) {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if ( confirm("정말로 탈퇴하시겠습니까?") ){
				var inParam = {
					mem_id:$("#id").val()
					, mem_pw:$("#old_pw").val()
					};
				gl_ajax("./memberLeave.api", inParam, function(result) {memberLeaveCallBack(result);} );
				
			}
			
		})
		
	});
	
function mypageInfoCallBack(result){
	console.log("mypageInfoCallBack : " + JSON.stringify(result));
	
	$("#mem_id").val(result.data.mem_id);
	$("#mem_name").val(result.data.mem_name); 
	$("#mem_phone1").val(result.data.mem_phone1);
	$("#mem_reg_date").val(result.data.mem_reg_date);
}

function mypageUpdCallBack(result){
	console.log("mypageUpdCallBack : " + JSON.stringify(result));
}

function memberLeaveCallBack(result){
	console.log("memberLeaveCallBack : " + JSON.stringify(result));

	alert(result.msg.resultMsg);
	location.href="/";
}

function updatePwCallBack(result){
	console.log("updatePwCallBack : " + JSON.stringify(result));
}
</script>




<div id="content">

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<p class="w3-right">
				<button id="memberLeave" class="w3-button w3-green w3-round" >회원탈퇴</button>
		      	<button type="button" class="w3-button w3-red w3-round" onclick="history.go(-1);">Cancel</button>
			</p>
			<div class="w3-center w3-large w3-margin-top">
				<h3>My Page</h3>
			</div>
		</div>
		
		<div class="w3-content w3-container w3-margin-top w3-container w3-card-4">
			<form id="myForm"  >
				<table style="width:100%; font-size: small;">
					<tr>
						<td>
							<p>
								<label>ID</label> 
								<input class="w3-input" type="text" id="mem_id" name="mem_id" readonly > 
							</p>
						</td>
						<td>
							<p>
								<label><font color="red">*</font>성함</label> 
								<input class="w3-input" type="text" id="mem_name" name="mem_name" required maxlength="10" placeholder="2자리이상으로 구성해주세요." > 
							</p>
						</td>
					</tr>
					
					<tr>
						<td>
							<p>
								<label><font color="red">*</font>연락처1</label> 
								<input class="w3-input" type="text" id="mem_phone1" name="mem_phone1" required placeholder="예. 01012345678"> 
							</p>
						</td>
						<td>
							<p>
								<label><font color="red"></font>가입일</label> 
								<input class="w3-input" type="text" id="mem_reg_date" name="mem_reg_date" readonly> 
							</p>
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<p>
								<label>Email</label> 
								<input class="w3-input" type="text" id="mem_email" name="mem_email" readonly> 
							</p>
						</td>
					</tr>
				</table>
			</form>
				
				<p class="w3-right">
					<button type="button" id="myInfoUpd" class="w3-button w3-green w3-margin-top w3-round">회원정보 변경</button>
				</p>
		</div>

		<div class="w3-content w3-container w3-margin-top w3-container w3-card-4">
			<form id="pwForm"  >	
				<input type="hidden" name="mem_id" >
				
				<table style="width:100%; font-size: small;">
					<tr>
						<td>
							<p>
								<label>현재 비밀번호</label>
								<input class="w3-input" type="password" id="old_pw" name="old_pw" required placeholder="9자리이상, 숫자 및 영문자 조합으로 구성해주세요.">
							</p>
						</td>
					</tr>
					
					<tr>
						<td>
							<p>
								<label>변경할 비밀번호</label> 
								<input class="w3-input" type="password" id="pw" name="pw"  required placeholder="9자리이상, 숫자 및 영문자 조합으로 구성해주세요.">
							</p>
						</td>
					</tr>
					
					<tr>
						<td>
							<p>
								<label>변경할 비밀번호 재확인</label>
								<input class="w3-input" type="password" id="pw2" name="pw2" required placeholder="9자리이상, 숫자 및 영문자 조합으로 구성해주세요.">
							</p>
						</td>
					</tr>
					
				</table>
			</form>
				<p class="w3-right">
					<button type="button" id="pwBtn" class="w3-button w3-green w3-margin-top w3-round">비밀번호 변경</button>
				</p>
				<!-- <p class="w3-center">
					<button id="memberLeave" type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">회원탈퇴</button>
					<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
				</p> -->
		</div>
	</div>



</div>