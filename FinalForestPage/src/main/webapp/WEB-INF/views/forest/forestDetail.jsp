<%@ page language="java" contentType="text/html;  charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<div class="page-main-style">

<h2>[${forest.p_name}]휴양림 상세</h2>

<div>
<table class="forestDetail-table" >
	
	<colgroup>
      <col width="30%" />
      <col width="25%" />
      <col width="45%" />
	</colgroup>
	<tr style="background:none;">
		<!-- 해당 휴양림의 이미지가 존재x, 샘플 이미지로 출력 -->
		<c:if test="${empty forest.p_img}">
			<td><img src="${pageContext.request.contextPath}/upload/sample.PNG" style="max-width:150px"></td>
		</c:if>

		<!-- 해당 휴양림의 이미지 존재, 출력 -->
		<c:if test="${!empty forest.p_img}">
			<td><img src="${pageContext.request.contextPath}/upload/${forest.p_img}" style="max-width:150px"></td>
		</c:if>

		<th id="forestDetail-table-th">
			시도명<hr>
			구분<hr>
			면적<hr>
			수용가능인원<hr>
			입장료<hr>
			숙박가능여부<hr>
			주요시설<hr>
			소재지 도로명주소<hr>
			관리기관명<hr>
			전화번호<hr>
			홈페이지	
		</th>
		<td>
			${forest.p_city}<hr>
			${forest.p_div}<hr>
			${forest.p_size}<hr>
			${forest.p_count}<hr>
			${forest.p_cost}<hr>
			${forest.p_stay}<hr>
			${forest.p_facility}<hr>
			${forest.p_load}<hr>
			${forest.p_pubnum}<hr>
			${forest.p_phone}<hr>
			<input type="image" src="../resources/images/home.png" style="height:20px; width:20px;border:none;" onClick="location.href='${forest.p_web}'">
		</td>
	</tr>
	
</table>
<p/>

<!-- 폼에서 날짜(년,월) 선택 없이 예약버튼을 눌렀을 때 -->
<script type="text/javascript">
	$(document).ready(function() {
		var result = '';
		$('#selectMonthDayForm').submit(function() {
			if($('#v_day').val()==''){
				alert('날짜를 선택하세요');
				return false;
			}
			result = '['+$('#v_day').val()+'] 날짜의 예약 현황을 확인합니다.';
			alert(result);
			//return false;
		});
		
		$('#showAlert').submit(function() {
			/* if($('#v_day').val()==''){
				alert('날짜를 선택하세요');
				return false;
			}
			result = '['+$('#v_day').val()+'] 날짜의 예약 현황을 확인합니다.'; */
			alert('회원제 서비스입니다.');
			return false;
		});
		
		$('#buttonShowAlert').click(function() {
			alert('회원제 서비스입니다');
		});
	});
</script>

<!-- 로그인시 보이는 예약,찜 버튼 -->
<div class="forestDetail-sub">
<div class="forestDetail-book">
 <c:if test="${!empty mem_num}">
	<form action="${pageContext.request.contextPath}/visit/bookVisitDay.do" method="post" id="selectMonthDayForm">
		<a style="color:blue;font-size:16px;font-weight:bold;">선택한 날짜의 [${forest.p_name}] 방문예정 현황을 볼 수 있습니다.</a><br><br>
		<!-- 회원고유번호 프로젝트 통합시 수정 -->
		<input type="hidden" name="mem_num" value="${mem_num}">
		<input type="hidden" name="p_num" value="${forest.p_num}">
		<input type="hidden" name="p_name" value="${forest.p_name}">
		<p><input type="month" name="v_day" id="v_day" style="width:100%;height:50px;text-align:center;padding-left:0;"></p>
		<p><input type="submit" value="예약하기" style="width:100%;height:50px;"></p>
		<p><input type="button" value="찜하기" style="width:100%;height:50px;" onclick="location.href='${pageContext.request.contextPath}/pickPlace/pickPlace.do?p_num=${forest.p_num}'"></p>
	</form>
</c:if>
</div>

