<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
var selBusiNo = 0;
$(function(){
	
	//$("#busi_reg").hide();
	//$("#staff_reg").hide();
	
	// 뷰
	$("#busiRegView").on("click", function(){
		$("#busi_reg").toggle();
	});
	
	$("#staffRegView").on("click", function(){
		$("#staff_reg").toggle();
	});
	
	var inParam = {};
	var outParam = {};
	gl_ajax("./businessList.api", inParam, function(outParam) {businessListCallBack(outParam);} );
	
	// 사업장등록
	$("#busiReg").on("click", function(){
	
		if ( $("#busi_name").val().length == 0 ){
			alert("사업장명은 필수입니다.");
			$("#busi_name").focus();
			return false;
		}
		
		if ( $("#busi_phone1").val().length == 0 ){
			alert("사업장 연락처는 필수입니다.");
			$("#busi_phone1").focus();
			return false;
		}
		
		var inParam = {
			"busi_no":selBusiNo,
			"busi_name":$("#busi_name").val(),
			"busi_phone1":$("#busi_phone1").val()
		};
		var outParam = {};
		gl_ajax("./businessWrite.api", inParam, function(outParam) {businessWriteCallBack(outParam);} );
		
	});
	
	// staff 등록
	$("#staffReg").click(function(){
	
		if ( selBusiNo == 0 ){
			alert("사업장을 선택하세요.");
			return false;
		}
		
		if ( $("#staff_name").val().length == 0 ){
			alert("staff 성함은 필수입니다.");
			$("#staff_name").focus();
			return false;
		}
		
		if ( $("#staff_phone1").val().length == 0 ){
			alert("staff 연락처는 필수입니다.");
			$("#staff_phone1").focus();
			return false;
		}
		
		var inParam = {
				"staff_name":$("#staff_name").val(),
				"staff_phone1":$("#staff_phone1").val(),
				"staff_memo":$("#staff_memo").val(),
				"staff_useyn":"N",
				"staff_busi":selBusiNo
			};
		var outParam = {};
		gl_ajax("../staff/staffWrite.api", inParam, function(outParam) {staffWriteCallBack(outParam);} );
		
	});
	
});
	
// staff조회
function staffRetrive(selBusiNo){

	var inParam = {
		"busi_no":selBusiNo
	};
	var outParam = {};
	gl_ajax("../staff/staffList.api", inParam, function(outParam) {staffListCallBack(outParam);} );
		
}

function staffListCallBack(result){
	
	$("#staffTbody").html(""); // 초기화
	
    $.each(result.data, function(index,item){
		
		var itemList = "<tr>";
		itemList += "<td><span>"+item.staff_no+"</span></td>";
		itemList += "<td><span>"+item.staff_name+"</span></td>";
		itemList += "<td><span>"+item.staff_phone1+"</span></td>";
		itemList += "<td><span>"+item.staff_memo+"</span></td>";
		itemList += "<td><span>";
			itemList += "<input class='w3-radio' type='radio' id='staff_useyn0"+item.staff_no+"' name='staff_useyn"+item.staff_no+"' value='Y'>";
			itemList += "<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			itemList += "<input class='w3-radio' type='radio' id='staff_useyn1"+item.staff_no+"' name='staff_useyn"+item.staff_no+"' value='N'>";
			itemList += "<label> N</label>";
		itemList += "</span></td>";
		itemList += "</tr>";
			
		console.log(itemList);
		$("#staffTbody").append(itemList);
		
		if ( item.staff_useyn == 'Y' ){
			$("#staff_useyn0"+item.staff_no).prop("checked", true);
		}
		else{
			$("#staff_useyn1"+item.staff_no).prop("checked", true);
		}
						
		$("#staffTbody tr").eq(index).on("click", function(){
			console.log("클릭시 : " + JSON.stringify(item));
			
			// staff정보
			$("#staff_name").val(item.staff_name);
			$("#staff_phone1").val(item.staff_phone1);
			$("#staff_memo").val(item.staff_memo);
			$("#staff_useyn").val(item.staff_useyn);	
			$("#staff_no").val(item.staff_no);
				
		});
		
	});
	
}

