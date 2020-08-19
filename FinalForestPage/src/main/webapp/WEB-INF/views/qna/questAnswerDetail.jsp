<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="page-main-style">
   <h2>Q&amp;A</h2>
   <table border="1" class="qna-detail-mainTable">
            <colgroup>
                     <col width="15%" class="s"/>
                    <col width="85%" />
            </colgroup>
            <tr>
               <th>번호</th>
               <td>${questAnswerVO.q_num}</td>
            </tr>
            <tr>
               <th>작성일</th>
               <td>${questAnswerVO.q_reg_date}</td>
            </tr>
            <tr>
               <th>최근 수정일</th>
               <td>${questAnswerVO.q_modify_date}</td>
            </tr>
            <tr>
            	<th>조회수</th>
            	<td>${questAnswerVO.q_hit}</td>
            </tr>
            <tr>
               <th>작성자</th>
               <td>${questAnswerVO.id}</td>
            </tr>
            <tr>
               <th>제목</th>
               <td>${questAnswerVO.q_title}</td>
            </tr>
   </table>
   
   <!-- size=두께 -->
   <hr size="1" width="100%">
   <p id="qna-question">
      ${questAnswerVO.question}
   </p>
   <hr size="1" width="100%">
   
   <div class="align-right">
      <%-- 글 수정 및 삭제를 하려면 로그인 후 로그인 아이디와 작성자 아이디가 일치해야하고, 관리자 답변이 수정이나 삭제가 안되어 있어야함. --%>
      <c:if test="${!empty user_id && user_id == questAnswerVO.id &&
               fn:contains(questAnswerVO.answer, 'no answer')}">
         <input type=button value="수정" onclick="location.href='update.do?num=${questAnswerVO.q_num}'">
         <input type=button value="삭제" onclick="location.href='delete.do?num=${questAnswerVO.q_num}'">
      </c:if>
         <input type=button value="목록" onclick="location.href='questAnswerList.do'">                  
   </div>
   <br>
   <br>
   <br>
   <h2>관리자 답변</h2>   
      <table border="1" class="qna-detail-subTable">
         <tr>
            <th>작성자</th>
            <th class="answer_area">답변 내용</th>
            <th>작성일</th>
            <th>수정일</th>
         </tr>
         <tr>
         <td>관리자</td>
         <c:choose>
            <c:when test="${fn:contains(questAnswerVO.answer, 'no answer')}">
               <td>관리자님이 답변을 작성 중입니다. 조금만 기다려주세요.</td>
            </c:when>
            <c:otherwise>
               <td>${questAnswerVO.answer}</td>
            </c:otherwise>
         </c:choose>
         <td>${questAnswerVO.a_reg_date}</td>
         <td>${questAnswerVO.a_modify_date}</td>
      </tr>
      </table>
   
</div>