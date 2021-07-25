<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
		$.ajax({
			url:"./memberList.api",
			type:"POST",
			data:"",
			datatype:"json",
			success:function(result){
				console.log("memberList : " + JSON.stringify(result));
				console.log("id : " + result.data.id);
				console.log("###########################");
                console.log("1 : " + JSON.stringify(result));
                var parseData = JSON.parse(JSON.stringify(result));
                console.log("2 : " + parseData.data[0].id);
                console.log("2 : " + parseData.data[1].id);
				console.log("###########################");
				/*$.each(parseData.data, function(index,item){
				console.log(item.key+ ":"+ item.value);
				})
				console.log("size : " + result.data.length);
				$data = JSON.stringify(result.data);
				console.log("data : " + $data.id);*/
				$tbodyList = "";
				for ( i = 0 ; i < result.data.length ; i++ ){
					$tbodyList += "<tr>";
					$tbodyList += "<td><span>"+parseData.data[i].id+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].pw+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].email+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].approval_status+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].approval_key+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].reg_date+"</span></td>";
					$tbodyList += "<td><span>"+parseData.data[i].log_date+"</span></td>";
					$tbodyList += "</tr>";
				}
				$("#tbody").html($tbodyList); 
				
			},
			error:function(request,status,error){
				alert("[memberList] code : " + request.status + "\nerror : " + error );
			}
		})
		
	})
</script>


<div id="content">

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<p class="w3-left">
				<button class="w3-button w3-black w3-round" id="goHome">Home</button>
			</p>
			<div class="w3-center w3-large w3-margin-top">
				<h3>회원리스트</h3>
			</div>
		</div>
			
		<div class="w3-container">
		  <h2>Basic Table</h2>
		  <p>The .table class adds basic styling (light padding and only horizontal dividers) to a table:</p>          
  		  <table class="w3-table-all w3-hoverable">
		    <thead>
      		  <tr class="w3-light-grey">
		        <th>ID</th>
		        <th>PW</th>
		        <th>EMAIL</th>
		        <th>STATUS</th>
		        <th>KEY</th>
		        <th>REG_DATE</th>
		        <th>REG_DATE</th>
		      </tr>
		    </thead>
		    <tbody id="tbody">
		    </tbody>
		  </table>
		</div>
		
	</div>
		
	
</div>