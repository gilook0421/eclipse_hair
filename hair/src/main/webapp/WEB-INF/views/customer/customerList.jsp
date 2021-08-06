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
				
				gl_ajax("./customerList.api"
						, inParam
						, function(result) {

							$("#tbody").html("");
							if ( result.data.length > 0 ){
			               		$.each(result.data, function(index, item){
									var itemList = "<tr class='tableDataTr'>";
									itemList += "<td id='rowDetail'><span class='tableData' style='cursor: pointer;'><u>"+item.cust_name+"</u></span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_sex+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_phone1+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_upd_date+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_etc+"</span></td>";
									itemList += "<td><span class='tableData'>"+item.cust_del_yn+"</span></td>";
									
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
				var phone2 = $("#reg_cust_phone2").val();
				var phone3 = $("#reg_cust_phone3").val();
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
					$("#reg_cust_phone1").focus();
					return false;
				}
				// 연락처
				if($.trim(phone1) !== phone1){
					alert("연락처는 공백입력이 불가능합니다.");
					return false;
				}
				// 연락처2
				if (phone2.length > 0 && phone2.length < 10) {
					alert("연락처는 10자 이상으로 설정해야 합니다.");
					$("#reg_cust_phone2").focus();
					return false;
				}
				// 연락처3
				if (phone3.length > 0 && phone3.length < 10) {
					alert("연락처는 10자 이상으로 설정해야 합니다.");
					$("#reg_cust_phone3").focus();
					return false;
				}
				
				var inParam = {
					cust_name:name
					,cust_phone1:phone1
					,cust_phone2:phone2
					,cust_phone3:phone3
					,cust_sex:sex
					,cust_etc:etc
				};
				
				gl_ajax("./customerWrite.api"
						, inParam
						, function(result) {
							console.log("ok");
							location.href = "./customerListView.api";
						} 
					);
				
			}
			,dataOnce:function(item){
				//alert(JSON.stringify(item));
				console.log(JSON.stringify(item));
				
				$("#upd_cust_ymd").val(item.cust_ymd);
				$("#upd_cust_no").val(item.cust_no);
				$("#upd_cust_name").val(item.cust_name);
				$('input[name="upd_cust_sex"]').val([item.cust_sex]);
				$("#upd_cust_phone1").val(item.cust_phone1);
				$("#upd_cust_phone2").val(item.cust_phone2);
				$("#upd_cust_phone3").val(item.cust_phone3);
				$("#upd_cust_etc").val(item.cust_etc);

				$("#regArea").hide("slow");
				$("#updArea").show("slow");	
			}
			,dataUpd:function(){
				var name = $("#upd_cust_name").val();
				var sex = $('input[name="upd_cust_sex"]:checked').val();
				var phone1 = $("#upd_cust_phone1").val();
				var phone2 = $("#upd_cust_phone2").val();
				var phone3 = $("#upd_cust_phone3").val();
				var etc = $("#upd_cust_etc").val();

				// 성함
				if (name.length < 2) {
					alert("성명은 2자 이상으로 설정해야 합니다.");
					$("#upd_cust_name").focus();
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
					$("#upd_cust_phone1").focus();
					return false;
				}
				// 연락처
				if($.trim(phone1) !== phone1){
					alert("연락처는 공백입력이 불가능합니다.");
					return false;
				}

				// 연락처2
				if (phone2.length > 0 && phone2.length < 10) {
					alert("연락처는 10자 이상으로 설정해야 합니다.");
					$("#upd_cust_phone2").focus();
					return false;
				}
				// 연락처3
				if (phone3.length > 0 && phone3.length < 10) {
					alert("연락처는 10자 이상으로 설정해야 합니다.");
					$("#upd_cust_phone3").focus();
					return false;
				}

				var inParam = {
					cust_ymd:$("#upd_cust_ymd").val()
					,cust_no:$("#upd_cust_no").val()
					,cust_name:name
					,cust_phone1:phone1
					,cust_phone2:phone2
					,cust_phone3:phone3
					,cust_sex:sex
					,cust_etc:etc
				};
				
				gl_ajax("./customerUpd.api"
						, inParam
						, function(result) {
							console.log("ok");
							location.href = "./customerListView.api";
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
					gl_ajax("./customerDel.api"
							, inParam
							, function(result) {
								console.log("ok");
								location.href = "./customerListView.api";
							} 
					);
				}
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
		      		<th class="formLabel" >성명</th>
		      		<td style="width: 30%;">
		      			<input type="text" id="where_cust_name" name="where_cust_name" class="formInput" />
		      		</td>
		      	
		      		<th class="formLabel" >핸드폰번호</th>
		      		<td style="width: 30%;">
		      			<input type="text" id="where_cust_phone1" name="where_cust_phone1" class="formInput" />
		      		</td>
			  	</tr>
			  
				<tr>
		      		<th class="formLabel" >성별</th>
		      		<td style="width: 30%;">
						<input class='' type='radio' id='where_cust_sex0' name='where_cust_sex' value='woman' checked>
						<label> woman</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class='' type='radio' id='where_cust_sex1' name='where_cust_sex' value='man'>
						<label> man</label>
		      		</td>
		      	
		      		<th class="formLabel" >탈회여부</th>
		      		<td style="width: 30%;">
						<input class='' type='radio' id='where_cust_del0' name='where_cust_del' value='' >
						<label> 전체</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class='' type='radio' id='where_cust_del1' name='where_cust_del' value='Y' >
						<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class='' type='radio' id='where_cust_del2' name='where_cust_del' value='N' checked>
						<label> N</label>
		      		</td>
			  	</tr>
			  	
				<tr>
		      		<th class="formLabel" >비고</th>
		      		<td style="width: 30%;" colspan="3">
		      			<input type="text" id="where_cust_etc" name="where_cust_etc" class="formInput" />
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
			      	<th width="15%" class="tableHeaderLeft">연락처1</th>
			      	<th width="20%" class="tableHeaderLeft">최근방문일</th>
			      	<th width="*" class="tableHeaderLeft">비고</th>
			      	<th width="10%" class="tableHeaderLeft" >탈회여부</th>
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
							<label> woman</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='reg_cust_sex1' name='reg_cust_sex' value='man'>
							<label> man</label>
			      		</td>
				  	</tr>
				  
					<tr>
			      		<th class="formLabel" >핸드폰번호1</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_phone1" name="reg_cust_phone1" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >핸드폰번호2</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_phone2" name="reg_cust_phone2" class="formInput" />
			      		</td>
				  	</tr>
				  
					<tr>
			      		<th class="formLabel" >핸드폰번호3</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="reg_cust_phone3" name="reg_cust_phone3" class="formInput" />
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
      		<input type="text" id="upd_cust_ymd" name="upd_cust_ymd" class="" />
      		<input type="text" id="upd_cust_no" name="upd_cust_no" class="" />
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
			      			<input type="text" id="upd_cust_name" name="upd_cust_name" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >성별</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='upd_cust_sex0' name='upd_cust_sex' value='woman' checked>
							<label> woman</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='upd_cust_sex1' name='upd_cust_sex' value='man'>
							<label> man</label>
			      		</td>
				  	</tr>
				  
					<tr>
			      		<th class="formLabel" >핸드폰번호1</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="upd_cust_phone1" name="upd_cust_phone1" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >핸드폰번호2</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="upd_cust_phone2" name="upd_cust_phone2" class="formInput" />
			      		</td>
				  	</tr>
				  	
					<tr>
			      		<th class="formLabel" >핸드폰번호2</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="upd_cust_phone3" name="upd_cust_phone3" class="formInput" />
			      		</td>
			      	
			      		<th class="formLabel" >비고</th>
			      		<td style="width: 30%;">
			      			<input type="text" id="upd_cust_etc" name="upd_cust_etc" class="formInput" />
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

