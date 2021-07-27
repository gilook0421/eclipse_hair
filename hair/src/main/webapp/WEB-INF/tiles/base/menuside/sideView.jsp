<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<script>
$(function(){
	console.log("sideView");
});

function goPage(id){
	console.log("id : " + id);
}
</script>

	<!-- 메뉴 >
	<div class="container">
		<div class="">
			<span id="home" ><a href="./" target="_self" class="w3-bar-item w3-button w3-green">Home</a></span>
			<hr>
			<span id="memberJoin" class="hide">
				<a href="./member/joinView.api" target="_self" class="w3-bar-item w3-button">회원가입</a>
			</span>
			<br><span id="memberListView" 	class="hide"><a href="./member/memberListView.api" 	target="_self" class="w3-bar-item w3-button">회원관리</a></span>
			<br><span id="loginBtn" 				class="hide" onclick="document.getElementById('id01').style.display='block';"><a href="#" class="w3-bar-item w3-button">로그인</a></span>
			<br><span id="mypageBtn" 			class="hide"><a href="./member/mypageView.api" 		target="_self" class="w3-bar-item w3-button">나의정보</a></span>
			<span id="logoutBtn" 			class="hide"><a href="./member/logout.api" 				target="_self" class="w3-bar-item w3-button">로그아웃</a></span>
			<hr>
			<span id="boardBtn" 			class="hide"><a href="./board/listView.api" 					target="_self" class="w3-bar-item w3-button">게시판</a></span>
			<br><span id="prodBtn"				class="hide"><a href="./product/productListView.api"		target="_self" class="w3-bar-item w3-button">상품관리</a></span>
			<br><span id="custBtn"				class="hide"><a href="./customer/customerListView.api"target="_self" class="w3-bar-item w3-button">손님관리</a></span>
			<br><span id="salesBtn"				class="hide"><a href="./sales/salesListView.api"			target="_self" class="w3-bar-item w3-button">매출관리</a></span>
			<br><span id="businessBtn"			class="hide"><a href="./business/businessListView.api"	target="_self" class="w3-bar-item w3-button">사업장관리</a></span>
			<hr>
			<span id="chartBtn"				class="hide"><a href="./chart/chartView.api"				target="_self" class="w3-bar-item w3-button">chart</a></span>
		</div>
	</div>
	//메뉴 -->
	
	<div class="container">
		<div class="">
			<span id="home" onclick="goPage(this.id);">
				<a href="/" class="w3-bar-item w3-button w3-green">Home</a>
			</span>
			<hr><span id="memberJoin" onclick="goPage(this.id);">
				<a href="/member/joinView.api" class="w3-bar-item w3-button">회원가입</a>
			</span>
			<br><span id="memberListView" onclick="goPage(this.id);">
				<a href="/member/memberListView.api" class="w3-bar-item w3-button">회원관리</a>
			</span>
			<br><span id="loginBtn" onclick="document.getElementById('id01').style.display='block';"><a href="#" class="w3-bar-item w3-button">로그인</a></span>
			<br><span id="mypageBtn" onclick="goPage(this.id);">
				<a href="/member/mypageView.api" class="w3-bar-item w3-button">나의정보</a>
			</span>
			<span id="logoutBtn" onclick="goPage(this.id);">
				<a href="/member/logout.api" class="w3-bar-item w3-button">로그아웃</a>
			</span>
			<hr><span id="boardBtn" onclick="goPage(this.id);">
				<a href="/board/listView.api" class="w3-bar-item w3-button">게시판</a>
			</span>
			<br><span id="prodBtn" onclick="goPage(this.id);">
				<a href="/product/productListView.api" class="w3-bar-item w3-button">상품관리</a>
			</span>
			<br><span id="custBtn" onclick="goPage(this.id);">
				<a href="/customer/customerListView.api" class="w3-bar-item w3-button">손님관리</a>
			</span>
			<br><span id="salesBtn" onclick="goPage(this.id);">
				<a href="/sales/salesListView.api" class="w3-bar-item w3-button">매출관리</a>
			</span>
			<br><span id="businessBtn" onclick="goPage(this.id);">
				<a href="/business/businessListView.api"	class="w3-bar-item w3-button">사업장관리</a>
			</span>
			<hr><span id="chartBtn" onclick="goPage(this.id);">
				<a href="/chart/chartView.api" class="w3-bar-item w3-button">chart</a>
			</span>
		</div>
	</div>
	
	
  
