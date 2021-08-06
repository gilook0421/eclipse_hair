<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){

		pageJs.init();
		
	})
	
	
	var pageJs = {
			pageIndex:1// 페이징 위치
			,mntViewCnt:10 // 가져올 로우 수
			,pageSize:5 // 표시할 페이징 갯수
			,init:function(){

				// 조회
				$("#btnRetrive").on("click", function(){
					pageJs.searchBef();
				});
				// --조회
				
				// 등록
				$("#btnWrite").on("click", function(){
					pageJs.dataWrite();
				});
				
				// 상품변경
				$("#sales_prod_name").on("change", function(){
					console.log("상품변경 : " + $("#sales_prod_name").val() );
					console.log("상품변경 : " + $("#sales_prod_name").children("option:selected").text() );
					$("#sales_prod_price").val( $("#sales_prod_name").val() );
				});
				
				// 상품추가
				$("#salesReg").on("click", function(){
					if ( $("#sales_prod_name").val().length == 0 ){
						alert("상품을 선택하세요.");
						return false;
					}
					
					//console.log(" tb info : " + $("#salesRegTb tr").html() );
					var nowtime = new Date();
					var timeId = nowtime.getTime();
					//console.log("time : " + nowtime.getTime() );
					
					var appendTr = "<tr id='"+timeId+"'><td>";
					appendTr += "<label>상품</label>";
					appendTr += "</td>";
					appendTr += "<td>";
					appendTr += "<input id='td_sales_prod_name' name='td_sales_prod_name' class='w3-input' type='text' style='width: 100%' readonly='readonly' value='"+$("#sales_prod_name").children('option:selected').text()+"'>";
					appendTr += "</td>";
					appendTr += "<td width='15%'>";
					appendTr += "<input id='td_sales_prod_price' name='td_sales_prod_price' class='w3-input' type='text' placeholder='가격' style='width: 100%' readonly='readonly' value='"+$("#sales_prod_price").val()+"'>";
					appendTr += "</td>";
					appendTr += "<td>";
					appendTr += "<label>메모</label>";
					appendTr += "</td>";
					appendTr += "<td>";
					appendTr += "<input id='td_sales_filler1' name='td_sales_filler1' class='w3-input' type='text' placeholder='메모' value='"+$("#sales_filler1").val()+"'>";
					appendTr += "</td>";
					appendTr += "<td>";
					appendTr += "<p class='w3-right'>";
					appendTr += "<button class='w3-button w3-circle w3-red' id='salesDel"+timeId+"' name='salesDel"+timeId+"'>-</button>";
					appendTr += "</p>";
					appendTr += "</td></tr>";
					
					$("#salesSum").append(appendTr);
					
					console.log("del gogo : " + "#salesDel"+timeId );
					$("#salesDel"+timeId).on("click", function(){
						console.log("del gogo " );
						$("#"+timeId).remove();
						
						// 총금액 표시
						var salesProdPriceTot = 0;
						$("#salesSum tr").each(function(i){
							salesProdPriceTot += parseInt( $(this).find("#td_sales_prod_price").val() );
						});
						$("#doPoint").text(salesProdPriceTot/10);
						$("#doAmtTot").text(salesProdPriceTot);
					
					});
					
					$("#sales_prod_name").val("");
					$("#sales_prod_price").val("");
					$("#sales_filler1").val("");
					
					// 총금액 표시
					var salesProdPriceTot = 0;
					$("#salesSum tr").each(function(i){
						salesProdPriceTot += parseInt( $(this).find("#td_sales_prod_price").val() );
					});
					$("#doPoint").text(salesProdPriceTot/10);
					$("#doAmtTot").text(salesProdPriceTot);
					
				});
				
				// 스태프 선택
				$("#sales_staff_no").on("change", function(){
					alert("dddd : " + $("#sales_staff_no option:selected").val() );
				});
				
			}
			,searchBef:function(){
				pageJs.pageIndex = 1;
				pageJs.search();
			}
			,search:function(){

	        	$("#regArea").hide();
	        	$("#hisArea").hide();
	        	
				var custNm = $("#where_cust_name").val();
				var custPhone = $("#where_cust_phone").val();

				if ( custNm.length != 0 && custPhone.length == 0 ){	
					if ( custNm.length < 2 ){
						alert("성함은 2자리 이상 입력하세요.");
						$("#where_cust_name").focus();
						return false;
					}
				}
				else if ( custNm.length == 0 && custPhone.length != 0 ){
					if ( custPhone.length < 4 ){
						alert("연락처는 4자리 이상 입력하세요.");
						$("#where_cust_phone").focus();
						return false;
					}
				} 	
				else if ( custNm.length == 0 && custPhone.length == 0 ){
					alert("성함이나 연락처를 입력하세요.");
					return false;
				}
				
				//var inParam = $("#searchForm").serializeArray();
				var inParam = {
					cust_name:custNm
					,cust_phone:custPhone
				};
				
				gl_ajax("./customerList.api"
						, inParam
						, function(result) {

							console.log("성공.");
							
							$("#tbody").html(""); // 초기화
					        
					        if ( result.data.length > 0 ){
					        
						        $.each(result.data, function(index,item){
									var itemList = "<tr>";
									itemList = itemList + "<td><input id='chk"+index+"' name='chk' type='radio' /></td>";
									itemList = itemList + "<td><span>"+item.cust_name+"</span></td>";
									itemList = itemList + "<td><span>"+item.cust_sex+"</span></td>";
									itemList = itemList + "<td><span>"+item.cust_phone1+"</span></td>";
									itemList = itemList + "<td><span>"+item.sales_point_tot+"</span></td>";
									itemList = itemList + "<td><span>"+item.cust_upd_date+"</span></td>";
									itemList = itemList + "</tr>";
										
									console.log(itemList);
									$("#tbody").append(itemList);
									
									$("#tbody tr").find("input[name='chk']").eq(index).on("click", function(){
										pageJs.dataOnce(item);
							        	$("#regArea").show();
							        	$("#hisArea").show();
									});
								
								});// end each
							
					        }
					        else{
					        	
								var itemList = "";
								itemList = itemList + "<tr>";
								itemList = itemList + "<td colspan='99'><span>결과가 없습니다.</span></td>";
								itemList = itemList + "</tr>";
									
								console.log(itemList);
								$("#customerTbody").append(itemList);
								
								//$("#salesRegdiv").hide();
					        }
					        
						// end if
						} 
				);
				
			}
			,dataWrite:function(){

				var cust_id = $("#reg_cust_id").val();
				var prod_name = $("#reg_prod_combo").val();
				var prod_etc = $("#reg_prod_etc").val();
				var card_yn = $('input[name="reg_card_yn"]:checked').val();
				var cash_point = $("#reg_cash_point").val();

				var inParam = {
						"cust_id":cust_id
						,"sales_prod_name":prod_name
						,"sales_etc":prod_etc
						,"sales_card_yn":card_yn
						,"cash_point":cash_point
				};
				gl_ajax("./salesWrite2.api"
						, inParam
						, function(result) {
							console.log("ok");
							alert("salesWrite2");
							//$("#customerOnce").trigger("click");
					        pageJs.salesHisList();
						} 
				);
				
	      		return;
				/* var inParam = {
					"sales_prod_name":$("#sales_prod_name").children("option:selected").text(),
					"sales_prod_price":$("#sales_prod_price").val(),
					"sales_filler1":$("#sales_filler1").val(),
					"sales_staff_no":$("#sales_staff_no").val(),
					"sales_cust_no":no
				}; */
				
				// 총금액 구하기
				var salesProdPriceTot = 0;
				$("#salesSum tr").each(function(i){
					salesProdPriceTot += parseInt( $(this).find("#td_sales_prod_price").val() );
				});
				
				// 포인트 금액 구하기
				var salesPointPlus = 0;
				var salesPointMinus = 0;
				var salesPointTot = 0;
				// 현금일 경우
				
				
				// 배열
				var obj = [];
				$("#salesSum tr").each(function(i){
					console.log( "key. : " + i );
					//console.log( "value. : " + value );
					console.log( "this. : " + $(this).find("#td_sales_prod_name").val() );
					
					obj.push({
						sales_no:no
						,sales_prod_name:$(this).find("#td_sales_prod_name").val()
						,sales_prod_price:$(this).find("#td_sales_prod_price").val()
						,sales_prod_price_tot:salesProdPriceTot
						,sales_point_plus:salesPointPlus
						,sales_point_minus:salesPointMinus
						,sales_point_tot:salesPointTot
						,sales_filler1:$(this).find("#td_sales_filler1").val()
						,sales_staff_no:$("#sales_staff_no option:selected").val()
					});
						
					console.log(".......... list : " + JSON.stringify(obj));
				});
				
				var inParam = {
					obj:JSON.stringify(obj)
				};
				gl_ajax("../sales/salesWrite.api"
						, inParam
						, function(result) {
							console.log("ok");
							$("#customerOnce").trigger("click");
						} 
				);
			
			}
			,dataOnce:function(item){
				console.log("onclick : " + JSON.stringify(item));
				var cust_id = item.cust_id;
				$("#reg_cust_id").val(cust_id);
				
				// 매출이력리스트 조회
				pageJs.salesHisList();
			}
			,salesHisList:function(){

				// 매출이력, 상품리스트
				var inParam = {
					"cust_id":$("#reg_cust_id").val()
				};
				gl_ajax("./salesHisList.api"
						, inParam
						, function(result) {

							$("#tbodyHis").html(""); // 초기화
					        
					        if ( result.data.length > 0 ){

								console.log("data : " + JSON.stringify(result));
						        $.each(result.data, function(index,item){
									var itemList = "<tr>";
									itemList = itemList + "<td><span>"+item.sales_ymd+"</span></td>";
									itemList = itemList + "<td><span>"+item.sales_no+"</span></td>";
									itemList = itemList + "<td><span id='rows'>"+item.sales_prod_name+"</span></td>";
									itemList = itemList + "<td><span>"+item.sales_prod_price+"</span></td>";
									itemList = itemList + "<td><span>"+item.sales_card_yn+"</span></td>";
									itemList = itemList + "<td><span>"+item.sales_etc+"</span></td>";
									itemList = itemList + "</tr>";
										
									$("#tbodyHis").append(itemList);
									
									$("#tbodyHis tr").find("#rows").eq(index).on("click", function(){
										console.log("클릭시 : " + JSON.stringify(item));
							        	$("#updArea").show();
									});
								
								});// end each
							
					        }
					        else{
					        	
								var itemList = "";
								itemList = itemList + "<tr>";
								itemList = itemList + "<td colspan='99'><span>첫 손님입니다.</span></td>";
								itemList = itemList + "</tr>";
									
								console.log(itemList);
								$("#tbodyHis").append(itemList);
								
					        }
							
					        pageJs.prodSearch();
						} 
				);
				
			}
			,prodSearch:function(){

				// 매출이력, 상품리스트
				var inParam = {
					"cust_id":$("#reg_cust_id").val()
				};
				gl_ajax("./prodSearchList.api"
						, inParam
						, function(result) {

							$("#reg_prod_combo").html(""); // 초기화
					        var rowCnt = result.prodData.length;
					        
					        if ( rowCnt > 0 ){

								var itemList = "";
						        $.each(result.prodData, function(index,item){
									itemList += "<option value='"+item.prod_name+"'>"+item.prod_name+"["+item.prod_price+"]</option>";
								});// end each
								
								$("#reg_prod_combo").html(itemList);
							
					        }

					        
						} 
				);
				
			}
			,dataUpd:function(){
				
			}
			,dataDel:function(){
				
			}
			,pageMove:function(idx){
				pageJs.pageIndex = idx;
				pageJs.search();
			}
			,excelDown:function(pfileNm){
				
			}
	}



