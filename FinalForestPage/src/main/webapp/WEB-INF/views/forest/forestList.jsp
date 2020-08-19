<%@ page language="java" contentType="text/html;  charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<div class="page-main-style">

<!-- 선택지역명 출력 -->
<c:if test="${location != null}">
	<h2>${location} 휴양림 리스트</h2>
</c:if>

<!-- 선택 지역x -> 전국 휴양림으로 처리, 상단바 '전국휴양림' 버튼을 누른 경우 -->
<c:if test="${location == null}">
	<h2>전국 휴양림 리스트</h2>
</c:if>
	
<script type="text/javascript">
	$(document).ready(function() {
		$('#selectLocForm').submit(function() {
			if($('#keyword option:selected').text()=='지역을 선택하세요'){
				alert('지역을 선택하세요');
				return false;
			}//else if
		});//$('#selectLocForm').submit
	});//$(document).ready
</script>

<form:form action="forestList.do" commandName="location" method="get" id="selectLocForm">
	<div class="selectBox">
	<select name="location"> <!-- name="keyword" id="keyword" -->
		<option selected>지역을 선택하세요</option>
		<option value="서울">서울</option>
		<option value="경기도">경기도</option>
		<option value="울산">울산</option>
		<option value="부산">부산</option>
		<option value="대전">대전</option>
		<option value="세종">세종</option>
		<option value="대구">대구</option>
		<option value="인천">인천</option>
		<option value="광주">광주</option>
		<option value="강원도">강원도</option>
    	<option value="충청북도">충청북도</option>
    	<option value="충청남도">충청남도</option>
    	<option value="전라북도">전라북도</option>
    	<option value="전라남도">전라남도</option>
    	<option value="경상북도">경상북도</option>
    	<option value="경상남도">경상남도</option>
    	<option value="제주">제주</option>
	</select>
	<input type="submit" value="검색">
	</div>
</form:form>

<!-- 선택지역 또는 전국 휴양림 리스트 출력 -->
<c:if test="${count>0}">
	<c:if test="${location == null}">
		<h3>전체 <!-- 전국 검색결과  --><span style="color:#4d540e">${count}</span>개의 휴양림이 있습니다.<!--  존재 --></h3>
	</c:if>
	
	<c:if test="${location != null}">
		<h3><span style="color:#4d540e">${location} 지역</span>에 <span style="color:#4d540e">${count}</span>개의 휴양림이 있습니다.<!--  존재 --> </h3>
	</c:if>
	
	<table border="1" id="forest-list">
		<tr>
			<th>휴양림명</th>
			<th>소재지도로명주소</th>
			<th>숙박가능여부</th>
		</tr>
		
		<c:forEach var="forest" items="${forestList}">
			<tr>
				<td><a href="forestDetail.do?p_num=${forest.p_num}">${forest.p_name}</a></td>
				<td>${forest.p_load}</td>
				<td>${forest.p_stay}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center pagenum">${pagingHtml}</div>
</c:if>

<!-- 지역을 선택했지만 해당 지역에 휴양림이 없을 때 -->
<c:if test="${location != null && count==0 }">
	<h3>[${location}] 지역의 휴양림이 존재하지 않습니다.</h3>
</c:if>

</div>