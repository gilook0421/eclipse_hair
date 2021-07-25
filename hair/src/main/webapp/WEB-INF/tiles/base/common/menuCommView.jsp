<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	$(function(){
		
		$("#findId").hide();// 아이디 찾기
		$("#findPw").hide();// 비번 찾기
	
		// 로그인
		$("#loginBtn").click(function(){
			$("#loginView").show();
			$("#loginViewImg").show();
			$("#findId").hide();// 아이디 찾기
			$("#findPw").hide();// 비번 찾기
		})
		
		// 아이디 찾기
		$("#findIdBtnLink").click(function(){
			$("#findId").show();	
			$("#loginView").hide();
			$("#loginViewImg").hide();
			$("#findPw").hide();
		})
		
		// 아이디 찾기 취소
		$("#findBtnX").click(function(){
			$("#findId").hide();
		})
		
		// 비밀번호 찾기
		$("#findPwBtnLink").click(function(){
			$("#findPw").show();
			$("#loginView").hide();
			$("#loginViewImg").hide();
			$("#findId").hide();
		})
		
		// 비밀번호 찾기 취소
		$("#findPwBtnX").click(function(){
			$("#findPw").hide();
		})
		
		// 로그인
		$("#login").click(function(){
			if ( $("#mem_id").val() == "" ){
				alert("ID를 입력하세요");
				return false;
			} 
			
			if( $("#mem_pw").val() == "" ){
				alert("비밀번호를 입력하세요");
				return false;
			}

			var inParam = $("#loginForm").serializeArray();
			var outParam = {};
			gl_ajax("./login.api", inParam, function(outParam) {
				console.log("findPwCallBack : " + JSON.stringify(result));
				
				 if(result.msg.resultStatus == "success"){
					alert(result.data.mem_id+"님 반갑습니다.");
					//location.href = "../";
					// 권한별 메뉴 처리
					homeInit();
					
					$("#id01").hide();
				}
				else{
					alert(result.msg.resultMsg);
					return false;
				} 
			} );
			
		});
		
		// 아이디찾기
		$("#findBtn").click(function(){
			if ( $("#mem_email").val() == "" ){
				alert("이메일을 입력해주세요.");
				return false;
			} 	
			
			var inParam = $("#findIdForm").serializeArray();
			var outParam = {};
			gl_ajax("./findId.api", inParam, function(outParam) {
				console.log("findPwCallBack : " + JSON.stringify(result));
				
				if (result.msg.resultStatus == "success"){
					alert("검색된 아이디 : "+ result.data);
				}
				else{
					alert(result.msg);
					return false;
				}
			} );
			
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
			
			var inParam = {
				mem_id:$("#pw_id").val(),
				mem_email:$("#pw_email").val()
				};
			var outParam = {};
			
			gl_ajax("./findPw.api", inParam, function(outParam) {
				console.log("findPwCallBack : " + JSON.stringify(result));
				
				if ( result.msg.resultStatus == "success"){
					alert(result.msg.resultMsg);
				}
				else{
					alert(result.msg.resultMsg);
					return false;
				}
			});
			
		})
		
		// 로그아웃
		$("#logoutBtn").click(function(){
		
			var inParam = {};
			var outParam = {};
			gl_ajax("./logout.api", inParam, function(outParam) {
				console.log("logoutCallBack : " + JSON.stringify(result));
				
				if( "succes" == result.resultStatus){
					location.href="./";
				}
				else{
					alert("로그아웃에 실패했습니다.");
					return false;
				}
			});
			
		});
		
/* 
		.ajaxStart(function(){
			$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
		})

		.ajaxStop(function(){
			$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
		}); */

		// 권한별 메뉴 처리
		menuCommView.homeInit();
	})
	
	var menuCommView = {
		homeInit:function(){
			var inParam = {};
			var outParam = {};
			gl_ajax("/home.api"
					, inParam
					, function(result) {

						console.log("homeCallBack : " + JSON.stringify(result) );
						if ( result.data == null ){
							$("#loginBtn").removeClass("hide");// 로그인
							$("#memberJoin").removeClass("hide");// 회원가입
							$("#memberListView").addClass("hide");//  
							$("#mypageBtn").addClass("hide");// 마이페이지
							$("#logoutBtn").addClass("hide");// 로그아웃
							$("#boardBtn").removeClass("hide");// 게시판
							
							$("#prodBtn").addClass("hide");// 상품관리
							$("#custBtn").addClass("hide");// 손님관리
							$("#salesBtn").addClass("hide");// 매출관리
							$("#businessBtn").addClass("hide");// 사업장관리
							$("#chartBtn").addClass("hide");// chart
						}
						else{
							$("#loginBtn").addClass("hide");// 로그인
							$("#memberJoin").addClass("hide");// 회원가입
							$("#memberListView").removeClass("hide");//  
							$("#mypageBtn").removeClass("hide");// 마이페이지
							$("#logoutBtn").removeClass("hide");// 로그아웃
							$("#boardBtn").removeClass("hide");// 게시판
							
							$("#prodBtn").removeClass("hide");// 상품관리
							$("#custBtn").removeClass("hide");// 손님관리
							$("#salesBtn").removeClass("hide");// 매출관리
							$("#businessBtn").removeClass("hide");// 사업장관리
							$("#chartBtn").removeClass("hide");//chart
						}
						
						$("#topMenu").css("display", "block");
					} 
			);
			
		}
	
	};
		
