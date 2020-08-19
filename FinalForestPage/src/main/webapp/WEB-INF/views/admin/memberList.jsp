<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<%--    <input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
   <input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
   <input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
   <input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
   <input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'"> --%>
   
<div class="page-main-style">
   <h2>회원관리</h2>
   <form id="search_form" action="memberList.do" method="get">
      <ul class="search">
         <li><select name="keyfield">
               <option selected>==전체==</option>
               <option value="mem_num">회원번호</option>
               <option value="mem_id">회원아이디</option>
               <option value="mem_auth">회원상태</option>
         </select></li>
         
         <li><input type="search" size="16" name="keyword" id="keyword">
         </li>
         <li><input type="submit" value="검색"></li>
      </ul>
   </form>

   <c:if test="${count==0}">
      <div class="result-display">가입되어 있는 회원이 없습니다.</div>
   </c:if>
   <c:if test="${count>0}">
      <table>
         <tr>
            <th><input type="checkbox" id="allchecked" style="width: 20px; height: 20px;"></th>
            <th>회원번호</th>
            <th>회원아이디</th>
            <th>회원상태</th>
            <th>전환버튼</th>
         </tr>
         <c:forEach var="member" items="${list}">
            <!-- 체크박스열 -->
            <tr>
               <c:if test="${member.auth==1}">
                  <td><input type="checkbox" style="width: 20px; height: 20px;"
                     class="checkbox" name="n_num" value="${member.mem_num}"></td>
               </c:if>
               <c:if test="${member.auth==2}">
                  <td><input type="checkbox" style="width: 20px; height: 20px;"
                     class="checkbox" name="n_num" value="${member.mem_num}"></td>
               </c:if>
               <c:if test="${member.auth==3}">
                  <td></td>
               </c:if>
               <c:if test="${member.auth==0}">
                  <td></td>
               </c:if>
               <!-- 체크박스종료 -->

               <td>${member.mem_num}</td>
               <td>${member.id}</td>
               <c:if test="${member.auth==0}">
                  <td>탈퇴회원 (0)</td>
                  <td></td>
               </c:if>
               <c:if test="${member.auth==1}">
                  <td>정지회원 (1)</td>
                  <td><input type="button" value="일반회원 전환" onclick="location.href='authToTwo.do?mem_num=${member.mem_num}'" /></td>
               </c:if>
               <c:if test="${member.auth==2}">
                  <td>일반회원 (2)</td>
                  <td><input type="button" value="회원정지" onclick="location.href='authToOne.do?mem_num=${member.mem_num}'" /></td>
               </c:if>
               <c:if test="${member.auth==3}">
                  <td>관리자(3)</td>
                  <td></td>
               </c:if>
            </tr>
         </c:forEach>
      </table>
      <div class="align-right">
         <select id="authBox" onChange="selectChange()" style="vertical-align: middle; text-align-last:center;">
               <option selected >일괄전환</option>
               <option  id="authToTwo" >일반회원 전환</option>
               <option  id="authToOne" >정지회원 전환</option>
         </select>
            <%-- <input type="button" value="일반회원 전환" class="memberAuth" id="authToTwo" data-num="" />
            <input type="button" value="회원정지" class="memberAuth" id="authToOne"  data-num="" /> --%>
            <%-- <input type="button" value="일반회원 전환" onclick="location.href='authToTwo.do?mem_num=${member.mem_num}'" />
            <input type="button" value="회원정지" onclick="location.href='authToOne.do?mem_num=${member.mem_num}'" /> --%>
         </div>
      <div class="align-center pagenum">${pagingHtml}</div>
   </c:if>
</div>
<script type="text/javascript">
   /* 전체선택  */
   $('#allchecked').click(function(){
       if($(this).prop('checked')){
          $('.checkbox').prop('checked',true);
      }else{
          $('.checkbox').prop('checked',false); 
      } 
   });
   
   /* 체크박스 값 배열로 저장 */
   /*
   var total_cnt : 배열의 index 
   var checkArray : 다중체크박스 배열
   체크박스를 여러개 선택하면 배열로 저장한 뒤에  data-num 속성에 배열을 넣어주고 
   controller에서 반복문을 이용해서 num 값을 하나씩 빼서 삭제함. 
   */
   //회원 권한 변경 (관리자) : 1(정지회원) -> 2(일반회원)
   function selectChange() {
      var total_cnt = 0;
      var checkArray = new Array();
      $('.checkbox').each(function() {
         if (this.checked) {
            checkArray[total_cnt] = this.value;   
            total_cnt++;
         }
      });
      if (checkArray == ''  && checkArray == 0) {
         alert('최소한 1개는 선택해야합니다.');
         return false;
      } 
      
      if(checkArray != ''  && checkArray != 0){
            if($("#authBox option:selected").val()=='정지회원 전환'){//회원 권한 변경 (관리자) : 2(일반회원) -> 1(정지회원)
               var authToOne = confirm("일반회원을 정지회원으로 전환 하시겠습니까?");
               if(authToOne == false){
                  return false;
               }else{
                  document.getElementById('authToOne').setAttribute('value', checkArray);
                  location.href='${pageContext.request.contextPath}/admin/authToOne.do?mem_num='+$('#authToOne').attr('value');
               }
            }else if($("#authBox option:selected").val()=='일반회원 전환'){//회원 권한 변경 (관리자) : 2(정지회원) -> 1(일반회원)
               var authToTwo = confirm("정지회원을 일반회원으로 전환 하시겠습니까?");
                  if(authToTwo  == false){
                     return false;
                  }else{
                     document.getElementById('authToTwo').setAttribute('value', checkArray);
                     location.href='${pageContext.request.contextPath}/admin/authToTwo.do?mem_num='+$('#authToTwo').attr('value');
                  }
            }
      }
   }
</script>