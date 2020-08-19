<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>
   <%-- <input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
   <input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
   <input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
   <input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
   <input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'"> --%>
<div class="page-main-style">
   <h2>Q&amp;A</h2>
   <form id="search_form" action="adminQuestAnswerList.do" method="get">
         <ul>
            <li>
               <select name="keyfield" >
                  <option value="q_title">제목</option>
                  <option value="question">내용</option>
                  <option value="id">id</option>
               </select>
            </li>
            <li>
               <input type="search" size="15" name="keyword" id="keyword">  
            </li> 
            <li><input type="submit" value="검색"></li>       
         </ul>         
      </form>
      <c:if test="${count == 0}">
         <!-- <div class="result-display">등록된 문의가 없습니다.</div> -->
         <table>
         	<tr>
               <th>번호</th>
               <th width="200">제목</th>
               <th>작성자</th>
               <th>답변여부</th>
               <th>작성일</th>
               <th>조회수</th>
            </tr>
            <tr>
            	<td colspan="6">작성된 Q&A 글이 없습니다.</td>
            </tr>
         
         </table>
      </c:if>
      <c:if test="${count > 0}">
         <table>
            <tr>
               <th>번호</th>
               <th width="200">제목</th>
               <th>작성자</th>
               <th>답변여부</th>
               <th>작성일</th>
               <th>조회수</th>
               <th><input type="checkbox" id="allchecked" style="width:20px;height:20px;"></th>
            </tr>
            <c:forEach var="qna" items="${list}">
               <tr>
                  <td>${qna.q_num}</td>
                  <td><a href="adminQuestAnswerDetail.do?num=${qna.q_num}">${qna.q_title}</a></td>
                  <td>${qna.id}</td>
                  <c:choose>
                     <c:when test="${qna.answer eq 'no answer'}">
                        <td>처리중</td>
                     </c:when>
                     <c:otherwise>
                        <td>처리완료</td>
                     </c:otherwise>
                  </c:choose>
                  <td>${qna.q_reg_date}</td>
                  <td>${qna.q_hit}</td>
                  <td><input type="checkbox" style="width:20px;height:20px;" class="checkbox" name="q_num" value="${qna.q_num}"></td>
               </tr>
            </c:forEach>
         </table>
         <div class="align-right" style="margin: 5px 0px;">
         <c:if test="${!empty user_id}">
            <input type="button"  style="float:right;margin-top:30px;" value="삭제" id="delete-btn" class="delete-btn" data-num="">
         </c:if>
      </div>
         <div class="align-center pagenum">${pagingHtml}</div>
      </c:if>
</div>


<script type="text/javascript">
$('#delete-btn').hide();
$('#allchecked').focus();

/* 선택되면 삭제버튼 나오게 하기  */
$('.checkbox').click(function(){
   if($(this).prop("checked")){
      $('#delete-btn').show();
   }
});
/* 전체선택  */
$('#allchecked').click(function(){
    if($(this).prop('checked')){
       $('.checkbox').prop('checked',true);
       $('#delete-btn').show();
   }else{
       $('.checkbox').prop('checked',false); 
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
      
      if(checkArray == ''  && checkArray == 0) {
         alert('최소한 1개는 선택해야합니다.');
         return false;
      }else if(checkArray != ''  && checkArray != 0){
         var delete1 = confirm("삭제 하시겠습니까?");
         if(delete1 == false){
            return false;
         }else{
         location.href='${pageContext.request.contextPath}/adminQna/delete.do?q_num='+$(this).attr('data-num');
         }
      }
   });
</script>