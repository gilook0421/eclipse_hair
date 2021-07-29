<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){

		pageJs.init();
		
		$("#btnRetrive").trigger("click");
		
	})
		
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
					pageJs.excelDown();
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
						,prod_use_yn:$('input[name="where_use_yn"]:checked').val()
						};
				
				gl_ajax("./customerList.api"
						, inParam
						, function(result) {

							$("#tbody").html("");
							if ( result.data.length > 0 ){
			               		$.each(result.data, function(index, item){
									var itemList = "<tr class='tableDataTr'>";
									itemList += "<td><span class='tableData'>"+item.cust_name+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_sex+"</span></td>";
									itemList += "<td id='rowDetail'><span class='tableData' style='cursor: pointer;'><u>"+item.cust_phone1+"</u></span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_upd_date+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_etc+"</span></td>";
									itemList += "<td><span class='tableData'><button id='rowDel' class='formBtn'>삭제</button></span></td>";
									
									itemList += "</tr>";
										
									$("#tbody").append(itemList);
											
									$("#tbody tr").find("#rowDetail").eq(index).on("click", function(){
										pageJs.dataOnce(item);
									});

									$("#tbody tr").find("#rowDel").eq(index).on("click", function(){
										console.log("삭제클릭시 : " + JSON.stringify(item));
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

				var name = $("#reg_cust_name").val();
				var sex = $('input[name="reg_cust_sex"]:checked').val();
				var phone1 = $("#reg_cust_phone1").val();
				var etc = $("#reg_cust_etc").val();
				
				// 성함
				if (name.length < 2) {
					alert("성명은 2자 이상으로 설정해야 합니다.");
					$("#reg_cust_name").focus();
					return false;
				}
				// 성함
				if($.trim(name) !== name){
					alert("성명은 공백 입력이 불가능합니다.");
					return false;
				}
				
				// 연락처
				if (phone1.length < 10) {
					alert("연락처는 10자 이상으로 설정해야 합니다.");
					$("#cust_phone1").focus();
					return false;
				}
				// 연락처
				if($.trim(phone1) !== phone1){
					alert("연락처는 공백입력이 불가능합니다.");
					return false;
				}
				
				var inParam = {
					cust_name:name
					,cust_phone1:phone1
					,cust_sex:sex
					,cust_etc:etc
				};
				
				gl_ajax("./customerWrite.api"
						, inParam
						, function(outParam) {
							console.log("ok");
							location.href = "./customerListView.api";
						} 
					);
				
			}
			,dataOnce:function(item){
				
			}
			,dataUpd:function(){
				
			}
			,dataDel:function(){
				
			}
			,pageMove:function(idx){
				pageJs.pageIndex = idx;
				pageJs.search();
			}
			,excelDown:function(){
				
			}
	};
		
</script>

 

<div id="content" style="padding-bottom: 30px;">
	
	<!-- title -->
	<div class="subTitle" >
		<h3>&nbsp;손님관리</h3>
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
	</div>
	<!-- //상단버튼 -->	
	
	<!-- 리스트 -->		
	<div class="tableDiv" >
	
		<table class="table">
		  	<thead>
		  	  	<tr class="tableHeaderTr">
			      	<th width="10%" class="tableHeaderLeft">성함</th>
			      	<th width="10%" class="tableHeaderLeft">남여</th>
			      	<th width="15%" class="tableHeaderLeft">연락처</th>
			      	<th width="20%" class="tableHeaderLeft">최근방문일</th>
			      	<th width="*" class="tableHeaderLeft">비고</th>
			      	<th width="10%" class="tableHeaderLeft" >상태변경</th>
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
			      		<th class="formLabel" >성명</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_name" name="reg_cust_name" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >성별</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='reg_cust_sex0' name='reg_cust_sex' value='woman' checked>
							<label> 여성</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='reg_cust_sex1' name='reg_cust_sex' value='man'>
							<label> 남성</label>
			      		</td>
				  </tr>
				  
			  	  	<tr>
			      		<th class="formLabel" >핸드폰번호</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_phone1" name="reg_cust_phone1" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >비고</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_etc" name="reg_cust_etc" class="formInput" />
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

