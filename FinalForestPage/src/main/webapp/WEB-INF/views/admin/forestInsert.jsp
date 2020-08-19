<%@ page language="java" contentType="text/html;  charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<!-- 등록 데이터 입력 여부 및 길이 확인 시작 -->
<script type="text/javascript">
 $(document).ready(function(){
    $('#insertForestForm').submit(function(){
    	if($('#p_name').val()=='' || $('#p_name').val().length > 10){
            alert('10자 이내로 휴양림명을 입력하세요');   $('#p_name').focus();return false;
         }
       if($('#p_count').val()==''){
            alert('수용가능인원을 입력하세요');$('#p_count').focus();return false;
         }
       if($('#p_cost').val()=='' || $('#p_cost').val().length > 50){
            alert('50자 이내로 입장료를 입력하세요');$('#p_cost').focus();   return false;
         }
       if($('#p_stay').val()=='' || ($('#p_stay').val() != 'Y' && $('#p_stay').val() != 'N')){
            alert('[Y/N]로 숙박가능여부 입력하세요');$('#p_stay').focus();return false;
         }
       if($('#p_facility').val()=='' || $('#p_facility').val().length > 30){
            alert('30자 이내로 주요시설을 입력하세요');   $('#p_facility').focus();return false;
         }
       if($('#p_load').val()==''){
            alert('소재지를 입력하세요');$('#p_load').focus();return false;
         }
       if($('#p_phone').val()==''){
            alert('전화번호를 입력하세요');   $('#p_phone').focus();return false;
         }
       if($('#p_web').val()==''){
            alert('홈페이지 주소를 입력하세요');$('#p_web').focus();return false;
         }
       if($('#p_latitude').val()==''){
            alert('위도를 입력하세요');$('#p_latitude').focus();return false;
         }
       if($('#p_longitude').val()==''){
            alert('경도를 입력하세요');$('#p_longitude').focus();   return false;
         }
    });// $('#insertForestForm').submit
 });//$(document).ready
</script>
<!-- 등록 데이터 입력 여부 및 길이 확인 끝-->


<div class="page-main-style">

<h2>새 휴양림 등록</h2>
   <form:form action="forestInsert.do" enctype="multipart/form-data" commandName="forestVO" method="post" id="insertForestForm">
      <ul>
         <li>
           <label>휴양림명</label><input type="text" name="p_name" id="p_name" value="tmp 휴양림">
         </li>
         <li>
            <!-- 시도명 --><input type="hidden" name="p_city" id="p_city" value="시도명">
         </li>
         <li>
            <!-- 구분 --><input type="hidden" name="p_div" id="p_div" value="구분">
         </li>
         <li>
            <!-- 면적 --><input type="hidden" name="p_size" id="p_size"value="100">
         </li>
         <li>
             <label>수용가능인원</label><input type="number" name="p_count" id="p_count" value="100">
         </li>
         <li>
             <label>입장료</label><input type="text" name="p_cost" id="p_cost" value="성인 : 1,000원">
         </li>
         <li>
             <label>숙박가능여부[Y/N]</label><input type="text" name="p_stay" id="p_stay" value="Y">
         </li>
         <li>
             <label>주요시설</label><input type="text" name="p_facility" id="p_facility" value="tmp 주요시설">
         </li>
         <li>
             <label>소재지</label><input type="text" name="p_load" id="p_load" value="tmp 소재지도로명주소">
            <input type="button" value="주소검색" id="findAdress">
         </li>
         <li>
            <!-- 관리기관명 --><input type="hidden" name="p_pubnum" id="p_pubnum" value="관리기관명">
         </li>
         <li>
             <label>전화번호</label><input type="text" name="p_phone" id="p_phone" value="010-1111-1111"> 
         </li>
         <li>
             <label>홈페이지 주소</label><input type="text" name="p_web" id="p_web" value="tmp.com">
         </li>
         <li>
             <label>위도</label><input type="number" name="p_latitude" id="p_latitude" value="1000">
         </li>
         <li>
             <label>경도</label><input type="number" name="p_longitude" id="p_longitude" value="1000">
         </li>
         <li>
            <!-- 데이터 기준일자 --><input type="hidden" name="p_regdate" id="p_regdate" value="20/08/01">
         </li>
         <li>
            <!-- 제공기관 코드 --><input type="hidden" name="p_code" id="p_code" value="제공기관코드">
         </li>
         <li>
            <!-- 제공기관명 --><input type="hidden" name="p_pubname" id="p_pubname" value="제공기관명">
         </li>
         <li>
             <label>휴양림 이미지</label><input type="file" name="img_path">
         </li>
      </ul>
         <input type="submit" value="등록" style="margin:0 auto;display:block;">
   </form:form>
   </div>
   
   

<!-- 다음 주소검색 팝업창 코드 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* 주소 입력창이 공백이 아닐 때 */
	$('#p_load').focus(function(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            document.getElementById('p_load').value = data.address;
	        }
	    }).open();
		$('#p_load').blur();
	});
	
	
	/* 주소검색 버튼을 클릭했을 떄 */
	$('#findAdress').click(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            document.getElementById('p_load').value = data.address;
	        }
	    }).open();
	});
	
</script>
<!-- 다음 주소검색 팝업창 코드 끝 -->   