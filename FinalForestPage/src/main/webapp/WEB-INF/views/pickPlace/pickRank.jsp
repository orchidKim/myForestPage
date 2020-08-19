<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<h2>인기 휴양림 TOP8</h2>

<c:if test="${pickRankList != null}">
		<table>
			<tr>
				<th>이미지</th>
				<th>휴양림명</th>
			</tr>
			<c:forEach var="rank" items="${pickRankList}">
				<tr>
					<!-- 해당 휴양림의 이미지가 존재x, 샘플 이미지로 출력 -->
					<c:if test="${rank.p_img == null}">
						<th><img src="${pageContext.request.contextPath}/upload/sample.PNG" style="max-width:200px"></th>
					</c:if>
			
					<!-- 해당 휴양림의 이미지 존재, 출력 -->
					<c:if test="${rank.p_img != null}">
						<th><img src="${pageContext.request.contextPath}/upload/${forest.p_img}" style="max-width:200px"></th>
					</c:if>
					
					<td><a href="${pageContext.request.contextPath}/forest/forestDetail.do?p_num=${rank.p_num}">${rank.p_name}</a></td>
				</tr>
			</c:forEach>
		</table>
</c:if>

