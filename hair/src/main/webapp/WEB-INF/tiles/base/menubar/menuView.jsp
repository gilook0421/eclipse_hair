<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<!-- 메뉴 -->
	<header>
		<div id="topMenu">
			<h1><span onclick="javascript:location.href='/';" style="cursor: pointer;">GWGroup</span></h1>
			<nav >
				<ul class="subMenu"><!-- 
					<li  id="memberJoin" 		class=""><a href="/member/joinView.api" 				target="_self" class="">회원가입</a></li>
					<li  id="memberListView" 	class=""><a href="/member/memberListView.api" 	target="_self" class="">회원관리</a></li> -->
					<li  id="loginBtn" 				class="" onclick="document.getElementById('id01').style.display='block';"><a href="#" class="">로그인</a></li>
					<li  id="mypageBtn" 			class=""><a href="/member/mypageView.api" 		target="_self" class="">나의정보</a></li>
					<li  id="logoutBtn" 			class=""><a href="/logout.api" 				target="_self" class="">로그아웃</a></li>
					<li  id="boardBtn" 			class=""><a href="/board/listView.api" 					target="_self" class="">게시판</a></li>
					<li  id="prodBtn"				class=""><a href="/product/productListView.api"		target="_self" class="">상품관리</a></li>
					<li  id="custBtn"				class=""><a href="/customer/customerListView.api"target="_self" class="">손님관리</a></li>
					<li  id="salesBtn"				class=""><a href="/sales/salesListView.api"			target="_self" class="">매출관리</a></li>
					<!-- <li  id="businessBtn"			class=""><a href="/business/businessListView.api"	target="_self" class="">사업장관리</a></li>
					<li  id="chartBtn"				class=""><a href="/chart/chartView.api"				target="_self" class="">chart</a></li> -->
				</ul>
			</nav>	
		</div>
	</header>
	