</script>

		
	<!-- 로그인 -->	
	<div id="id01" class="w3-modal">
	  <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
	
	    <div class="w3-center"><br>
	      <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
	      <img id="loginViewImg" src="./resources/img/login_avatar4.png" alt="Avatar" style="width:30%" class="w3-circle w3-margin-top">
	    </div>
	
	    <div class="w3-container" >
	    
		    <!-- 로그인 -->
			<div id="loginView" class="w3-section">
				<form id="loginForm" >
					<label><b>Id</b></label>
					<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Id" id="mem_id" name="mem_id" required>
					<label><b>Password</b></label>
					<input class="w3-input w3-border" type="password" placeholder="Enter Password" id="mem_pw" name="mem_pw" required>
				</form>
				<button id="login" class="w3-button w3-block w3-green w3-section w3-padding w3-round" >Login</button>
				<input class="w3-check w3-margin-top" type="checkbox" checked="checked"> Remember me
			</div>
		     
			<!-- 아이디 찾기 -->  
			<div id="findId" class="w3-content w3-container w3-margin-top">
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<form id="findIdForm" >
						<p>
							<label>Email</label>
							<input class="w3-input" type="text" id="mem_email" name="mem_email" required>
						</p>
					</form>
					<p class="w3-center">
						<button type="button" id=findBtn class="w3-button w3-block w3-green w3-section w3-padding w3-round">find</button>
						<!-- <button type="button" id=findBtnX class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button> -->
					</p>
				</div>
				
			</div>
			
			<!-- 비밀번호 찾기 -->
			<div id="findPw" class="w3-content w3-container w3-margin-top">
				<div class="w3-center w3-large w3-margin-top">
					<h3>비밀번호 찾기</h3>
				</div>
				<div>
					<form id="findPwForm" >
						<p>
							<label>ID</label>
							<input class="w3-input" type="text" id="pw_id" name="pw_id" required>
						</p>
						<p>
							<label>Email</label>
							<input class="w3-input" type="text" id="pw_email" name="pw_email" required>
						</p>
					</form>
					<p class="w3-center">
						<button type="button" id=findPwBtn class="w3-button w3-block w3-green w3-section w3-padding w3-round">find</button>
						<!-- <button type="button" id=findPwBtnX class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button> -->
					</p>
				</div>
			</div>
		
	    </div>
	
	    <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
	      <button onclick="document.getElementById('id01').style.display='none'" type="button" class="w3-button w3-red">Cancel</button>
	      <span id="findIdBtnLink" class="w3-right w3-padding w3-hide-small">Forgot <a href="#">id?</a></span>  
	      <span id="findPwBtnLink" class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
	    </div>
	
	  </div>
		
	</div>
  
