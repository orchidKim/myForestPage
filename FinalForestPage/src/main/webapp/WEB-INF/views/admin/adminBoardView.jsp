<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
	<input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
	<input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
	<input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
	<input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'">
	
<div class="page-main-style">
	<form id="search_form" action="detail_admin.do" method="get">
	<ul>
		<li>번호: ${notice.n_num}</li>
		<li>작성자: ${notice.id}</li>
		<li>작성일: ${notice.reg_date}</li>
		<li>제목: ${notice.n_title}</li>
	</ul>	
	<p>
		${notice.notice }
	</p>
	<hr size="1" width="100%">
	<div class="align-right">
		 <input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardModify.do?n_num=${notice.n_num}'">
	</div>
	</form>
</div>