<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function(){
	
	//
	$("#writeBtn").click(function(){
		location.href='../board/writeView.api';
	})
	
	//
	$("#boardWriteBtn").click(function(){
	
		var inParam = $("#boradWriteForm").serializeArray();
		var outParam = {};
		gl_ajax("./boardWrite.api", inParam, function(outParam) {boardWriteCallBack(outParam);} );
		
	});
	
	// 글쓰기 토글
	$("#goWrite").on("click", function(){
		$("#id01").toggle();
	});

	$("#goSearch").on("click", function(){
		onLoad();
	});
	
	onLoad();
	
});
	
function onLoad(){

	var inParam = {};
	var outParam = {};
	gl_ajax("./boardList.api", inParam, function(outParam) {boardListCallBack(outParam);} );
}

function boardListCallBack(result){
	$("#tbody").html();
    var parseData = JSON.parse(JSON.stringify(result));
	$.each(parseData.data, function(index,item){
		var itemList = "<tr>";
		itemList += "<td><span>"+item.bod_no+"</span></td>";
		itemList += "<td><span>"+item.bod_subject+"</span><br><span>"+"작성자() / " + item.bod_upd_date+"</span></td>";
		itemList += "<td><span>"+item.bod_read_count+"</span></td>";
		itemList += "<td><span>"+item.bod_comt_count+"</span></td>";   
		itemList += "<td><span><button id='rowchild'>댓글</button></span></td>";                     
		itemList += "</tr>";
		
		$("#tbody").append(itemList); 
	
		$("#tbody tr").find("#rowchild").eq(index).on("click", function(){
			//console.log("댓글 : " +  JSON.stringify(item) );
			alert("작업중입니다.");
		});
	})
}

function boardWriteCallBack(result){
	console.log(result);
	location.href = "./listView.api";
}
</script>


<div id="content">

	<!-- 조회 -->			  
	<div class="div_main">
		<div class="div_sub">
			<table class="" border='1' style="width: 100%;">
				<colgroup>
					<col style="width:130px;">
					<col>
					<col style="width:130px;">
					<col>
				</colgroup>
			  <thead>
			  	  <tr>
			      	<th class=" " style="text-align: left; vertical-align: middle;">NO</th>
			      	<td>
			      		<input type="text" id="prod_name" name="prod_name" style="background-color: black;">
			      	</td>
			      	<th class=" " style="text-align: left; vertical-align: middle;">성함</th>
			      	<td>
			      		<input type="text" id="prod_price" name="prod_price" style="background-color: black;">
			      	</td>
				  </tr>
				  
			  	  <tr align="right">
			      	<td colspan="4">
						<button class="" id="goWrite">조회</button>
			      	</td>
				  </tr>
				  
			  </thead>
			</table>
		</div>
	</div>
	<!-- //조회 -->
	
	<!-- 게시판 목록 -->	
	<div class="div_main" >
		
			<!-- sub title -->
		  	<div class="div_sub">
				<div class="div_sub2">
					<span class="">총건수</span>
				</div>     
				<div class="div_sub2">
					<div class="div_sub2"><!-- Hello W3.CSS Layout.-->	
						<button class="" id="goWrite">글쓰기</button>
				    </div>
					<div class="div_sub2"><!-- Hello W3.CSS Layout.-->	
						<select id="defaultLine" name="defaultLine" class="">
							<option value="5">5줄 표시</option>
							<option value="10" selected>10줄 표시</option>
			    		</select>
				    </div>
				</div>     
				<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
			</div>
	</div>
	
	<div class="div_main" >
		  	<div class="div_sub table_border">
		  		<!-- div class="w3-container w3-card-4"-->
	  		  <table class="" style="font-size: small;">
			    <thead>
	      		  <tr class="">
			        <th>NO</th>
			        <th width="70%;">제목</th>
			        <th>조회</th>
			        <th>댓글</th>
			        <th></th>
			      </tr>
			    </thead>
					  <tbody id="tbody" class="list_content">
			    </tbody>
			  </table>
		    	<p class="sub_caption"><!-- Hello W3.CSS Layout.--></p>
			</div>
			
		
			<!-- paging -->
			<div class="div_sub">
				<!-- p>Add a w3-rounded class to round the borders:</p>
				<div class="w3-bar w3-border w3-round"-->
				<div class="">
				  <a href="#" class="w3-bar-item w3-button">&laquo;</a>
				  <a href="#" class="w3-bar-item w3-button">1</a>
				  <a href="#" class="w3-bar-item w3-button">2</a>
				  <a href="#" class="w3-bar-item w3-button">3</a>
				  <a href="#" class="w3-bar-item w3-button">4</a>
				  <a href="#" class="w3-bar-item w3-button">&raquo;</a>
				</div>
			</div>
			<!-- //paging -->
		
	</div>
	<!-- //게시판 목록 -->	
	
	<!-- 글쓰기 -->	
	<div id="id01" class="w3-modal">
	  	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
	    
			<!-- 글쓰기 -->
			<div class="w3-content w3-container w3-margin-top">
				<div class="w3-container ">
				
					<!-- sub title -->
					<div class="w3-panel w3-leftbar w3-border-green">
						<h2 class="sub_title">글쓰기</h2>
					</div>
				    <div class="w3-center">
				      <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
				    </div>
					<!-- sub title -->          
				  
					<!--content -->
				    <div id="writeView" >
						<form id="boradWriteForm">
							<p>
								<input class="w3-input" id="bod_subject" name="bod_subject" type="text" placeholder="subject.." required>
							</p>
							<p>
								<textarea class="w3-input w3-border w3-round" id="bod_content" name="bod_content" rows="5" placeholder="content.." style="resize: vertical;" required></textarea>
							</p>
						</form>
				    </div>
					<!--content -->
				  
				</div>
				
				<p class="w3-right">
					<button id="boardWriteBtn" type="button" class="w3-button w3-green w3-round">확인</button>
					<!-- button type="button" class="w3-button w3-black w3-round" onclick="history.go(-1)">취소</button-->
				</p>
				
			</div>
			<!-- //글쓰기 -->
			
	  	</div>
		
	</div>
	<!-- //글쓰기 -->	
	
</div>
