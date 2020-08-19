<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
	<input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
	<input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
	<input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
	<input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'">
<div class="page-main-style">
	<h2>글쓰기</h2>
	
	<form:form action="${pageContext.request.contextPath}/admin/adminBoardWrite.do" commandName="boardVO" id="boardWrite_form">
	<ul>
		<li>
			<label for="n_title">공지사항 제목</label>
			<form:input path="n_title" id="title"/>
			<form:errors path="n_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="notice">공지사항 내용</label>
			<form:textarea path="notice" cols="50" rows="20" id="notice"/>
			<form:errors path="notice" cssClass="error-color"/>
		</li>
		
	</ul>
		<div class="align-center">
			<input type="submit" value="등록">
		</div>
	</form:form>
</div>

<!-- 게시글 작성 전 글자 수 체크 -->
<script type="text/javascript">
    $('#boardWrite_form').submit(function(){
    	if($('#title').val().length > 30){
            alert('제목은 최대 30자까지 입력해주세요.');  
			return false;
         }
    	
    });
</script>