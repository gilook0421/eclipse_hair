<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style type="text/css">
th.formLabel {
	width: 20%;height: 50px;text-align: center; vertical-align: middle;padding-right: 5px;color: #ccc; font-size: large;
}

input.formInput {
	background-color: black;width: 80%;height: 30px;border-top: none; border-left: none; border-right: none; border-bottom: 3px solid gray;
}

/*버튼커버*/
.formBtnArea {
	border: 0px solid yellow; text-align: right;padding-bottom:20px;padding-top: 10px;
}
/*버튼*/
.formBtn {
	background-color: #4CAF50; color: #fff;padding: 4px 8px;border-radius: 4px;
}
</style>

<script>
	$(function(){
		
		// --엑셀다운로드
		pageJs.init();
		
		$("#btnRetrive").trigger("click");
		
	});
	
	
	var pageJs = {
			init:function(){
				
				$("#btnReg").on("click", function(){
					$("#regArea").toggle("slow");	
				})
				$("#updArea").on("click", function(){
					$("#updArea").toggle("slow");	
				})
				
				// 조회
				$("#btnRetrive").on("click", function(){

					var inParam = {};
					var outParam = {};
					gl_ajax("./productList.api"
							, inParam
							, function(result) {

								$("#tbody").html("");
								if ( result.data.length > 0 ){
				               		$.each(result.data, function(index, item){
										var itemList = "<tr style='border: 1px solid grey;'>";
										itemList += "<td><span style='color: #ccc;'>"+item.PROD_NO+"</span></td>";
										itemList += "<td><span style='color: #ccc;'>"+item.PROD_NAME+"</span></td>";
										itemList += "<td><span style='color: #ccc;'>"+item.PROD_PRICE+"</span></td>";
										itemList += "<td><span style='color: #ccc;'>"+item.PROD_USE_YN+"</span></td>";
										itemList += "<td><span style='color: #ccc;'>"+item.ETC+"</span></td>";
										itemList += "</tr>";
											
										$("#tbody").append(itemList);
												
									});// end each
											
				               	}
				               	else{
									var itemList = "<tr>";
									itemList += "<td colspan='99'><span>결과가 없습니다.</span></td>";
									itemList += "</tr>";
									$("#tbody").append(itemList);
								}// end of if
									
							}// end of funtion 
					);// end of ajax
					
				});
				// --조회
				
				// 등록
				$("#btnWrite").click(function(){
					var prod = $("#reg_prod_name").val();
					var price = $("#reg_prod_price").val();
					var use = $("#reg_use_yn").val();
					var etc = $("#reg_use_etc").val();
					
					// 상품명
					if (prod.length < 1) {
						alert("상품명은 1자 이상으로 설정해야 합니다.");
						$("#reg_prod_name").focus();
						return false;
					}
					// 상품명
					if($.trim(prod) !== prod){
						alert("상품명은 공백 입력이 불가능합니다.");
						return false;
					}
					
					// 가격
					if (price.length < 3) {
						alert("가격은 천원 이상으로 설정해야 합니다.");
						$("#reg_prod_price").focus();
						return false;
					}
					// 가격
					if($.trim(price) !== price){
						alert("가격은 공백입력이 불가능합니다.");
						return false;
					}
					
					//var inParam = $("#joinForm").serializeArray();
					var inParam = {
						prod_name:prod,
						prod_price:price,
						prod_use_yn:"Y"
					};
					var outParam = {};
					gl_ajax("./productWrite.api"
							, inParam
							, function(outParam) {
								console.log("ok");
								location.href = "./productListView.api";
							} 
					);
					
				});
				// --등록
				
				// 변경
				$("#btnUpdate").click(function(){
					
					// 상품명
					if ($("#prod_name").val().length < 1) {
						alert("상품명은 1자 이상으로 설정해야 합니다.");
						$("#prod_name").val("").focus();
						return false;
					}
					// 상품명
					if($.trim($("#prod_name").val()) !== $("#prod_name").val()){
						alert("상품명은 공백 입력이 불가능합니다.");
						return false;
					}
					
					// 가격
					if ($("#prod_price").val().length < 3) {
						alert("가격은 천원 이상으로 설정해야 합니다.");
						$("#prod_price").val("").focus();
						return false;
					}
					// 가격
					if($.trim($("#prod_price").val()) !== $("#prod_price").val()){
						alert("가격은 공백입력이 불가능합니다.");
						return false;
					}
					
					//var inParam = $("#joinForm").serializeArray();
					var inParam = {
						prod_name:$("#prod_name").val(),
						prod_price:$("#prod_price").val(),
						prod_use_yn:"Y"
					};
					var outParam = {};
					gl_ajax("./productWrite.api"
							, inParam
							, function(outParam) {
								console.log("ok");
								location.href = "./productListView.api";
							} 
					);
					
				});
				// --변경
				
				// 엑셀다운로드
				$("#btnExcelDown").on("click", function(){

					var inParam = {
						prod_name:$("#prod_name").val(),
						prod_price:$("#prod_price").val(),
						prod_use_yn:"Y"
					};
					var outParam = {};
					gl_ajax("./prodExcelDown.api"
							, inParam
							, function(outParam) {
								console.log("excel ok");
							} 
					);
					
					
				});
			}
	};
	
	
