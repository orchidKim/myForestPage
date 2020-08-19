<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="page-main-style">
	<h2>로그인</h2>
	<form:form action="login.do" commandName="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="id">아이디</label>
				<form:input path="id"/>
				<form:errors path="id" cssClass="error-color"/>
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<form:password path="passwd"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/register.do'">
			<input type="button" value="비밀번호 찾기" onclick="location.href='${pageContext.request.contextPath}/member/findPasswordId.do'">
		</div>
	</form:form>
</div>








