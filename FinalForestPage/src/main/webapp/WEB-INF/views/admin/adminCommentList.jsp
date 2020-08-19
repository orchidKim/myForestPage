<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>



<div class="page-main-style">
	<h2>댓글관리</h2>
	
	<form id="search_form" action="adminCommentList.do" method="get">
		<ul class="search">
			<li><select name="keyfield">
					<option selected>==전체==</option>
					<!-- 아이디를 입력받지만 회원번호를 검색하도록 처리 -->
					<option value="mem_num">아이디</option>
					<option value="comments">댓글내용</option>
					<option value="reg_date">작성일</option>
			</select></li>
			<li><input type="search" size="16" name="keyword" id="keyword">
			</li>
			<li><input type="submit" value="검색"></li>
		</ul>
	</form>

	<!-- 작성된 댓글이 존재하는 경우 -->
	<c:if test="${count > 0}">
		<table id="comment_table">
			<tr>
				<th>아이디</th>
				<th class="comment_content">댓글내용</th>
				<th>작성일</th>
				<th><input type="checkbox" id="allchecked"
					style="width: 20px; height: 20px;"></th>
			</tr>

			<c:forEach var="comment" items="${commentList}">
				<tr>
					<td>${comment.id}</td>
					<td>${comment.comments}</td>
					<td>${comment.reg_date}</td>
					<td><input type="checkbox" style="width: 20px; height: 20px;"
						class="checkbox" name="c_num" value="${comment.c_num}"></td>
				</tr>
			</c:forEach>

		</table>
		<div class="align-right">
			<input style="float:right;margin-top:30px;"  type="button" value="삭제" id="delete-btn" class="delete-btn"
				data-num="">
		</div>
		<br>
		<div class="align-center pagenum">${pagingHtml}</div>
	</c:if>

<!-- 작성된 댓글이 존재하지 않는 경우 -->
	<c:if test="${count == 0}">
		<table>
			<tr>
				<th>아이디</th>
				<th>댓글내용</th>
				<th>작성일</th>
				<th>처리</th>
			</tr>
			<tr>
				<td colspan="4">작성된 댓글이 없습니다.</td>
			</tr>
		</table>
	</c:if>


</div>

<script type="text/javascript">
	$('#delete-btn').hide();
	$('#allchecked').focus();

	/* 선택되면 삭제버튼 나오게 하기  */
	$('.checkbox').click(function() {
		if ($(this).prop("checked")) {
			$('#delete-btn').show();
		}
	});
	/* 전체선택  */
	$('#allchecked').click(function() {
		if ($(this).prop('checked')) {
			$('.checkbox').prop('checked', true);
			$('#delete-btn').show();
		} else {
			$('.checkbox').prop('checked', false);
			$('#delete-btn').hide();
		}
	});

	/* 체크박스 값 배열로 저장 */
	/*
	var total_cnt : 배열의 index 
	var checkArray : 다중체크박스 배열
	체크박스를 여러개 선택하면 배열로 저장한 뒤에  data-num 속성에 배열을 넣어주고 
	controller에서 반복문을 이용해서 num 값을 하나씩 빼서 삭제함. 
	*/
	$('.delete-btn').click(function() {
		var total_cnt = 0;
		var checkArray = new Array();
		
		$('.checkbox').each(function() {
			if (this.checked) {
				checkArray[total_cnt] = this.value;	
				total_cnt++;
			}
		});
		
		document.getElementById('delete-btn').setAttribute('data-num', checkArray);
		
		if (checkArray == ''  && checkArray == 0) {
			alert('최소한 1개는 선택해야합니다.');
			return false;
		} 
		if(checkArray != ''  && checkArray != 0){
			var delete1 = confirm("삭제 하시겠습니까?");
			if(delete1 == false){
				return false;
			}else{
				location.href = '${pageContext.request.contextPath}/admin/commentDeleteAdmin.do?c_num='+$(this).attr('data-num');
			}
			
		}
		});
</script>