</script>


<div id="content" style="padding-bottom: 30px;">

	<!-- title -->
	<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;">
		<h3>&nbsp;상품관리</h3>
	</div>
	<!-- //title -->
		
	<!-- 조회 -->			  
	<div class="" style="border: 1px solid orange;">
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
		      		<input type="text" id="where_prod_price" name="where_prod_price" class="formInput" />
		      	</td>
		      	
		      	<th class="formLabel" >비고</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_prod_price2" name="where_prod_price2" class="formInput" />
		      	</td>
			  </tr>
		  </thead>
		</table>
	</div>
	<!-- //조회 -->
	
	<!-- 상단버튼 -->	
	<div class="formBtnArea" >
		<!-- sub title -->
		<button class="formBtn" id="btnRetrive" >조회</button>
		<button class="formBtn" id="btnReg" >등록</button>
		<button class="formBtn" id="btnExcelDown" >엑셀다운로드</button>
		<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
	</div>
	<!-- //상단버튼 -->	
	
	<!-- 상품관리 -->	
	<div class="" style="border: 1px solid gray;
    font-size: large;
    padding: 10px 10px 10px 10px;">
	
		<table class="" style="width:100%;">
		  <thead>
		  	  <tr class="" style="text-align: center;">
			      <th width="5%" style="color: #ccc;">NO</th>
			      <th width="*" style="color: #ccc;">상품</th>
			      <th width="20%" style="color: #ccc;">가격</th>
			      <th width="20%" style="color: #ccc;">사용여부</th>
			      <th width="20%" style="color: #ccc;">삭제</th>
	    	  </tr>
		  </thead>
		  <tbody id="tbody" class="">
		  </tbody>
		</table>
		
	</div>
	
	<!-- paging -->
	<div class="" style="border: 0px solid yellow; padding-top: 5px; text-align: center;">
		<!-- p>Add a w3-rounded class to round the borders:</p--> 
	  <a href="#" class="" style="color: #ccc;">&laquo;</a>
	  <a href="#" class="" style="color: #ccc;">1</a>
	  <a href="#" class="" style="color: #ccc;">2</a>
	  <a href="#" class="" style="color: #ccc;">3</a>
	  <a href="#" class="" style="color: #ccc;">4</a>
	  <a href="#" class="" style="color: #ccc;">&raquo;</a>
	</div>
	<!-- //상품관리 -->
				
	<!-- 상품등록 -->	
	<div id="regArea" style="display: none;">
	
		<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;">
			<h3>&nbsp;상품등록</h3>
		</div>
			  
		<div class="" style="border: 1px solid orange;">
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
			      			<input type="text" id="reg_prod_name" name="reg_prod_name" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >가격</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_prod_price" name="reg_prod_price" class="formInput" />
			      		</td>
				  </tr>
				  
			  	  <tr>
			      		<th class="formLabel" >사용여부</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='reg_use_yn0' name='reg_use_yn' value='Y'>
							<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='reg_use_yn1' name='reg_use_yn' value='N'>
							<label> N</label>
			      		</td>
			      	
			      		<th class="formLabel" >비고</th>
			      		<td style="width: 30%;">
				      		<input type="text" id="reg_prod_etc" name="reg_prod_etc" class="formInput" />
			      		</td>
				  	</tr>
			  	</thead>
			</table>
		</div>
		
		<!-- 상단버튼 -->	
		<div class="formBtnDiv" >
			<!-- sub title -->
			<div class="">
				<button class="formBtn" id="btnWrite" >저장</button>
			</div>     
			<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
		</div>
		<!-- //상단버튼 -->	
		
	</div>
	<!-- //상품등록 -->


	<!-- 상품변경 -->	
	<div id="updArea" style="display: none;">
	
		<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;">
			<h3>&nbsp;상품변경</h3>
		</div>
			  
		<div class="" style="border: 1px solid orange;">
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
			      		<input type="text" id="update_prod_product" name="update_prod_product" class="formInput" />
			      	</td>
			      	
			      	<th class="formLabel" >가격</th>
			      	<td style="width: 30%;">
			      		<input type="text" id="update_prod_price" name="update_prod_price" class="formInput" />
			      	</td>
				  </tr>
			  </thead>
			</table>
		</div>
		<!-- 상단버튼 -->	
		<div class="formBtnDiv" >
			<!-- sub title -->
			<div class="">
				<button class="formBtn" id="btnUpdate" >변경</button>
			</div>     
			<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
		</div>
		<!-- //상단버튼 -->	
	</div>
	<!-- //상품변경 -->
	
</div>


