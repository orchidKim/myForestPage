<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="page-main-style">
	<h2 class="memberView-title">회원상세정보</h2>
	
	<table border="1" class="memberView-table" >
		<colgroup>
       	  <col width="20%" />
          <col width="30%" />
          <col width="20%" />
          <col width="30%" />
		</colgroup>
		<tr>
			<th>아이디</th>
			<td>${member.id}</td>
			<th>이름</th>
			<td>${member.name}</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${member.phone}</td>
			<th>이메일</th>
			<td>${member.email}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td colspan="3">${member.address}</td>
		</tr>
	</table>
	<div class="memberView-btn">
		<input type="button" value="회원정보수정" id="memberView-btn1" onclick="location.href='update.do'">
		<input type="button" value="회원탈퇴" onclick="location.href='delete.do'"> 
	</div>
</div>







