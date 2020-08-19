<%@ page language="java" contentType="text/html;  charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<script type="text/javascript">
	function delete_check(v_num){
		if(confirm('해당 방문예약 정보를 삭제하겠습니까?') == true){
			location.href='visitDelete.do?v_num='+v_num;
		}else{
			return;
		}
	}
</script>

<div class="page-main-style">
<h2 id="myBookList-title">나의 방문예약 리스트</h2>

<table border="1" class="myBookList-table">
	<tr>
		<th>방문날짜</th>
		<th>휴양림명</th>
		<th>방문인원</th>
		<th>예약취소</th>
	</tr>
	<c:if test="${!empty myVisitList}">
		<c:forEach var="visit" items="${myVisitList}">
			<tr>
				<td>${visit.v_day}</td>
				<td><a href="${pageContext.request.contextPath}/forest/forestDetail.do?p_num=${visit.p_num}">${visit.p_name}</a></td>
				<td>${visit.v_cnt}</td>
				<td><input type="button" value="예약취소" id="myBook-btn" onclick="delete_check(${visit.v_num});"></td>
			</tr>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty myVisitList}">
		<tr>
			<td colspan="4">예약 내역이 존재하지 않습니다.</td>
		<tr>
	</c:if>
</table>

</div>

