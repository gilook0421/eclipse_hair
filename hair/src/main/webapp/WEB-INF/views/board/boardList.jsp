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
		gl_ajax("./boardWrite.api", inParam, function(result) {boardWriteCallBack(result);} );
		
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
	gl_ajax("./boardList.api", inParam, function(result) {boardListCallBack(result);} );
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


<div id="content" style="padding-bottom: 30px;">

	<!-- title -->
	<div class="subTitle" >
		<h3>&nbsp;게시판</h3>
	</div>
	<!-- //title -->
	
	<!-- 조회 -->			  
	<div class="formArea" >
		<table class="" style="width: 100%">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
		  <thead>
		  	  <tr>
		      	<th class="formLabel" >상품</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_prod_prod" name="where_prod_prod" class="formInput" />
		      	</td>
		      	
		      	<th class="formLabel" >비고</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_prod_etc" name="where_prod_etc" class="formInput" />
		      	</td>
			  </tr>
			  
		  	  <tr>
		      	<th class="formLabel" >사용여부</th>
		      	<td style="width: 30%;">
						<input class='' type='radio' id='where_use_yn0' name='where_use_yn' value='' checked>
						<label> 전체</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class='' type='radio' id='where_use_yn1' name='where_use_yn' value='Y'>
						<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class='' type='radio' id='where_use_yn2' name='where_use_yn' value='N'>
						<label> N</label>
		      	</td>
		      	
		      	<th class="formLabel" ></th>
		      	<td style="width: 30%;">
		      	</td>
			  </tr>
		  </thead>
		</table>
	</div>
	<!-- //조회 -->
	
	
	<!-- 상단버튼 -->	
	<div class="formBtnArea" >
		<button class="formBtn" id="btnRetrive" >조회</button>
		<button class="formBtn" id="btnReg" >등록</button>
		<button class="formBtn" id="btnExcelDown" >엑셀다운로드</button>
	</div>
	<!-- //상단버튼 -->	
	
	<!-- 리스트 -->	
	<div class="tableDiv" >
	
		<table class="table">
		  	<thead>
		  	  	<tr class="tableHeaderTr">
			      	<th width="5%" class="tableHeaderLeft">YMD</th>
			      	<th width="5%" class="tableHeaderLeft">NO</th>
			      	<th width="*" class="tableHeaderLeft">상품</th>
			      	<th width="20%" class="tableHeaderLeft">가격</th>
			      	<th width="20%" class="tableHeaderLeft">사용여부</th>
			      	<th width="20%" class="tableHeaderLeft" >비고</th>
	    	  	</tr>
		  	</thead>
		  	<tbody id="tbody" class=""></tbody>
		</table>
		
	</div>
	<!-- //리스트 -->
	
	<!-- paging -->
	<div class="paging" id="paging" ></div>
	<!-- //paging -->
	
	
	
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
