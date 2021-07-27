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

<style type="text/css">
#header {
	width: 100%;
	height: 50px;
	text-align: center;
	background-color: #4682B4;
	border : 0px solid;
}

#left-side {
	float: left;
	width: 10%;
	background-color: #4682B4;
}

#content {
	float: left;
	width: 90%;
	background-color: white;
}

#footer {
	width: 100%;
	height: 50px;
	text-align: center;
	background-color: #F5F5F5;
	clear: both;
	border : 0px solid;
}

#left-side {
	min-height: 1050px;
}
#content {
	min-height: 1000px;
}
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
<body>

	<div style="width:100%; height:100%;">
	    <!-- div id="header"><tiles:insertAttribute name="header" /></div-->
	    <div id="left-side"><tiles:insertAttribute name="left-side" /></div>
	    <div id="content">
	    	<tiles:insertAttribute name="body" />
	    	<div id="footer"><tiles:insertAttribute name="footer" /></div>
	    </div>    
	    
	</div>

</body>

</html>
