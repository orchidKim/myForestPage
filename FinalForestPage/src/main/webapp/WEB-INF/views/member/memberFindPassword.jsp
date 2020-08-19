<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
			
		$('#answer').hide();
		
		$('#confirmAnswer').click(function(){
			
			//아이디 입력했는지 체크
			if($('#passwd_a').val()==''){//아이디를 입력 안한 경우
				$('#message_answer').css('color','red').text('입력 필수');
				return;
			}
		
			$('#message_answer').text('');//메시지 초기화
			$('#loading').show();//로딩 이미지 노출
			
			$.ajax({
				url:'confirmAnswer.do',
				type:'post',
				data : {
						id: $('#memberId').text(), 
						passwd_a: $('#passwd_a').val()
					} ,
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(data){
					$('#loading').hide();//로딩 이미지 감추기
					if(data.result=='idNotFound'){//답 틀림
						$('#message_answer').css('color','red').text('답변이 틀렸습니다.');
					}else if(data.result=='idDuplicated'){//답 맞음
						//$('#message_answer').css('color','#000').text('정답');
						$('#answer').show();
					}else{
						alert('검색 오류');
					}
				},
				error:function(request,status,error){
					$('#loading').hide();//로딩 이미지 감추기
					alert('검색 오류');
				}
				
			});
		});
		
	});
</script> 

<div class="page-main-style">
	<h2>회원 비밀번호 찾기</h2>
	<form:form action="" commandName="memberVO" id="passwordFindForm">
		<ul>
			<li>
				<label for="id">아이디</label>
				<p id="memberId">${memberVO.getId()}</p>
			</li>
			<li>
				<label for="passwd_q">비밀번호 찾기 질문</label>
				<p>${member.passwd_q}</p>
			</li>
			<li>
				<label for="passwd_a">비밀번호 찾기 답변</label>
				<form:input path="passwd_a" placeholder="답변을 입력하세요"/>
				<input type="button" id="confirmAnswer" value="비밀번호 찾기">
				<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif" id="loading" width="16" height="16" style="display:none;">
				<span id="message_answer"></span>
				<%-- <form:errors path="passwd_a" cssClass="error-color"/> --%>
			</li>
			<li id="answer">[${member.id}]님의 비밀번호는 [${member.passwd}]입니다.</li>
		</ul> 
		<div class="align-center">
			<input type="button" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form:form>
</div>













