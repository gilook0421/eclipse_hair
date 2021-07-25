<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
	
		//$("#salesRegdiv").hide();
		
		// 상품리스트
		//gl_ajaxCode("product", "sales_prod_name");
		// 스태프리스트
		//gl_ajaxCode("staff", "sales_staff_no");  
		
		// 손님 검색
		$("#customerOnce").click(function(){

			if ( $("#cust_name").val().length != 0 && $("#cust_phone1").val().length == 0 ){	
				if ( $("#cust_name").val().length < 2 ){
					alert("성함은 2자리 이상 입력하세요.");
					$("#cust_name").focus();
					return false;
				}
			}
			else if ( $("#cust_name").val().length == 0 && $("#cust_phone1").val().length != 0 ){
				if ( $("#cust_phone1").val().length < 4 ){
					alert("연락처는 4자리 이상 입력하세요.");
					$("#cust_phone1").focus();
					return false;
				}
			} 	
			else if ( $("#cust_name").val().length == 0 && $("#cust_phone1").val().length == 0 ){
				alert("성함이나 연락처를 입력하세요.");
				return false;
			}
			
			//var inParam = $("#searchForm").serializeArray();
			var inParam = {
				cust_name:$("#cust_name").val(),
				cust_phone1:$("#cust_phone1").val()
			};
			var outParam = {};
			gl_ajax("./customerOnce.api", inParam, function(outParam) {customerOnceCallBack(outParam);} );
			
		});
		
		// 등록
		$("#goWrite").click(function(){

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
			var outParam = {};
			gl_ajax("../sales/salesWrite.api", inParam, function(outParam) {salesWriteCallBack(outParam);} );
		
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
		
	})
	
	

function customerOnceCallBack(result){

		console.log("성공.");
		
		$("#customerTbody").html(""); // 초기화
        
        if ( result.data.length > 0 ){
        
	        $.each(result.data, function(index,item){
				var itemList = "<tr>";
				itemList = itemList + "<td><input type='checkbox' /></td>";
				itemList = itemList + "<td><span>"+item.cust_no+"</span></td>";
				itemList = itemList + "<td><span>"+item.cust_name+"</span></td>";
				itemList = itemList + "<td><span>"+item.cust_sex+"</span></td>";
				itemList = itemList + "<td><span>"+item.cust_phone1+"</span></td>";
				itemList = itemList + "<td><span>"+item.sales_point_tot+"</span></td>";
				itemList = itemList + "<td><span>"+item.cust_upd_date+"</span></td>";
				itemList = itemList + "<td><span><button id='rowDel'>매출등록</button></span></td>";
				itemList = itemList + "</tr>";
					
				console.log(itemList);
				$("#customerTbody").append(itemList);
				
				$("#customerTbody tr").find("#rowDel").eq(index).on("click", function(){
					console.log("클릭시 : " + JSON.stringify(item));
					customerOnceOnClick(item);
				});
			
			});// end each
		
        }
        else{
        
			var itemList = "";
			itemList = itemList + "<tr>";
			itemList = itemList + "<td colspan='8'><span>결과가 없습니다.</span></td>";
			itemList = itemList + "</tr>";
				
			console.log(itemList);
			$("#customerTbody").append(itemList);
			
			//$("#salesRegdiv").hide();
        }
        
	// end if
	
}	

var no = "";
var name = "";
var phone = "";
var price = "";
function customerOnceOnClick(result){
	console.log("onclick : " + result);
	console.log("onclick : " + JSON.stringify(result));
	no = result.cust_no;
	name = result.cust_name;
	phone = result.cust_phone1;
	price = result.cust_phone1;
	
	$("#salesRegdiv").show();
	$("#salesRegTit").text(name + " / " + phone);
	
	// 손님 매출이력
	var inParam = {
		"sales_cust_no":no
	};
	var outParam = {};
	gl_ajax("./salesList.api", inParam, function(outParam) {salesListCallBack(outParam);} );
	

}

function salesListCallBack(result){

		$("#tbody").html(""); // 초기화
        var rowCnt = result.data.length;
        
        if ( rowCnt > 0 ){
        
	        $.each(result.data, function(index,item){
				var itemList = "";
				itemList = itemList + "<tr>";
				itemList += "<td><span>"+item.sales_no+"</span></td>";
				itemList += "<td><span>"+item.sales_prod_name+"</span></td>";
				itemList += "<td><span>"+item.sales_prod_price+"</span></td>";
				itemList += "<td><span>"+item.sales_prod_price_tot+"</span></td>";
				itemList += "<td><span>"+item.sales_point_plus+"</span></td>";
				itemList += "<td><span>"+item.sales_point_minus+"</span></td>";
				itemList += "<td><span>"+item.sales_point_tot+"</span></td>";
				itemList += "<td><span>"+item.sales_upd_date+"</span></td>";
				itemList += "<td><span>"+item.sales_filler1+"</span></td>";
				itemList = itemList + "</tr>";
					
				$("#tbody").append(itemList);
			
			});// end each
		
        }
        else{
        
			var itemList = "";
			itemList = itemList + "<tr>";
			itemList = itemList + "<td colspan='9'><span>첫 방문입니다.</span></td>";
			itemList = itemList + "</tr>";
				
			$("#tbody").append(itemList);
        }
        
	// end if
	
	
	
}

function salesWriteCallBack(result){
	console.log("ok");
	$("#customerOnce").trigger("click");
</script>

 

<div id="content" style="padding-bottom: 30px;">
	
	<!-- title -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container">
			<p class="w3-left">
				<h3>매출관리</h3>
			</p>
			<hr>
		</div>
	</div>
	<!-- //title -->
	
	<!-- 손님선택 -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<!-- sub title -->
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
				<!-- p class="sub_caption">The .table class adds basic styling (light padding and only horizontal dividers) to a table:</p-->          
			  
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
			<!-- //sub title -->
		</div>
		
	</div>
	<!-- //손님선택 -->
	
	<!-- 매출등록 -->	
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<!-- sub title -->
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
	<!-- //매출등록 -->
	
	<!-- 매출이력 -->	
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<!-- sub title -->
			<div>
				<div class="w3-panel w3-leftbar w3-border-green">
					<div class="sub_caption w3-right"><!-- Hello W3.CSS Layout.-->	
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
			<!-- //sub title -->
		  
		</div>
		
	</div>
	<!-- //매출이력 -->	

</div>
