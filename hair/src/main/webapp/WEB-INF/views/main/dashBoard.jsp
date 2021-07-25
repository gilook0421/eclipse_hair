<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
	
		//$("#btnRetrive").trigger("click");
		
		// 조회
		$("#btnRetrive").on("click", function(){

			var inParam = {};
			var outParam = {};
			gl_ajax("./productList.api", inParam, function(outParam) {productListCallBack(outParam);} );
			
		});
		// --조회
		
	});
	
	// 조회 callBack
	function productListCallBack(result){
	
		$("#tbody").html("");
		
			
               if ( result.data.length > 0 ){
               	
	               $.each(result.data, function(index, item){
						var itemList = "<tr style='border: 1px solid grey;'>";
						itemList += "<td><span style='color: #ccc;'>"+item.prod_no+"</span></td>";
						itemList += "<td><span style='color: #ccc;'>"+item.prod_name+"</span></td>";
						itemList += "<td><span style='color: #ccc;'>"+item.prod_price+"</span></td>";
						itemList += "<td><span style='color: #ccc;'>";
							itemList += "<input class='w3-radio' type='radio' id='prod_use_yn0"+item.prod_no+"' name='prod_use_yn"+item.prod_no+"' value='Y'>";
							itemList += "<label> Y</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							itemList += "<input class='w3-radio' type='radio' id='prod_use_yn1"+item.prod_no+"' name='prod_use_yn"+item.prod_no+"' value='N'>";
							itemList += "<label> N</label>";
						itemList += "</span></td>";
						itemList += "<td><span style='color: #ccc;'><button id='rowDel'>삭제</button></span></td>";
						itemList += "</tr>";
						
						$("#tbody").append(itemList);
						
						if ( item.prod_use_yn == 'Y' ){
							$("#prod_use_yn0"+item.prod_no).prop("checked", true);
						}
						else{
							$("#prod_use_yn1"+item.prod_no).prop("checked", true);
						}
						
						$("#tbody tr").find("#rowDel").eq(index).on("click", function(){
							console.log("삭제 클릭시 : " + JSON.stringify(item));
						});// end click
						
					});// end each
					
               }
               else{
               
					var itemList = "<tr>";
					itemList += "<td colspan='5'><span>결과가 없습니다.</span></td>";
					itemList += "</tr>";
					
					$("#tbody").append(itemList);
					
               }
			
	}
	// --조회 callBack
	
</script>


<div id="content" style="padding-bottom: 30px;">

	<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;border: 1px solid yellow;
    width: 48%;
    float: left;height: 350px;">
		<h3>area1</h3>
	</div>
	<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;border: 1px solid yellow;
    width: 48%;
    float: right;height: 350px;">
		<h3>area2</h3>
	</div>
</div>


<div id="content" style="padding-bottom: 30px;">

	<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;border: 1px solid blue;
    width: 48%;
    float: left;height: 350px;">
		<h3>area3</h3>
	</div>
	<div class="" style="border-left: 6px solid #ccc!important; border-color: #4CAF50!important;border: 1px solid blue;
    width: 48%;
    float: right;height: 350px;">
		<h3>area4</h3>
	</div>
</div>


