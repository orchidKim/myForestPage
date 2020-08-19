<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<script type="text/javascript">
   function delete_check(p_num){
      if(confirm('해당 방문예약을 취소하시겠습니까?') == true){
         location.href='myPickListDelete.do?p_num='+p_num;
      }else{
         return;
      }
   }//function delete_check
</script>
<div class="page-main-style">

<h2 id="myPickList-title">나의 찜 리스트</h2>

<table border="1" class="myPickList-table">
	<tr>
		<th>휴양림명</th>
		<th>찜 삭제</th>
	</tr>

	<c:if test="${!empty list}">	
	
		<c:forEach var="myPick" items="${list}">
		
			<tr>
				<td>
				
					<a href="${pageContext.request.contextPath}/forest/forestDetail.do?p_num=${myPick.p_num}">${myPick.p_name}</a>
				</td>
				<td>	
					<input type="button" value="찜 삭제" id="myPick-btn" onclick="delete_check(${myPick.p_num})">
					
				</td>
				
			</tr>
			
		</c:forEach>
		
	</c:if>
	<c:if test="${empty list}">
		<tr>
			<td>찜 내역이 존재하지 않습니다.</td>
		<tr>
	</c:if>
</table>	

</div>


