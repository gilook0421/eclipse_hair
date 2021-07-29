<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="kr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" >
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../resources/css/spring_common.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="../resources/js/spring_common.js"></script> 

<style type="text/css">
/* common */
*{margin:0;padding:0;color:orange;}
li{list-style: none;}
a{text-decoration:none;}
hr{border: solid 1px gray;}

.topMenu{width:1170px;margin:0 auto;}
.clearfix{content:' ';display:block;clear:both;}
header{height:75px;background-color:black;border:1px solid #253342;position:fixed;width:100%;z-index:9999;top:0;left:0;}
h1{color: gray;float: left;
	font-style: italic ; 
	font-weight: bold; 
	font-family: arial;}
.subMenu{float:right;}
.subMenu li{float:left;}
.subMenu a{line-height:75px;color: orange;padding: 0 15px;border-left: 1px solid #c0c0c0;/* li요소의 좌측에 1px의 테두리 만들기 */}
.subMenu a:hover{color:#D4F4FA;
	border-bottom:3px solid #FAED7D;/* 하이퍼 링크 하단에 테두리가 생기도록 함 */
	text-decoration:none;}


.left-side-detail{}
.left-side-detail li{height: 1800px;}


#footer{text-align: center;margin: 0 auto; padding-top: 1200px;}
</style>


<style type="text/css">
/*form area*/.formArea{border: 1px solid orange;}
/* form 라벨 */th.formLabel {width: 20%;height: 50px;text-align: center; vertical-align: middle;padding-right: 5px;color: #ccc; font-size: large;}
/* form input */input.formInput {background-color: black;width: 80%;height: 30px;border-top: none; border-left: none; border-right: none; border-bottom: 3px solid gray;}

/*버튼커버*/.formBtnArea {border: 0px solid yellow; text-align: right;padding-bottom:20px;padding-top: 10px;}
/*버튼*/.formBtn {background-color: #4CAF50; color: #fff;padding: 4px 8px;border-radius: 4px;}

/*타이틀*/.subTitle{border-left: 6px solid #ccc!important; border-color: #4CAF50!important;}

/*테이블div*/.tableDiv{border: 0px solid gray;font-size: large;padding: 10px 10px 10px 10px;}
/*테이블*/.table{width:100%;}
/*테이블tr*/.tableHeaderTr{text-align: center;}
/*테이블헤더L*/.tableHeaderLeft{color: #ccc; text-align: left;}
/*테이블헤더C*/.tableHeaderCenter{color: #ccc; text-align: center;}
/*테이블헤더R*/.tableHeaderRight{color: #ccc; text-align: right;}
/*테이블데이터tr*/.tableDataTr{style='border: 1px solid grey; height: 50px;'}
/*테이블데이터*/.tableData{color: #ccc;padding: 5px 5px 5px 5px;}

/* paging */
.paging {margin:20px auto 0; text-align: center;}
.paging ul,.paging li,.paging a{display:inline-block;}
.paging li {pagging:0 8px; height: 22px; margin: 0 2px; border: 0px solid #dddddd; border-radius: 2px; font-size: 13px; line-height: 22px;}
.paging li:hover {border: 1px solid #7d7a82; color:#fff; background-color: #7d7a82;}
.paging li:hover a {color: #fff;}


</style>


<script>
var DOMAIN = '<%= request.getRemoteAddr() %>';
var DOMAIN_PORT = '<%= request.getServerPort() %>';
var DOMAIN_CONTEXT_PATH = '<%= request.getContextPath() %>';
var DOMAIN_PREFIX = DOMAIN+":"+DOMAIN_PORT+DOMAIN_CONTEXT_PATH;
$(function(){
})
</script>


<title><tiles:getAsString name="title" /></title>
<body style="padding: 50px;background-color: black;">

	<div style="width:100%; height:100%;">
	    <div id="content">
	    	<div id="header" class="logo"><tiles:insertAttribute name="header" /></div>
	    	<div id="menu"><tiles:insertAttribute name="menu" /></div>
	    	<div id="comm"><tiles:insertAttribute name="comm" /></div>
	    	<div id="left-side" style="padding-top: 25px;">
	    		<ul id="left-side-detail">
	    			<li style="float:left;width: 10%;height: 1200px;border: 1px solid gray;"><tiles:insertAttribute name="left-side" /></li>
	    			<li style="float:left;width: 90%;height: 1200px;padding-left: 5px;"><tiles:insertAttribute name="body" /></li>
	    		</ul>
	    	</div>
	    	<div id="footer" class="footer"><tiles:insertAttribute name="footer" /></div>
	    </div>    
	     
	</div>

</body>

</html>
