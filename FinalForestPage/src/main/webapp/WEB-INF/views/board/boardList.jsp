<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-main-style">
<h2>공지사항</h2>


<div class="wrap">
   <div class="search">
      <form action="boardList.do" id="noticePage_src" method="get">
      <input type="text" id="keyword" name="keyword" placeholder="제목으로만 검색이 가능합니다">
      <button type="submit" id="boardList-srcBtn">검색</button>
      </form>
   </div>
</div>

<c:if test="${count > 0 }">
	<table class="boardList-table">
		<tr>
			<th>번호</th>
			<th width="500">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="notice" items="${list}">
			<tr>
				<td>${notice.n_num}</td>
				<td><a href="boardView.do?n_num=${notice.n_num}">${notice.n_title}</a></td>
				<td>${notice.id}</td>
				<td>${notice.reg_date}</td>
				<td>${notice.n_hit}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center pagenum">${pagingHtml}</div>
</c:if>


<c:if test="${count == 0 }">
	<!-- <div class="result-display">등록된 게시물이 없습니다.</div> -->
	<table class="boardList-table">
		<tr>
			<th>번호</th>
			<th width="500">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
		<tr>
			<td colspan="5">작성된 게시글이 없습니다.</td>
		</tr>
		
	</table>
</c:if>
</div>