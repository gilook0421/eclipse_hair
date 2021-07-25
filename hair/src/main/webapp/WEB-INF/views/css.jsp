<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(document).ready(function(){
	
	var $menuEle = $('dt'); // 탭메뉴를 변수에 지정
	$menuEle.click(function() { // 탭메뉴 클릭 이벤트
	    $('dd').addClass('hidden');
	    $(this).next().removeClass('hidden');
	})
	
})
</script>

	<!-- 탭메뉴 만들기 -->
	<dl>
	   <dt style="color: orange;">▶메뉴바타입</dt>
	   <dd>
			<!-- 메뉴바타입 -->
			<div style="width:100%; height:500px; border: 1px solid blue;padding: 5px 5px 5px 5px;">
				<div style="height: 50px; border: 1px solid red;">
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
				</div>
				<div style="height: 50px; border: 1px solid red; text-align: center;">
					<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
				</div>
				<div style="height: 50px; border: 1px solid red;">
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
				</div>
				<div style="height: 50px; border: 1px solid red; width: 100%; display: inline-table;">
					<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
				</div>
				<div style="height: 50px; border: 1px solid red;">
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
					<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
				</div>
			</div>
			<!-- //메뉴바타입 -->
	   </dd>
	
	   <dt style="color: orange;">▶사이드메뉴바타입</dt>
	   <dd class="hidden">
			<!-- 사이드메뉴바타입 -->
			<div style="width:100%; height:500px; border: 1px solid blue;padding: 5px 5px 5px 5px;">
				<div style="width: 10%;height: 100%; border: 1px solid orange; float: left;"></div>
				<div style="width: 90%;height: 100%; border: 1px solid orange; float: right;">
					<div style="height: 50px; border: 1px solid red;">
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
					</div>
					<div style="height: 50px; border: 1px solid red; text-align: center;">
						<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; display: inline-block;"></div>
					</div>
					<div style="height: 50px; border: 1px solid red;">
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
					</div>
					<div style="height: 50px; border: 1px solid red; width: 100%; display: inline-table;">
						<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange;"></div>
					</div>
					<div style="height: 50px; border: 1px solid red;">
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: left;"></div>
						<div style="width: 50px;height: 45px; border: 1px solid orange; float: right;"></div>
					</div>
				</div>
			</div>
			<!-- //사이드메뉴바타입 -->
	   </dd>
	</dl>
	

  