<!-- 비로그인시 보이는 예약,찜 버튼 -->
<div class="forestDetail-sub">
<div class="forestDetail-book">
 <c:if test="${empty mem_num}">
	<form action="${pageContext.request.contextPath}/visit/bookVisitDay.do" method="post" id="showAlert">
		<a style="color:blue;font-size:16px;font-weight:bold;">선택한 날짜의 [${forest.p_name}] 방문예정 현황을 볼 수 있습니다.</a><br><br>
		<!-- 회원고유번호 프로젝트 통합시 수정 -->
		<input type="hidden" name="mem_num" value="${mem_num}">
		<input type="hidden" name="p_num" value="${forest.p_num}">
		<input type="hidden" name="p_name" value="${forest.p_name}">
		<p><input type="month" name="v_day" id="v_day" style="width:100%;height:50px;text-align:center;padding-left:0;"></p>
		<p><input type="submit" value="예약하기" style="width:100%;height:50px;color:white;font-weight:bold;background:#4d540e;"></p>
		<p><input type="button" value="찜하기" id="buttonShowAlert" style="width:100%;height:50px;color:white;font-weight:bold;background:#4d540e;"></p>

	</form>
</c:if>
</div>

<!-- 카카오맵 연동 코드 시작, z-index:2; 상단 헤더보다 아래에 배치-->
<div id="map"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=47a7869db724abdfda255cdf75e41b7d"></script>
<script>
	var lat = ${forest.p_latitude};
	var lon = ${forest.p_longitude};
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(lat, lon), //지도의 중심좌표.
		level: 5 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
</script>
</div>
<!-- 카카오맵 연동 코드 끝 -->

<script type="text/javascript">
   function delete_check(c_num,p_num){
      if(confirm('해당 댓글을 삭제하시겠습니까?') == true){
         location.href='${pageContext.request.contextPath}/comment/commentDeleteUser.do?c_num='+c_num+'&p_num='+p_num;
      }else{
         return;
      }
   }
</script>

<!-- 댓글 작성 폼 시작 -->
<c:if test="${!empty mem_num}">
	<form action="${pageContext.request.contextPath}/comment/writeComment.do" method="post" id="forestDetail-myComments">
		<!-- 회원고유번호 프로젝트 통합시 수정 -->
		<input type="hidden" name="mem_num" value="${mem_num}">
		<input type="hidden" name="p_num" value="${forest.p_num}">
		<input type="hidden" name="p_name" value="${forest.p_name}">
		<input type="text" name="comments" placeholder="이용후기를 남겨주세요!" style="width:1040px;height:50px;">
		<input type="submit" value="등록" style="width:115px;height:50px;margin-left:5px">
	</form>
</c:if>
</div>
<!-- 댓글 작성 폼 끝 -->
<p/><p/>

<div>
<!-- 기존 댓글 출력 처리 시작 -->
<c:if test="${commentCnt > 0}">
	<table class="forestDetail-comments-table">
		<tr>
			<th width="170">아이디</th>
			<th>이용후기</th>
			<th width="170">작성일</th>
		</tr>
		<c:forEach var="comment" items="${commentList}">
			<tr>
				<td style="font-weight:bold;font-size:16px;">${comment.id}</td>
				<td style="text-align:left;">
					${comment.comments}
					<!-- 프로젝트 통합시, 실제 로그인중인 회원의 고유번호(mem_num) 출력하도록 수정 -->
					<!-- 로그인한 회원과 작성자가 일치하는 경우만 삭제 버튼 출력 -->
					<c:if test="${comment.mem_num == mem_num}">
						<input type="button" id="comment_delete" value="댓글삭제" onclick="delete_check(${comment.c_num},${forest.p_num});">
					</c:if>
					<c:if test="${comment.mem_num != mem_num}">
					</c:if>
				</td>
				<td>${comment.reg_date}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center pagenum">${pagingHtml}</div>
</c:if>

<c:if test="${commentCnt == 0}">
	<table class="forestDetail-comments-table">
		<tr>
			<th>아이디</th>
			<th width="500">이용후기</th>
			<th>작성일</th>
		</tr>
		<tr>
			<td colspan="3">해당 휴양림에 작성된 댓글이 존재하지 않습니다.</td>
		</tr>
	</table>
</c:if>
<!-- 기존 댓글 출력 처리 끝 -->
</div>

</div>


