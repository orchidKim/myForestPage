<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//(수정할 때마다)입력을 했는지,이전 비밀번호와 변경할 비밀번호 일치하는지 확인
		$('#passwd').keyup(function(){
			if($('#confirm_passwd').val()!='' && $('#confirm_passwd').val()!=$(this).val()){
				$('#message_id').text('비밀번호 불일치').css('color','red');
			}else if($('#confirm_passwd').val()!='' && $('#confirm_passwd').val()==$(this).val()){
				$('#message_id').text('비밀번호 일치').css('color','black');
			}
		});
		$('#confirm_passwd').keyup(function(){
			if($('#passwd').val()!='' && $('#passwd').val()!=$(this).val()){
				$('#message_id').text('비밀번호 불일치').css('color','red');
			}else if($('#passwd').val()!='' && $('#passwd').val()==$(this).val()){
				$('#message_id').text('비밀번호 일치').css('color','black');
			}
		});
		
		//유효성 체크(전부 다 입력했는지 체크)
		$('#change_form').submit(function(){
			if($('#old_passwd').val()==''){
				alert('현재 비밀번호를 입력하세요.');
				$('#old_passwd').focus();
				return false;
			}
			if($('#passwd').val()==''){
				alert('변경할 비밀번호를 입력하세요.');
				$('#passwd').focus();
				return false;
			}
			//이전 비밀번호와 변경할 비밀번호 일치 여부 확인
			if($('#passwd').val()!=$('#confirm_passwd').val()){
				$('#message_id').text('비밀번호 불일치').css('color','red');
				return false;
			}
		});
	});
</script>
<div class="page-main-style">
	<h2>회원 비밀번호 변경</h2>
	<form:form action="changePassword.do" commandName="memberVO" id="change_form">
		<form:hidden path="mem_num"/>
		<ul>
			<li>
				<label for="old_passwd">현재 비밀번호</label>
				<form:password path="old_passwd"/>
				<form:errors path="old_passwd" cssClass="error-color"/>
			</li>
			<li>
				<label for="passwd">변경할 비밀번호</label>
				<form:password path="passwd"/>
				<form:errors path="passwd"/>
			</li>
			<li>
				<label for="confirm_passwd">변경할 비밀번호 확인</label>
				<input type="password" id="confirm_passwd"><!-- 이거는 확인용이므로 DB에서 사용하지 않음,따라서 커스텀태그가 아니라 일반input태그로 함 -->
				<span id="message_id"></span>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="비밀번호 변경">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form:form>
</div>













