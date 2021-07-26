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


/* paging */
.paging {margin:20px auto 0; text-align: center;}
.paging ul,.paging li,.paging a{display:inline-block;}
.paging li {pagging:0 8px; height: 22px; margin: 0 2px; border: 0px solid #dddddd; border-radius: 2px; font-size: 13px; line-height: 22px;}
.paging li:hover {border: 1px solid #7d7a82; color:#fff; background-color: #7d7a82;}
.paging li:hover a {color: #fff;}
</style>

<script>
	$(function(){
		
		pageJs.init();
		
		$("#btnRetrive").trigger("click");
		
	});
	
	
	var pageJs = {
			pageIndex:1// 페이징 위치
			,mntViewCnt:10 // 가져올 로우 수
			,pageSize:5 // 표시할 페이징 갯수
			,init:function(){
				
				$("#btnReg").on("click", function(){
					$("#regArea").toggle("slow");	
				})
				$("#updArea").on("click", function(){
					$("#updArea").toggle("slow");	
				})
				
				// 조회
				$("#btnRetrive").on("click", function(){
					pageJs.searchBef();
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
						prod_use_yn:use,
						prod_etc:etc
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
					var prod = $("#upd_prod_name").val();
					var price = $("#upd_prod_price").val();
					var use = $("#upd_use_yn").val();
					var etc = $("#upd_use_etc").val();
					
					
					// 상품명
					if (prod.length < 1) {
						alert("상품명은 1자 이상으로 설정해야 합니다.");
						$("#upd_prod_name").val("").focus();
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
						$("#prod_price").focus();
						return false;
					}
					// 가격
					if($.trim(price) !== price){
						alert("가격은 공백입력이 불가능합니다.");
						return false;
					}
					
					//var inParam = $("#joinForm").serializeArray();
					var inParam = {
						prod_name:name,
						prod_price:price,
						prod_use_yn:use,
						prod_etc:etc
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
			,searchBef:function(){
				pageJs.pageIndex = 1;
				pageJs.search();
			}
			,search:function(){

				var inParam = {
						pageIndex:pageJs.pageIndex// 페이징 위치
						,mntViewCnt:pageJs.mntViewCnt // 가져올 로우 수
						,pageSize:pageJs.pageSize // 표시할 페이징 갯수
						,prod_name:$("#where_prod_prod").val()
						,prod_price:$("#where_prod_etc").val()
						};
				var outParam = {};
				
				gl_ajax("./productList.api"
						, inParam
						, function(result) {

							$("#tbody").html("");
							if ( result.data.length > 0 ){
			               		$.each(result.data, function(index, item){
									var itemList = "<tr style='border: 1px solid grey; height: 50px;'>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_YMD+"</span></td>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_NO+"</span></td>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_NAME+"</span></td>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_PRICE+"</span></td>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_USE_YN+"</span></td>";
									itemList += "<td><span style='color: #ccc;padding: 5px 5px 5px 5px;'>"+item.PROD_ETC+"</span></td>";
									itemList += "</tr>";
										
									$("#tbody").append(itemList);
											
								});// end each
										
								$("#paging").html(result.paging);
			               	}
			               	else{
								var itemList = "<tr>";
								itemList += "<td colspan='99'><span>결과가 없습니다.</span></td>";
								itemList += "</tr>";
								$("#tbody").append(itemList);
							}// end of if
								
						}// end of funtion 
				);// end of ajax
				
			}
			,pageMove:function(idx){
				pageJs.pageIndex = idx;
				pageJs.search();
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
		      		<input type="text" id="where_prod_prod" name="where_prod_prod" class="formInput" />
		      	</td>
		      	
		      	<th class="formLabel" >비고</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_prod_etc" name="where_prod_etc" class="formInput" />
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
	<div class="" style="border: 0px solid gray;font-size: large;padding: 10px 10px 10px 10px;">
	
		<table class="" style="width:100%;">
		  	<thead>
		  	  	<tr class="" style="text-align: center;">
			      	<th width="5%" style="color: #ccc; text-align: left;">YMD</th>
			      	<th width="5%" style="color: #ccc; text-align: left;">NO</th>
			      	<th width="*" style="color: #ccc; text-align: left;">상품</th>
			      	<th width="20%" style="color: #ccc; text-align: left;">가격</th>
			      	<th width="20%" style="color: #ccc; text-align: left;">사용여부</th>
			      	<th width="20%" style="color: #ccc; text-align: left;">비고</th>
	    	  	</tr>
		  	</thead>
		  	<tbody id="tbody" class=""></tbody>
		</table>
		
	</div>
	
	<!-- paging -->
	<div class="paging" id="paging" ></div>
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
		<div class="formBtnArea" >
			<!-- sub title -->
			<button class="formBtn" id="btnWrite" >저장</button>
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
			      		<input type="text" id="upd_prod_product" name="upd_prod_product" class="formInput" />
			      	</td>
			      	
			      	<th class="formLabel" >가격</th>
			      	<td style="width: 30%;">
			      		<input type="text" id="upd_prod_price" name="upd_prod_price" class="formInput" />
			      	</td>
				  </tr>
				  
			  	  <tr>
			      		<th class="formLabel" >사용여부</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='upd_use_yn0' name='upd_use_yn' value='Y'>
							<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='upd_use_yn1' name='upd_use_yn' value='N'>
							<label> N</label>
			      		</td>
			      	
			      		<th class="formLabel" >비고</th>
			      		<td style="width: 30%;">
				      		<input type="text" id="upd_prod_etc" name="upd_prod_etc" class="formInput" />
			      		</td>
				  	</tr>
			  </thead>
			</table>
		</div>
		<!-- 상단버튼 -->	
		<div class="formBtnArea" >
			<!-- sub title -->
			<button class="formBtn" id="btnUpdate" >변경</button>
			<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
		</div>
		<!-- //상단버튼 -->	
	</div>
	<!-- //상품변경 -->
	
</div>


