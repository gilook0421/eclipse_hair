<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
				
				// 등록영역
				$("#btnReg").on("click", function(){
					$("#regArea").show("slow");
					$("#updArea").hide("slow");		
				})
				
				// 조회
				$("#btnRetrive").on("click", function(){
					pageJs.searchBef();
				});
				// --조회
				
				// 등록
				$("#btnWrite").click(function(){
					pageJs.dataWrite();
				});
				// --등록
				
				// 변경
				$("#btnUpdate").click(function(){
					pageJs.dataUpd();
				});
				// --변경
				
				// 삭제
				$("#btnDelete").click(function(){
					pageJs.dataDel();
				});
				// --삭제 
				
				// 엑셀다운로드
				$("#btnExcelDown").on("click", function(){
					pageJs.excelDown("상품관리");
				});
			}
			,searchBef:function(){
				$("#regArea").hide("slow");
				$("#updArea").hide("slow");	
				
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
						,prod_use_yn:$('input[name="where_use_yn"]:checked').val()
						};
				
				gl_ajax("./productList.api"
						, inParam
						, function(result) {

							$("#tbody").html("");
							if ( result.data.length > 0 ){
			               		$.each(result.data, function(index, item){
									var itemList = "<tr class='tableDataTr'>";
									itemList += "<td><span class='tableData'>"+item.PROD_YMD+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.PROD_NO+"</span></td>";
									itemList += "<td id='rowDetail'><span class='tableData' style='cursor: pointer;'><u>"+item.PROD_NAME+"</u></span></td>";
									itemList += "<td><span class='tableData'>"+item.PROD_PRICE+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.PROD_USE_YN+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.PROD_ETC+"</span></td>";
									itemList += "</tr>";
										
									$("#tbody").append(itemList);
											
									$("#tbody tr").find("#rowDetail").eq(index).on("click", function(){
										pageJs.dataOnce(item);
									});
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
			,dataWrite:function(){

				var prod = $("#reg_prod_name").val();
				var price = $("#reg_prod_price").val();
				var use = $('input[name="reg_use_yn"]:checked').val();
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
				
				var inParam = {
					prod_name:prod
					,prod_price:price
					,prod_use_yn:use
					,prod_etc:etc
				};
				gl_ajax("./productWrite.api"
						, inParam
						, function(result) {
							console.log("ok");
							location.href = "./productListView.api";
						} 
				);
			}
			,dataOnce:function(item){
				//alert(JSON.stringify(item));
				console.log(JSON.stringify(item));
				
				$("#upd_prod_no").val(item.PROD_NO);
				$("#upd_prod_ymd").val(item.PROD_YMD);
				$("#upd_prod_name").val(item.PROD_NAME);
				$("#upd_prod_price").val(item.PROD_PRICE);
				$('input[name="upd_use_yn"]').val([item.PROD_USE_YN]);
				$("#upd_prod_etc").val(item.PROD_ETC);
				
				$("#regArea").hide("slow");
				$("#updArea").show("slow");	
			}
			,dataUpd:function(){
				var ymd = $("#upd_prod_ymd").val();
				var no = $("#upd_prod_no").val();
				var name = $("#upd_prod_name").val();
				var price = $("#upd_prod_price").val();
				var use = $('input[name="upd_use_yn"]:checked').val();
				var etc = $("#upd_prod_etc").val();
				
				// 상품명
				if (name.length < 1) {
					alert("상품명은 1자 이상으로 설정해야 합니다.");
					$("#upd_prod_name").focus();
					return false;
				}
				// 상품명
				if($.trim(name) !== name){
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
					prod_ymd:ymd,
					prod_no:no,
					prod_name:name,
					prod_price:price,
					prod_use_yn:use,
					prod_etc:etc
				};
				//alert(JSON.stringify(inParam));
				gl_ajax("./productUpd.api"
						, inParam
						, function(result) {
							console.log("ok");
							location.href = "./productListView.api";
						} 
				);
			}
			,dataDel:function(){
				if(confirm("정말 삭제하시겠습니까?")){
					var ymd = $("#upd_prod_ymd").val();
					var no = $("#upd_prod_no").val();
					
					var inParam = {
						prod_ymd:ymd,
						prod_no:no
					};
					gl_ajax("./productDel.api"
							, inParam
							, function(result) {
								console.log("ok");
								location.href = "./productListView.api";
							} 
					);
				}
			}
			,pageMove:function(idx){
				pageJs.pageIndex = idx;
				pageJs.search();
			}
			,excelDown:function(pfileNm){
				/* var inParam = {
					prod_name:$("#prod_name").val(),
					prod_price:$("#prod_price").val(),
					prod_use_yn:"Y"
				};
				gl_ajax("./prodExcelDown.api"
						, inParam
						, function(result) {
							console.log("excel ok");
						} 
				); */
				// ajax로 다운로드하기
				var excelUrl = "./prodExcelDown.api";
				var request = new XMLHttpRequest();
				request.open('POST', excelUrl, true);
				request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8"');
				request.responseType = "blob";
				request.onload = function(e){
					var filename = pfileNm;
					var disposition = request.getResponseHeader('Content-Disposition');
					if(disposition && disposition.indexOf('attachment') !== -1){
						var filenameRegex = /filename[^;=\n]*=((["]).*?\2|[^;\n]*)/;
						var matches = filenameRegex.exec(disposition);
						if(matches != null && matches[1]) filename = decodeURI(matches[1].replace(/['"]/g, ''));
					}
					
					console.log("filename : " + filename);
					
					if(this.status === 200){
						var blob = this.response;
						if(window.navigator.msSaveOrOpenBlob){
							window.navigator.msSaveBlob(blob, filename);
						}
						else{
							var downloadLink = window.document.createElement('a');
							var contentTypeHeader = request.getResponseHeader("Content-Type");
							downloadLink.href = window.URL.createObjectURL(new Blob([blob], {type: contentTypeHeader}));
							downloadLink.download = filename;
							document.body.appendChild(downloadLink);
							downloadLink.click();
							document.body.removeChild(downloadLink);
						}
					}
					
				}

				/* var inParam = {
						pageIndex:pageJs.pageIndex// 페이징 위치
						,mntViewCnt:pageJs.mntViewCnt // 가져올 로우 수
						,pageSize:pageJs.pageSize // 표시할 페이징 갯수
						,prod_name:$("#where_prod_prod").val()
						,prod_price:$("#where_prod_etc").val()
						,prod_use_yn:$('input[name="where_use_yn"]:checked').val()
						}; */
				var param = 'prod_name='+$("#where_prod_prod").val()
					+'&prod_price='+$("#where_prod_etc").val()
					+'&prod_use_yn='+$('input[name="where_use_yn"]:checked').val()
					;
			
				request.send(param);
				
			}
	};
	
	
</script>


<div id="content" style="padding-bottom: 30px;">

	<!-- title -->
	<div class="subTitle" >
		<h3>&nbsp;상품관리</h3>
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
				
	<!-- 등록 -->	
	<div id="regArea" style="display: none;">
	
		<div class="subTitle" >
			<h3>&nbsp;등록</h3>
		</div>
			  
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
							<input class='' type='radio' id='reg_use_yn0' name='reg_use_yn' value='Y' checked>
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
		
		<!-- 하단버튼 -->	
		<div class="formBtnArea" >
			<button class="formBtn" id="btnWrite" >저장</button>
		</div>
		<!-- //하단버튼 -->	
		
	</div>
	<!-- //등록 -->


	<!-- 변경 -->	
	<div id="updArea" style="display: none;">
	
		<div class="subTitle" >
			<h3>&nbsp;변경</h3>
		</div>
			  
		<div class="formArea" >
      		<input type="hidden" id="upd_prod_ymd" name="upd_prod_ymd" class="formInput" />
      		<input type="hidden" id="upd_prod_no" name="upd_prod_no" class="formInput" />
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
			      		<input type="text" id="upd_prod_name" name="upd_prod_name" class="formInput" />
			      	</td>
			      	
			      	<th class="formLabel" >가격</th>
			      	<td style="width: 30%;">
			      		<input type="text" id="upd_prod_price" name="upd_prod_price" class="formInput" />
			      	</td>
				  </tr>
				  
			  	  <tr>
			      		<th class="formLabel" >사용여부</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='upd_use_yn0' name='upd_use_yn' value='Y' >
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
		
		<!-- 하단버튼 -->	
		<div class="formBtnArea" >
			<button class="formBtn" id="btnUpdate" >변경</button>
			<button class="formBtn" id="btnDelete" >삭제</button>
		</div>
		<!-- //하단버튼 -->
			
	</div>
	<!-- //변경 -->
	
</div>


