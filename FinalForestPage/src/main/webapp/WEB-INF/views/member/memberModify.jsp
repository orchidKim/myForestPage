<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="page-main-style">
	<h2>회원정보수정</h2>
	<form:form action="update.do" commandName="memberVO">
		<form:hidden path="mem_num"/>
		<ul>
			<li>
				<label for="id">아이디</label>
				<p>${user_id}</p>
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<form:input path="passwd"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</li>
			<li>
				<label for="name">이름</label>
				<form:input path="name"/>
				<form:errors path="name" cssClass="error-color"/>
			</li>
			<li>
				<label for="email">이메일</label>
				<form:input path="email"/>
				<form:errors path="email" cssClass="error-color"/>
			</li>
			<li>
				<label for="phone">전화번호</label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
			</li>
			<li>
				<label for="address">주소</label>
				<form:input path="address" id="address"/>
				<input type="button" value="주소검색" id="findAdress">
				<form:errors path="address" cssClass="error-color"/>  
			</li>	
			<li>
				<label for="passwd_q">비밀번호 찾기 질문</label>
				<form:input path="passwd_q"/>
				<form:errors path="passwd_q" cssClass="error-color"/>
			</li>
			<li>
				<label for="passwd_a">비밀번호 찾기 답변</label>
				<form:input path="passwd_a"/>
				<form:errors path="passwd_a" cssClass="error-color"/>
			</li>
		
		</ul>
		<div class="align-center">
			<input type="submit" value="수정">
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/member/detail.do'">
		</div>
	</form:form>
</div>



<!-- 다음 주소검색 팝업창 코드 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* 주소 입력창이 공백이 아닐 때 */
	$('#address').focus(function(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            document.getElementById('address').value = data.address;
	        }
	    }).open();
		$('#address').blur();
	});
	
	
	/* 주소검색 버튼을 클릭했을 떄 */
	$('#findAdress').click(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            document.getElementById('address').value = data.address;
	        }
	    }).open();
	});
	
</script>
<!-- 다음 주소검색 팝업창 코드 끝 -->