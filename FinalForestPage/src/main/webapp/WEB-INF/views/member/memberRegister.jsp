<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		//비번,비번확인 일치 여부	
		var checkPasswd = 0;
		$('#cpasswd').keyup(function(){
			if($('#passwd').val() != $('#cpasswd').val()){
				$('#message_passwd').text('비밀번호 불일치').css('color','red');
				checkPasswd=0;
			}else if($('#passwd').val() == $('#cpasswd').val()){
				$('#message_passwd').text('비밀번호 일치').css('color','black');
				checkPasswd=1;
			}
		});
		 
	
		//id중복체크	
		var checkId = 0;
		$('#confirmId').click(function(){
			
			//아이디 입력했는지 체크
			if($('#id').val()==''){//아이디를 입력 안한 경우
				$('#message_id').css('color','red').text('아이디 입력 필수');
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
						$('#message_id').css('color','#000').text('등록가능ID');
						checkId=1;
					}else if(data.result=='idDuplicated'){//중복됨
						$('#message_id').css('color','red').text('이미 등록된 ID');
						checkId=0;
					}else{
						alert('ID검색 오류');
						checkId=0;
					}
				},
				error:function(){
					checkId=0;
					$('#loading').hide();//로딩 이미지 감추기
					alert('ID검색 실패');
				}
			});
		});
		
		
		//아이디 중복 안내메시지 초기화 및 아이디 중복값 초기화(변심했을때)
		$('#register_form #id').keydown(function(){
			checkId=0;
			$('#message_id').text('');
		});
		
		
		//비밀번호확인 불일치 안내메시지 초기화 (변심했을때)
		$('#register_form #passwd').keydown(function(){
			checkPasswd=0;
			$('#message_passwd').text('');
		}); 
		$('#register_form #cpasswd').keydown(function(){
			checkPasswd=0;
			$('#message_passwd').text('');
		}); 
		
		
		//submit이벤트 발생시 아이디 중복 체크 여부 확인
		$('#register_form').submit(function(){
			if(checkId==0){
				$('#message_id').css('color','red').text('중복체크 필수');
				if($('#id').val()==''){
					$('#id').focus();
				}
				return false;
			}
			if(checkPasswd==0){
				$('#message_passwd').css('color','red').text('비밀번호 불일치');
				if($('#cpasswd').val()==''){
					$('#cpasswd').focus();
				}
				return false;
			}
		});	

	});
</script> 
<div class="page-main-style">
	<h2>회원가입</h2>
	<form:form action="register.do" commandName="memberVO" id="register_form">
		<ul>
			<li>
				<label for="id">아이디</label>
				<form:input path="id" placeholder="아이디를 입력하세요"/>
				<input type="button" id="confirmId" value="아이디 중복체크">
				<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif" id="loading" width="16" height="16" style="display:none;">
				<span id="message_id"></span>
				<form:errors path="id" cssClass="error-color"/>
			</li>
			
			<li>
				<label for="passwd">비밀번호</label>
				<form:password path="passwd" id="passwd" placeholder="비밀번호를 입력하세요"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</li>
			
			<li>
				<label for="cpasswd">비밀번호 확인</label>
				<input type="password" id="cpasswd" placeholder="비밀번호 확인을 입력하세요"/>
				<span id="message_passwd"></span>
			</li>	
			
			<li>
				<label for="name">이름</label>
				<form:input path="name" placeholder="이름을 10자 이하로 입력하세요"/>
				<form:errors path="name" cssClass="error-color"/>
			</li>
			
			<li>
				<label for="email">이메일</label>
				<form:input path="email" placeholder="이메일을 입력하세요"/>
				<form:errors path="email" cssClass="error-color"/>
			</li>
			
			<li>
				<label for="phone">전화번호</label>
				<form:input path="phone" placeholder="전화번호를 입력하세요"/>
				<form:errors path="phone" cssClass="error-color"/>
			</li>		
				
			<li>
				<label for="address">주소</label>
				<form:input path="address" id="address" placeholder="주소를 입력하세요"/>
				<input type="button" value="주소검색" id="findAdress">
				<form:errors path="address" cssClass="error-color"/>
			</li>	
			
			<li>
				<label for="passwd_q">비밀번호 찾기 질문</label>
				<form:input path="passwd_q" placeholder="질문을 입력하세요"/>
				<form:errors path="passwd_q" cssClass="error-color"/>
			</li>
			
			<li>
				<label for="passwd_a">비밀번호 찾기 답변</label>
				<form:input path="passwd_a" placeholder="답변을 입력하세요"/>
				<form:errors path="passwd_a" cssClass="error-color"/>
			</li>
				
		</ul>
		<div class="align-center">
			<input type="submit" value="회원가입">
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