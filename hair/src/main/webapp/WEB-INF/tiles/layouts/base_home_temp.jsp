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

<style type = "text/css"> <!-- 로딩바스타일 -->
body{text-align: center;
	margin: 0 auto;
	background-color: black;
	color: gray;}

#Progress_Loading{position: absolute;
 left: 50%;
 top: 50%;
 background: #ffffff;}



hr{
	border: solid 1px gray;
}
span{
	font-style: italic ; 
	font-weight: bold; 
	font-size: 1.0em;
	line-height: 1.0em; 
	color: gray;
	font-family: arial;
	width: 100%;
	align: center;
	border: solid 0px yellow;
}

#topMenu a{color: orange;}
#topMenu a:hover{color:#D4F4FA;
	border-bottom:3px solid #FAED7D;/* 하이퍼 링크 하단에 테두리가 생기도록 함 */
	text-decoration:none;}
#topMenu ul {list-style-type:none;
	padding-left:0px;/* 좌측 여백 없애기 */
	float:right;/* 우측 정렬 하기 */}
#topMenu ul li {display:inline;
	border-left: 1px solid #c0c0c0;/* li요소의 좌측에 1px의 테두리 만들기 */
	padding: 0px 10px 0px 10px;/* 테두리와 메뉴 간격 벌리기. padding: 위 오른쪽 아래 왼쪽; */
	margin: 5px 0px 5px 0px;/* 메뉴와 테두리 사이 간격 벌리기. margin: 위 오른쪽 아래 왼쪽; */}
#topMenu ul li:first-child {
	border-left: none;/* li의 첫번째 요소의 좌측에는 테두리 없애기 */}

.logo{text-align: center;}
.footer{text-align: center;}

</style>

<title><tiles:getAsString name="title" /></title>
<body style="padding: 50px;background-color: black;">

	<div style="width:100%; height:100%;">
	    <div id="content">
	    	<div id="header" class="logo"><tiles:insertAttribute name="header" /></div>
	    	<div id="menu"><tiles:insertAttribute name="menu" /></div>
	    	<div id="comm"><tiles:insertAttribute name="comm" /></div>
	    	<tiles:insertAttribute name="body" />
	    	<div id="footer" class="footer"><tiles:insertAttribute name="footer" /></div>
	    </div>    
	    
	</div>

</body>

</html>
