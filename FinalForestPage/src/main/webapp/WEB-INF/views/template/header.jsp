<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<div class="header_inner">

	<h1><a href="${pageContext.request.contextPath}/main/main.do">코상휴가</a></h1>
	
	
	
	<div>
		<!-- 로그인, 비로그인 상관없이 항상 존재하는 상단바 메뉴, 관리자 페이지에서는 노출x -->
		<c:if test="${user_auth != 3}">
			<span><a href="${pageContext.request.contextPath}/board/boardList.do">공지사항</a></span>
			<span><a href="${pageContext.request.contextPath}/qna/questAnswerList.do">Q&A</a></span>
			<span><a href="${pageContext.request.contextPath}/forest/forestList.do">전국 휴양림</a></span>
		</c:if>
	
		<!-- 로그인한 상태라면, 유저의 아이디를 띄워줌 -->
		<c:if test="${!empty user_id}">
			<span class="user_name"><b>[${user_id}]님 접속중</b></span>
		</c:if>
		
		<!-- 로그인한 상태고, 일반유저라면 -->
		<c:if test="${!empty user_id && user_auth == 2}">
			<select onchange="location.href=this.value">
			    <option selected >[${user_id}]님</option> 
			    <option value="${pageContext.request.contextPath}/member/detail.do">회원정보</option>
			    <option value="${pageContext.request.contextPath}/qna/questAnswerMemberList.do">나의 문의내역</option>
			    <option value="${pageContext.request.contextPath}/pickPlace/myPickList.do">나의 찜</option>
			    <option value="${pageContext.request.contextPath}/visit/myBookList.do">나의 예약</option>
			</select> 
			
			<%-- <span class="user_info">
				<!-- <a href="#">메뉴</a> -->
				<ul class="infoList">
					<li><a href="${pageContext.request.contextPath}/member/detail.do">회원정보</a></li>
					<li><a href="${pageContext.request.contextPath}/pickPlace/myPickList.do">나의 찜</a></li>
					<li><a href="${pageContext.request.contextPath}/visit/myBookList.do">나의 예약</a></li>
				</ul>
			</span> --%>
			
		</c:if>
		
		<%-- 
		<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
			<input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
			<input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
			<input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
			<input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'"> --%>

		<!-- 로그인한 상태고, 관리자유저라면 -->
		<c:if test="${user_auth == 3}">
			<a href="${pageContext.request.contextPath}/admin/memberList.do">회원관리</a>
			<a href="${pageContext.request.contextPath}/admin/adminBoardList.do">공지사항관리</a>
			<a href="${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do">Q&amp;A관리</a>
			<a href="${pageContext.request.contextPath}/admin/adminCommentList.do">댓글관리</a>
			<a href="${pageContext.request.contextPath}/admin/adminForestList.do">휴양림관리</a>
		</c:if>
		
		
		<!-- 로그인한 상태라면, 로그아웃 버튼을 생성 -->
		<c:if test="${!empty user_id}">
			<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</c:if>
		
		<!-- 로그인 안한 상태라면, 회원가입과 로그인 버튼을 생성 -->
		<c:if test="${empty user_id}">
			<a href="${pageContext.request.contextPath}/member/register.do">회원가입</a>
			<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
		</c:if>	
	</div>
	
</div>