function businessListCallBack(result){
	console.log("ok : " + JSON.stringify(result));
	
		console.log("조회 성공");
		$("#tbody").html(""); // 초기화
		
        $.each(result.data, function(index,item){
			var itemList = "";
			itemList = itemList + "<tr style='text-align: left; vertical-align: middle;''>";
			itemList = itemList + "<td><span><input type='checkbox' id='chk'/></span></td>";
			itemList = itemList + "<td><span>"+item.busi_no+"</span></td>";
			itemList = itemList + "<td><span>"+item.busi_name+"</span></td>";
			itemList = itemList + "<td><span>"+item.busi_phone1+"</span></td>";
			itemList = itemList + "<td><span>"+item.busi_upd_date+"</span></td>";
			itemList = itemList + "<td><span><button id='rowSel'>선택</button></span></td>";
			itemList = itemList + "</tr>";
				
			$("#tbody").append(itemList);
			
			$("#tbody tr").eq(index).on("click", function(){
				console.log("클릭시 : " + JSON.stringify(item.busi_id));
				
				// staff조회
				//selBusiNo = item.busi_no;
				staffRetrive(item.busi_id);				
				
				// 사업장정보
				//$("#busi_name").val(item.busi_name);
				//$("#busi_phone1").val(item.busi_phone1);	
						
			});
			
		});// end each
		
		if ( result.data.length > 0 ){
			$("#tbody tr").eq(0).trigger("click");
		}
		
	
}	

function staffWriteCallBack(result){
	console.log("ok : " + JSON.stringify(result));
		
	// form 초기화
	$("#staff_name").val("");
	$("#staff_phone1").val("");
	$("#staff_memo").val("");
	$("#staff_no").val("");
	$("#staff_useyn").val("");
	
	// staff조회
	staffRetrive(selBusiNo);
}

function businessWriteCallBack(result){
	console.log("ok");
	$("#busi_name").val();
	$("#busi_phone1").val();
	alert("등록되었습니다");
	//$("#busiList").trigger("click");
	location.href = "/business/businessListView.api";
}
</script>

 

