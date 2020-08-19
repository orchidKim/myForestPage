<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<link rel="stylesheet" 
   href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
<div class="page-main-style">
	<h2>안내</h2>
	<div class="result-display">
		<img src="${pageContext.request.contextPath}/upload/notice.png">
		<h2>잘못된 접근입니다.</h2>
		<h3>이용에 불편을 드려 죄송합니다.</h3>
		<h3>잘못된 접근이거나 권한이 없는 페이지입니다.</h3>
		<input type="button" value="홈으로"
		   onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
</div>
</body>
</html>




