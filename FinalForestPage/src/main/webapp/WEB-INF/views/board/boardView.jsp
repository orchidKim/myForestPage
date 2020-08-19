<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     

  
<div class="page-main-style">
<h2>공지사항</h2>
	<table border="1" class="boardView-table">
				<%-- <colgroup>
       		   	  <col width="15%" class=""/>
           	      <col width="85%" />
				</colgroup> --%>
				<tr>
					<th>번호</th>
					<td>${board.n_num}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${board.id}</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${board.reg_date}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${board.n_title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="table-notice" align="left">${board.notice}</td>
				</tr>
	</table>
	<div class="align-right">
		 <input type="button" style="margin-top:30px;" value="목록" onclick="location.href='${pageContext.request.contextPath}/board/boardList.do'">
	</div>
</div>