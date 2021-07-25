<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script>
$(function(){
	console.log("sideView");
});

function goPage(id){
	console.log("id : " + id);
}
</script>

	<div class="" style="width: 100%; height: 100%; ">
		<div class="">
			<span id="home" onclick="goPage(this.id);">
				<a href="/" class="">Home</a>
			</span>
		</div>
	</div>
	
