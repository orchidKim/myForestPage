<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
			
		var checkId = 0;
		$('#confirmId').click(function(){
			
			//아이디 입력했는지 체크
			if($('#id').val()==''){//아이디를 입력 안한 경우
				$('#message_id').css('color','red').text('입력 필수');
				return;
			}
		
			$('#message_id').text('');//메시지 초기화
			$('#loading').show();//로딩 이미지 노출
			
			$.ajax({
				url:'confirmId.do',
				type:'post',
				data:{id:$('#id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(data){
					$('#loading').hide();//로딩 이미지 감추기
					if(data.result=='idNotFound'){//중복되지않음
						$('#message_id').css('color','red').text('해당 아이디가 존재하지 않습니다.');
						checkId=0;
					}else if(data.result=='idDuplicated'){//중복됨
						$('#message_id').css('color','#000').text('등록되어 있는 아이디입니다.');
						checkId=1;
					}else{
						alert('아이디 검색 오류');
						checkId=0;
					}
				},
				error:function(){
					checkId=0;
					$('#loading').hide();//로딩 이미지 감추기
					alert('아이디 검색 실패');
	
				}
			});
		});
		
		//아이디 중복 안내메시지 초기화 및 아이디 중복값 초기화(변심했을때)
		$('#idSearch_form #id').keydown(function(){
			checkId=0;
			$('#message_id').text('');
		});
		
		//submit이벤트 발생시 아이디 중복 체크 여부 확인
		$('#idSearch_form').submit(function(){
			if(checkId==0){
				$('#message_id').css('color','red').text('아이디 체크 필수');
				if($('#id').val()==''){
					$('#id').focus();
				}
				return false;
			}
		});

	});
</script> 

<div class="page-main-style">
	<h2>비밀번호 찾기</h2>
	<form:form action="findPasswordId.do" commandName="memberVO" id="idSearch_form">
		<ul>
			<li>
				<label for="id">아이디</label>
				<form:input path="id" placeholder="아이디를 입력하세요"/>
				<input type="button" id="confirmId" value="아이디 체크">
				<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif" id="loading" width="16" height="16" style="display:none;">
				<p id="message_id"></p>
				<form:errors path="id" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="확인">
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/main/main.do'"> 
		</div>
	</form:form>
</div>