<div id="content" style="padding-bottom: 30px;">

	<!-- title -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container">
			<p class="w3-left">
				<h3>사업장관리</h3>
			</p>
			<hr>
		</div>
	</div>
	<!-- //title -->
	
	<!-- 사업장목록 -->	
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
			
			<!-- sub title -->
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">사업장목록</h2>
			</div>
			<!-- //sub title -->    
	  
	  		<!-- content -->
	    	<p class="sub_caption"><!-- Hello W3.CSS Layout.--></p>
 					<table class="w3-table-all w3-hoverable" style="width:100%;">
			  		<thead>
			  	  		<tr class="w3-light-blue list_title">
			      			<th></th>
			      			<th>NO</th>
			      			<th>사업장</th>
			      			<th>연락처</th>
			      			<th>수정일</th>
			      			<th>상태</th>
			    		</tr>
			  		</thead>
			  		<tbody id="tbody" class="list_content">
			  		</tbody>
				</table>
	    	<p class="sub_caption"><!-- Hello W3.CSS Layout.--></p>
	  		<!-- //content -->
	  
		</div>
	</div>
	<!-- //사업장목록 -->	
	
	<!-- 사업장등록 >
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container">
	
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">사업장등록</h2>
			</div>
			<p class="sub_caption">[사업장 등록 및 변경이 가능합니다.]</p>          
			  
		  	<div id="busi_reg" class="w3-container w3-card-4" >
					<table style="width:100%;font-size: small;">
						<tr>
							<td>
								<p>
									<label><font color="red">*</font>사업장명</label> 
								</p>
							</td>
							<td>
								<p>
									<input class="w3-input" type="text" id="busi_name" name="busi_name" required placeholder="운영하는 사업장명 입력"> 
								</p>
							</td>
							<td>
								<p>
									<label><font color="red">*</font>연락처1</label> 
								</p>
							</td>
							<td>
								<p>
									<input class="w3-input" type="text" id="busi_phone1" name="busi_phone1" required 
									maxlength="11" placeholder="예. 01012345678"> 
								</p>
							</td>
							<td>
								<p class="w3-right">
									<button type="button" id="busiReg" class="w3-button w3-green w3-margin-top w3-round">등록</button>
								</p>
							</td>
						</tr>
						
					</table>
					
			</div>
			
		</div>
	</div>
	< 사업장등록// -->
		
	<div class="w3-content w3-container w3-margin-top">
		<hr>
	</div>
			
	<!-- 서브타이틀 -->
	<div class="w3-content w3-container">
		<div class="w3-container ">
			<!-- sub title -->
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">staff목록</h2>
			</div>
			<!-- //sub title -->
		</div>
		
	</div>
	<!-- //서브타이틀 -->
	
	<!-- 조회조건 -->
	<div class="w3-content w3-container">
		<div class="w3-container ">
		  
			<!-- content -->			  
			<table class="w3-table-all w3-hoverable">
				<colgroup>
					<col style="width:130px;">
					<col>
					<col style="width:130px;">
					<col>
				</colgroup>
			  <thead>
			  	  <tr>
			      	<th class="w3-light-blue list_title" style="text-align: left; vertical-align: middle;">NO</th>
			      	<td>
			      		<input type="text" id="input1" name="input1" >
			      	</td>
			      	<th class="w3-light-blue list_title" style="text-align: left; vertical-align: middle;">성함</th>
			      	<td>
			      		<input type="text" id="input2" name="input2" >
			      	</td>
				  </tr>
			  </thead>
			</table>
			<!-- //content -->
		    
		</div>
		  
	</div>
	<!-- //조회조건 -->
	
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
	
	<!-- staff목록 -->
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container ">
	
			<!-- content -->			  
			<table class="w3-table-all w3-hoverable">
			  <thead>
			  	  <tr class="w3-light-blue list_title">
			      <th>NO</th>
			      <th>성함</th>
			      <th>연락처</th>
			      <th>메모</th>
			      <th>퇴사여부</th>
			    </tr>
			  </thead>
			  <tbody id="staffTbody" class="list_content">
			  </tbody>
			</table>
			<!-- //content -->
				
		    <p><!-- Hello W3.CSS Layout.--></p>
		    
		</div>
		  
		<!-- paging -->
		<div class="w3-center">
			<!-- p>Add a w3-rounded class to round the borders:</p>
			<div class="w3-bar w3-border w3-round"-->
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
	<!-- staff목록 -->
		
	<!-- staff등록 >
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container">
	
			<div class="w3-panel w3-leftbar w3-border-green">
				<h2 class="sub_title">staff등록</h2>
			</div>
			<p class="sub_caption">[staff 등록 및 변경이 가능합니다.]</p>          
			  
		  	<div id="staff_reg" class="w3-container w3-card-4" >
					<table style="width:100%;font-size: small;">
						<tr>
							<td width="5%">
								<p>
									<label>성함</label> 
								</p>
							</td>
							<td >
								<p>
									<input class="w3-input" type="hidden" id="staff_no" name="staff_no" required> 
									<input class="w3-input" type="text" id="staff_name" name="staff_name" required>  
								</p>
							</td>
							
							<td width="8%">
								<p>
									<label>연락처</label> 
								</p>
							</td>
							<td>
								<p>
									<input class="w3-input" type="text" id="staff_phone1" name="staff_phone1" required
									maxlength="11"> 
								</p>
							</td>
							
							<td width="5%">
								<p>
									<label>메모</label> 
								</p>
							</td>
							<td>
								<p>
									<input class="w3-input" type="text" id="staff_memo" name="staff_memo" > 
								</p>
							</td>
							
							<td>
								<p class="w3-right">
									<button class="w3-button w3-green w3-round" id="staffReg">등록</button>
								</p>
							</td>
						</tr>
						
					</table>
					
			</div>
			
		</div>
	</div>
	< staff등록// -->
<p>

</div>
