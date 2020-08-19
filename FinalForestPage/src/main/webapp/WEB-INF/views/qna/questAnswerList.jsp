<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-main-style">
	<h2>Q&amp;A</h2>
	
	<form id="search_form" action="questAnswerList.do" method="get">
			<ul>
				<li>
					<select name="keyfield" >
						<option value="q_title">제목</option>
						<option value="question">내용</option>
						<option value="id">id</option>
					</select>
				</li>
				<li>
					<input type="search" size="15" name="keyword" id="keyword">	
				</li>
				<li>
					<input type="submit" value="검색">
				</li>
			</ul>			
		</form>
	
	<c:if test="${count == 0}">
		<!-- <div class="result-display">등록된 문의글이 없습니다.</div> -->
		<table>
			<tr>
				<th>번호</th>
				<th width="500">제목</th>
				<th>작성자</th>
				<th>답변여부</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>	
			<tr><td colspan="6">작성된 Q&amp;A 글이 없습니다.</td></tr>
		</table>
	</c:if>
	
	<c:if test="${count > 0}">
		<table class="qna-table">
			<tr>
				<th>번호</th>
				<th width="500">제목</th>
				<th>작성자</th>
				<th>답변여부</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="qna" items="${list}">
				<tr>
					<td>${qna.q_num}</td>
					<td><a href="questAnswerDetail.do?num=${qna.q_num}">${qna.q_title}</a></td>
					<td>${qna.id}</td>
					<c:choose>
						<c:when test="${qna.answer eq 'no answer'}">
							<td>처리중</td>
						</c:when>
						<c:otherwise>
							<td>처리완료</td>
						</c:otherwise>
					</c:choose>
					<td>${qna.q_reg_date}</td>
					<td>${qna.q_hit}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="align-right" style="float:right;margin-top:30px;" id="qna-list-div">
			<c:if test="${!empty user_id}">
				<input type="button" value="등록" onclick="location.href='questAnswerWrite.do'" />
			</c:if>
		</div>
		<div class="align-center pagenum">${pagingHtml}</div>
	</c:if>
	
</div>
