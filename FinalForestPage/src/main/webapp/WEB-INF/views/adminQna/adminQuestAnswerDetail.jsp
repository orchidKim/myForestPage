<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--    <input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
   <input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
   <input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
   <input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
   <input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'"> --%>
   
<div class="page-main-style">
   <ul>
      <li>번호 : ${questAnswerVO.q_num}</li>
      <li>제목 : ${questAnswerVO.q_title}</li>
      <li>작성자 : ${questAnswerVO.id}</li>
      <li>작성일 : ${questAnswerVO.q_reg_date}</li>
      <li>최근 수정일 : ${questAnswerVO.q_modify_date}</li>
      <li>조회수 : ${questAnswerVO.q_hit}</li>
   </ul>
   <!-- size=두께 -->
   <hr size="1" width="100%">
   <p id="adminQna_quest">
      ${questAnswerVO.question}
   </p>
   <hr size="1" width="100%">
   <br>
   <br>
   <br>
   <h3>관리자 답변</h3>   
      <form:form action="update.do" commandName="questAnswerVO" id="modify_form">
      <table border="1">
      <form:hidden path="q_title"/>
      <form:hidden path="question"/>
         <tr>
         <td>답변 작성</td>
         <td><form:textarea path="answer" id="answer" cols="30" rows="5" style="resize:none;width:100%;" maxlength="4000"/>
         <div class="qna-align-right">(<span id="checkChar">0</span>/4000)</div></td>
         <td>${questAnswerVO.a_reg_date}</td>
         <td>${questAnswerVO.a_modify_date}</td>
      </tr>
      </table>
      <br>
      <div class="align-right">
      <c:choose>
         <c:when test="${questAnswerVO.answer eq 'no answer'}">
            <form:hidden path="q_num"/>
            <input type="hidden" name="updateInsert" value="updateInsert">
            <input type="submit" value="등록" name="등록" >
         </c:when>
         <c:otherwise>
            <form:hidden path="q_num"/>
            <input type="hidden" name="updateUpdate" value="updateUpdate">
            <input type="submit" value="수정" name="수정" >
         </c:otherwise>
      </c:choose>
         <input type=button value="삭제" onclick="location.href='delete.do?q_num=${questAnswerVO.q_num}'">
         <input type=button value="목록" onclick="location.href='adminQuestAnswerList.do'">                  
      </div>
      </form:form>   
</div>
<script type="text/javascript">
      //글 등록 유효성 체크
      $('#modify_form').submit(function(){
         if($('#answer').val()==''){
            alert('내용을 입력하세요');
            $('#answer').focus();
            return false;
         }
      });   
      
      document.getElementById('answer').onkeyup=function(){
  		//입력한 글자 수
  						//this = textarea , value : 입력한 값, length : 입력한 글자 수
  		var inputLength = this.value.length;
  		//남은 글자 수를 구함
  		var remain = inputLength;
  			
  		//문서 객체에 반영
  		var letter = document.getElementById('checkChar');
  		letter.innerHTML = remain;
  		};
</script>