</script>

 

<div id="content" style="padding-bottom: 30px;">
	
	<!-- title -->
	<div class="subTitle" >
		<h3>&nbsp;매출관리</h3>
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
		      	<th class="formLabel" >성함</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_cust_name" name="where_cust_name" class="formInput" />
		      	</td>
		      	
		      	<th class="formLabel" >연락처</th>
		      	<td style="width: 30%;">
		      		<input type="text" id="where_cust_phone" name="where_cust_phone" class="formInput" />
		      	</td>
			  </tr>
			  
		  </thead>
		</table>
	</div>
	<!-- //조회 -->
	
	<!-- 상단버튼 -->	
	<div class="formBtnArea" >
		<button class="formBtn" id="btnRetrive" >조회</button>
	</div>
	<!-- //상단버튼 -->	
	
	<!-- 리스트 -->	
	<div class="tableDiv" >
	
		<table class="table">
		  	<thead>
		  	  	<tr class="tableHeaderTr">
			      	<th width="10%" class="tableHeaderLeft">선택</th>
			      	<th width="10%" class="tableHeaderLeft">성함</th>
			      	<th width="10%" class="tableHeaderLeft">남여</th>
			      	<th width="*" class="tableHeaderLeft">연락처</th>
			      	<th width="20%" class="tableHeaderLeft">누적포인트</th>
			      	<th width="20%" class="tableHeaderLeft">가입일</th>
	    	  	</tr>
		  	</thead>
		  	<tbody id="tbody" class=""></tbody>
		</table>
		
	</div>
	<!-- //리스트 -->
	
	
	<!-- 등록 -->	
	<div id="regArea" style="display: none;">
	
		<div class="subTitle" >
			<h3>&nbsp;등록</h3>
		</div>
			  
		<div class="formArea" >
      		<input type="text" id="reg_cust_id" name="reg_cust_id" class="" />
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
			      			<select id="reg_prod_combo" name="reg_prod_combo" class="">
						    </select>
			      		</td>
			      	
			      		<th class="formLabel" >비고</th>
			      		<td style="width: 30%;">
				      		<input type="text" id="reg_prod_etc" name="reg_prod_etc" class="formInput" />
			      		</td>
				  </tr>
				  
			  	  <tr>
			      		<th class="formLabel" >결재구분</th>
			      		<td style="width: 30%;">
							<input class='' type='radio' id='reg_card_yn0' name='reg_card_yn' value='Y' checked>
							<label> 카드</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class='' type='radio' id='reg_card_yn1' name='reg_card_yn' value='N'>
							<label> 현금</label>
			      		</td>
			      	
			      		<th class="formLabel" >현금시 적립금</th>
			      		<td style="width: 30%;">
				      		<input type="text" id="reg_cash_point" name="reg_cash_point" class="formInput" />
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
	
	<!-- 매출이력 -->
	<div id="hisArea" style="display: none;">
		<!-- title -->
		<div class="subTitle" >
			<h3>&nbsp;매출이력</h3>
		</div>
		<!-- //title -->
		
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
			  	<tbody id="tbodyHis" class=""></tbody>
			</table>
			
		</div>
		<!-- //리스트 -->
		
		<!-- paging -->
		<div class="paging" id="paging" ></div>
		<!-- //paging -->
	</div>
	<!-- //매출이력 -->
	
	
	
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
	
	
	
	
	
	
	
	
	
	
	
	<!-- 손님선택
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
		  	<div class="" >
				<div class="w3-panel w3-leftbar w3-border-green">
					<div class="sub_caption w3-right"> 
				  		<table style="font-size: small;">
				  			<tr>
				  				<td align="right" width="5%">
									<label>성함</label> 
				  				</td>
				  				
				  				<td>
									<input class="w3-input" type="text" id="cust_name" name="cust_name"  > 
				  				</td>
				  				
				  				<td align="right" width="10%">
									<label>연락처</label> 
				  				</td>
				  				
				  				<td>
									<input class="w3-input" type="text" id="cust_phone1" name="cust_phone1"  >
				  				</td>
				  				<td>
									<div class="w3-right">
										<button class="w3-button w3-green w3-round" id="customerOnce">검색</button>
									</div>
				  				</td>
				  			</tr>
				  		</table>
				    </div>
					<h2 class="sub_title">손님선택</h2>
				</div>
			  
				<table class="w3-table-all w3-hoverable" style="width: 100%;">
				  <thead>
				  	  <tr class="w3-light-blue list_title">
				  	  <th></th>
				      <th>NO</th>
				      <th>성함</th>
				      <th>남여</th>
				      <th>연락처</th>
				      <th>누적포인트</th>
				      <th>가입일</th>
				      <th>매출등록</th>
				    </tr>
				  </thead>
				  <tbody id="customerTbody" class="list_content">
				  </tbody>
				</table>
			  
			</div>
		</div>
		
	</div>
	 //손님선택 -->
	
	<!-- 매출등록
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">매출등록</h2>
			</div>
			<p id="salesRegTit" class="sub_caption" style="color: blue;"></p>          
		  
			  <div id="salesRegdiv" class="w3-container w3-card-4">
			    
					<div class="w3-row-padding">
						<table id="salesRegTb" style="width: 100%;font-size: small;">
							<tr>
								<td>
								    <label>상품</label>
								</td>
								
								<td >
								    <select id="sales_prod_name" name="sales_prod_name" style="width: 100%;" class="w3-select">
								    </select>
								</td>
								
								<td width="15%">
						    		<input id="sales_prod_price" name="sales_prod_price" class="w3-input" type="text" placeholder="가격" 
						    		style="width: 100%" readonly="readonly">
								</td>
								
								<td>
						    		<label>메모</label>
								</td>
								
								<td >
						    		<input id="sales_filler1" name="sales_filler1" class="w3-input" type="text" placeholder="메모">
								</td>
								<td >
									<p class="w3-right">
										<button class="w3-button w3-circle w3-blue" id="salesReg" name="salesReg">+</button>
									</p>
								</td>
							</tr>
							
						</table>
					</div>
				</div>
						<br>
						
			  <div id="salesRegdiv" class="w3-container w3-card-4">
					<div class="w3-row-padding">
					
						<table id="salesSum" style="width: 100%;font-size: small;">
						</table>
						
						<table style="width: 100%;font-size: small;">
							
							<tr>
								<td width="30%">
								</td>
								<td width="30%">
								</td>
								
								<td>
						    		<label>담당</label>
								</td>
								
								<td>
								    <select id="sales_staff_no" name="sales_staff_no" style="width: 100%;" class="w3-select">
								    </select>
								</td>
								
								<td width="15%" align="right">
									<p class="w3-right">
										<button class="w3-button w3-green w3-round" id="goWrite">등록</button>
									</p>
								</td>
							</tr>
						</table>
							
						<table style="width: 100%;font-size: small;">
							<tr>
								<td align="left">
									<input class='w3-radio' type='radio' id='doPoint0' name='doPoint' value='Y' checked>
									<label>카드</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input class='w3-radio' type='radio' id='doPoint1' name='doPoint' value='N'>
									<label>현금(예상 적립금 : </label>
									<span id="doPoint">0</span>원
									<label>)</label>
								</td>
								
								<td align="right" >
									<span>사용 가능 포인트(</span>
									<span id="maxPoint">0</span>
									<span>)  / </span>
								</td>
								<td align="left" width="15%">
									<input id="usePoint" name="usePoint" class="w3-input" type="text" placeholder="사용 할 포인트" />
								</td>
								
								<td width="25%">
									<span>총 결재금액 :</span><span id="doAmtTot" style="color: red;">0</span>원
								</td>
							</tr>
							
						</table>
						
					</div>
					
			
			  </div>
		  
		</div>
		
	</div>
	//매출등록 -->
	
	<!-- 매출이력
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<div>
				<div class="w3-panel w3-leftbar w3-border-green">
					<div class="sub_caption w3-right">	
						<select id="defaultLine" name="defaultLine" class="w3-select">
							<option value="5" >5줄 표시</option>
							<option value="10" selected>10줄 표시</option>
			    		</select>
				    </div>
					<h2 class="sub_title">매출이력</h2>
				</div>
			  
				<table class="w3-table-all w3-hoverable">
				  <thead>
				  	  <tr class="w3-light-blue list_title">
				      <th>NO</th>
				      <th>상품</th>
				      <th>단품금액</th>
				      <th>총금액</th>
				      <th>포인트+</th>
				      <th>포인트-</th>
				      <th>포인트합</th>
				      <th>최종방문일</th>
				      <th>메모</th>
				    </tr>
				  </thead>
				  <tbody id="tbody" class="list_content">
				  </tbody>
				</table>
			</div>
		  
		</div>
		
	</div>
	//매출이력 -->	

</div>
