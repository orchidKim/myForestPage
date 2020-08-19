<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>
	<%-- 
	<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/admin/memberList.do'">
	<input type="button" value="공지사항 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList.do'">
	<input type="button" value="Q&A관리" onclick="location.href='${pageContext.request.contextPath}/adminQna/adminQuestAnswerList.do'">
	<input type="button" value="댓글관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList.do'">
	<input type="button" value="휴양림 관리" onclick="location.href='${pageContext.request.contextPath}/admin/adminForestList.do'"> --%>

<div class="page-main-style">

	<h2>공지사항</h2>

	 <div class="search">
      <form action="adminBoardList.do" id="noticePage_src" method="get">
      <input type="text" id="keyword" name="keyword" placeholder="제목으로만 검색이 가능합니다">
      <button type="submit" id="boardList-srcBtn">검색</button>
      </form>
   </div>

	<c:if test="${count == 0 }">
		<!-- <div class="result-display">등록된 공지사항이 없습니다.</div> -->
		<table>
		<tr>
			<th>번호</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tr>
			<td colspan="5">작성된 공지사항이 없습니다.</td>
		</tr>
		
		</table>
	</c:if>
	
	<div class="wrap">
  
		
	<c:if test="${count > 0 }">
	<table>
		<tr>
			<th>번호</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th><input type="checkbox" id="allchecked" style="width:20px;height:20px;"></th>
		</tr>
		
		<c:forEach var="notice" items="${list}">
		<tr>
			<td>${notice.n_num}</td>
			<td><a href="${pageContext.request.contextPath}/admin/adminBoardModify.do?n_num=${notice.n_num}">${notice.n_title}</a></td>
			<td>${notice.id}</td>
			<td>${notice.reg_date}</td>
			<td>${notice.n_hit}</td>
			<td><input type="checkbox" style="width:20px;height:20px;" class="checkbox" name="n_num" value="${notice.n_num}"></td>
		</tr>
		</c:forEach>
		
		</table>
		</c:if>
		<div class="align-right" style="float:right;margin-top:30px;">
			<input type="button" value="공지사항 등록" onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardWrite.do'">
			<input type="button" value="삭제" id="delete-btn" class="delete-btn" data-num="">
		</div>
		<br>
		<div class="align-center pagenum">${pagingHtml}</div>
	</div>
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
      
      if (checkArray == ''  && checkArray == 0) {
         alert('최소한 1개는 선택해야합니다.');
      } 
      if(checkArray != ''  && checkArray != 0){
         var delete1 = confirm("삭제 하시겠습니까?");
         if(delete1 == false){
            return false;
         }else{
            location.href='${pageContext.request.contextPath}/admin/adminBoardDelete.do?num='+$(this).attr('data-num');
         }
      }
      });
</script>