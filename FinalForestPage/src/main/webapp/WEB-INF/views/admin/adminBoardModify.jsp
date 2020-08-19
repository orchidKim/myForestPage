<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
	<input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
	<input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
	<input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
	<input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'">
	
<div class="page-main-style">
	<h2>글수정</h2>
	<form:form action="${pageContext.request.contextPath}/admin/adminBoardModify.do" commandName="boardVO">
		<form:hidden path="n_num"/>
	<ul>
		<li>
			<label for="n_title">공지사항 제목</label>
			<form:input path="n_title"/>
			<form:errors path="n_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="notice">공지사항 내용</label>
			<form:textarea path="notice" cols="50" rows="20"/>
			<form:errors path="notice" cssClass="error-color"/>
		</li>
		
	</ul>
	
	<div class="align-center">
		<input type="submit" value="수정">
	</div>
	</form:form>
</div>