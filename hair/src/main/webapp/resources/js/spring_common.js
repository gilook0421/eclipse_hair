$(function(){

	console.log("[common] js.");
	
	// home으로 이동.
	$("#goHome").click(function(){
		location.href="../";
	});
	
})

function gl_ajax(url, inParam, callback){
	console.log("공통 ajax 호출.");

	$.ajax({
		url:url,
		type:"POST",
		data:JSON.stringify(inParam),
		contentType: 'application/json',
		//datatype:"json",
        beforeSend: function (msg) {
            console.log("[ajax beforeSend.] : " + JSON.stringify(msg));
        },
		success:function(result){
			console.log("[ajax ok.] : " + JSON.stringify(result));
			callback(result);
		},
		error:function(request,status,error){
			console.log("[ajax fail.] : " + JSON.stringify(request) );
			console.log("[ajax fail.] : " + JSON.stringify(status) );
			console.log("[ajax fail.] : " + JSON.stringify(error) );
			//alert("[ajax fail.]code : " + request.status + "\nerror : " + error );
			//return false;
			if ( status == "error" && request.status == "500" ){
				location.href = "/error/500error.jsp";
			}
			else if ( status == "error" && request.status == "404" ){
				location.href = "/error/404error.jsp";
			}
		}
		
	}).done(function(msg){
		console.log("[ajax after.] : " + JSON.stringify(msg) );
	})
	;
	
}

function gl_ajaxCode(flag, tagId){
	console.log("공통 codeajax 호출 : [flag = " + flag + "], [tagId : " + tagId +"]");

	var url = "../code/code.api";
	var param = null;
	if ( flag == "product" ){
		//url = "../common/productList.api";
		param = {
				"mem_id":""
		};
	}
	else if ( flag == "staff" ){
		//url = "../staff/staffList.api";
		param = {
				"mem_id":""
		};
	}
	
	$.ajax({
		url:url,
		type:"POST",
		data:param,
		datatype:"json",
        beforeSend: function (msg) {
            console.log("[codeajax beforeSend.] : " + JSON.stringify(msg));
        },
		success:function(result){
			console.log("[codeajax ok.] : " + JSON.stringify(result));
			$("#"+tagId).html("");
			var resultCode = "";
			resultCode += "<select id='"+tagId+"' name='"+tagId+"' >";
			if ( flag == "product" ){
				resultCode += "<option value='' selected>선택하십시오.</option>"
			}
			else if ( flag == "staff" ){
				resultCode += "<option value='"+ result.user.mem_id +"' selected>원장</option>"
			}
			$.each(result.data, function(index, item){
				resultCode += "<option value='"+item.code+"'>"+item.name+"</option>";
			});
			resultCode += "</select>";
			$("#"+tagId).html(resultCode);
		},
		error:function(request,status,error){
			alert("[codeajax fail.]code : " + request.status + "\nerror : " + error );
			return false;
		}
		
	}).done(function(msg){
		console.log("[codeajax after.] : " + JSON.stringify(msg) );
	})
	;
	
}


//form 값 전부 보내기
$('.btn_upfile').click(function(){
  
    var idx = $(this).parent().parent().index();
    var frm = document.getElementById('frm_store');
    frm.method = 'POST';
    frm.enctype = 'multipart/form-data';
  
    var fileData = new FormData(frm);
  
    // ajax
    $.ajax({
        url:'/intra_tmp/backend/image_upload.php',
        type:'POST',
        data:fileData,
        async:false,
        cache:false,
        contentType:false,
        processData:false
    }).done(function(response){
        alert(response);
    });
  
});
  
// 필요한 값만 보내기
$('.btn_upfile').click(function(){
  
    var idx = $(this).parent().parent().index();
    var frm = document.getElementById('frm_store');
    frm.method = 'POST';
    frm.enctype = 'multipart/form-data';
  
    var shopNo = frm.shop_No.value;
    var files = $('#t_img_manager tr:eq('+idx+') .frm_file')[0].files[0];
    var fileData = new FormData();
  
    fileData.append('shopNo', shopNo);
    fileData.append(idx, files);
  
    // ajax
    $.ajax({
        url:'/intra_tmp/backend/image_upload.php',
        type:'POST',
        data:fileData,
        async:false,
        cache:false,
        contentType:false,
        processData:false
    }).done(function(response){
        alert(response);
    });
  
});

	
	