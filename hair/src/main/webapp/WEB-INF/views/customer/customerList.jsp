<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function(){

	//$("#custRegView").hide();
	
	var inParam = {};
	var outParam = {};
	gl_ajax("./customerList.api", inParam, function(outParam) {customerListCallBack(outParam);} );
	
	// 등록
	$("#goWrite").click(function(){

		// 성함
		if ($("#cust_name").val().length < 2) {
			alert("성명은 2자 이상으로 설정해야 합니다.");
			$("#cust_name").val("").focus();
			return false;
		}
		// 성함
		if($.trim($("#cust_name").val()) !== $("#cust_name").val()){
			alert("성명은 공백 입력이 불가능합니다.");
			return false;
		}
		
		// 연락처
		if ($("#cust_phone1").val().length < 10) {
			alert("연락처는 10자 이상으로 설정해야 합니다.");
			$("#cust_phone1").val("").focus();
			return false;
		}
		// 연락처
		if($.trim($("#cust_phone1").val()) !== $("#cust_phone1").val()){
			alert("연락처는 공백입력이 불가능합니다.");
			return false;
		}
		
		//var inParam = $("#joinForm").serializeArray();
		var sex = "M";
		if ( $("#cust_sex1").is(":checked") ){
			sex = "F";
		}
		
		var inParam = {
			cust_name:$("#cust_name").val(),
			cust_phone1:$("#cust_phone1").val(),
			cust_sex:sex
		};
		
		var outParam = {};
		gl_ajax("./customerWrite.api", inParam, function(outParam) {customerWriteCallBack(outParam);} );
		
	});
	
	
})
	
function customerListCallBack(result){
	console.log("ok : " + JSON.stringify(result));

		console.log("조회 성공");
		
		$("#tbody").html(""); 
        var parseData = JSON.parse(JSON.stringify(result));
        $.each(result.data, function(index,item){
		var itemList = "";
		itemList += "<tr>";
		itemList += "<td><span id='td_cust_no'>"+item.cust_no+"</span></td>";
		itemList += "<td><span id='td_cust_name'>"+item.cust_name+"</span></td>";
		itemList += "<td><span id='td_cust_sex'>"+item.cust_sex+"</span></td>";
		itemList += "<td><span id='td_cust_phone1'>"+item.cust_phone1+"</span></td>";
		itemList += "<td><span id='td_cust_upd_date'>"+item.cust_upd_date+"</span></td>";
		itemList += "<td><span><button id='rowDel'>삭제</button>&nbsp;&nbsp;<button id='rowUpd'>변경</button></span></td>";
		itemList += "</tr>";
		
		$("#tbody").append(itemList);
		
		$("#tbody tr").find("#rowDel").eq(index).on("click", function(){
			console.log("삭제클릭시 : " + JSON.stringify(item));
		});
		
		$("#tbody tr").find("#rowUpd").eq(index).on("click", function(){
			console.log("정보변경 : " + JSON.stringify(item));
		});
		
	});// end each
	//$("#tbody").html($tbodyList); 
}

function customerWriteCallBack(result){
	console.log("ok");
	location.href = "./customerListView.api";
}
</script>

 

<div id="content" style="padding-bottom: 30px;">
	
	<!-- title -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container">
			<p class="w3-left">
				<h3>손님관리</h3>
			<hr>
		</div>
	</div>
	<!-- //title -->
		
	<!-- 상단버튼 -->	
	<div class="w3-content w3-container">
		<div class="w3-container">
		
			<!-- sub title -->
				<div class="w3-panel w3-border-green">
					<div class="sub_caption w3-right"><!-- Hello W3.CSS Layout.-->	
						<button class="w3-button w3-green w3-round" id="goWrite">조회</button>
						<button class="w3-button w3-green w3-round" id="goWrite">글쓰기</button>
				    </div>
				</div>     
				<!--p class="sub_caption">[회원구분없는 문의게시판입니다.]</p-->
		
		</div>
	</div>
	<!-- //상단버튼 -->	
	
	<!-- 손님명단 -->	
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<!-- sub title -->
		  	<div class="" >
				<div class="w3-panel w3-leftbar w3-border-green">
					<div class="sub_caption w3-right"><!-- Hello W3.CSS Layout.-->	
						<select id="defaultLine" name="defaultLine" class="w3-select">
							<option value="5">5줄 표시</option>
							<option value="10" selected>10줄 표시</option>
			    		</select>
				    </div>
					<h2 class="sub_title">손님명단</h2>
				</div>
				
			    
 				<table class="w3-table-all w3-hoverable">
				  <thead>
				  	  <tr class="w3-light-blue list_title">
				      <th>NO</th>
				      <th>성함</th>
				      <th>남여</th>
				      <th>연락처</th>
				      <th>가입일</th>
				      <th>상태변경</th>
				    </tr>
				  </thead>
				  <tbody id="tbody" class="list_content">
				  </tbody>
				</table>
			    <p class="sub_caption"><!-- Hello W3.CSS Layout.--></p>
			  </div>
		  
		</div>
		
		<!-- paging -->
		<div class="w3-center">
		<!-- p>Add a w3-rounded class to round the borders:</p-->
			<div class="w3-bar w3-round">
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
	<!-- //손님명단 -->	
	
	<!-- 손님등록 >	
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
		
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">손님등록</h2>
			</div>
			<p class="sub_caption">The .table class adds basic styling (light padding and only horizontal dividers) to a table:</p>          
		  
			  <div id="custRegView" class="w3-container w3-card-4">
			    
					<div class="w3-row-padding">
						<table style="width: 100%; font-size: small;">
							<tr>
								<td align="right" style="width:8%;">
									<p>
					   					<label>성함</label>
					   				</p>
								</td>
								<td style="width:22%;">
									<p>
					    				<input id="cust_name" name="cust_name" class="w3-input" type="text" placeholder="성함">
					   				</p>
								</td>
								<td align="right" style="width:8%;">
									<p>
					  					<label>연락처</label>&nbsp;
					   				</p> 
								</td>
								<td style="width:22%;">
									<p>
					    				<input id="cust_phone1" name="cust_phone1" class="w3-input" type="text" 
					    				placeholder="연락처" maxlength="11">
					   				</p>
								</td>
								<td align="right" style="width:8%;">
									<p>
					  					<label>남여</label>&nbsp; 
					   				</p>
								</td>
								<td >
									<p>
									  	<input class="w3-radio" type="radio" id="cust_sex0" name="cust_sex" value="M" checked>
									  	<label>Male</label>&nbsp;&nbsp;&nbsp;
									  	<input class="w3-radio" type="radio" id="cust_sex1" name="cust_sex" value="F">
									  	<label>Female</label> 
					   				</p>
								</td>
								<td>
									<p class="w3-right">
										<button class="w3-button w3-green w3-round" id="goWrite">등록</button>
									</p>
								</td>
							</tr>
					  </table>
					</div>
					
			  </div>
		  
		</div>
		
	</div>
	//손님등록 -->
	
</div>

