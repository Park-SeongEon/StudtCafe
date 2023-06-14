<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!doctype html>

<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="Author" content="silverline">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>회원가입</title>

<link rel="stylesheet" href="../css/join.css" />

<script>

function verify(form){
 if(!form.userID.value){
  alert('아이디 필수입력');

  form.userID.focus();

  return;

 }
 

 else{

  //중복검사를 했는지 체크하는 부분

  if(form.checkID.value != "yes"){

   alert('아이디 중복체크해주세요..');

   return;

  }

 }

 

 /*if(!form.userPW.value){

  alert('비밀번호 필수입력');

  form.userPW.focus();

  return;

 }*/

 if(!/[^\s]{4,}/.test(form.userPW.value)){

  alert('비밀번호 필수입력항목');

  form.userPW.focus();

  return;

 }

 if(!form.userPW2.value ||form.userPW.value !=form.userPW2.value){

  alert('비밀번호확인 필수입력');

  form.userPW2.focus();

  return;

 }

 if(!form.name.value){

  alert('이름 필수입력');

  form.name.focus();

  return;

 }

 form.submit();

}

function CheckPW(form){

 //비밀번호확인

 //alert(event.keyCode); //어떤 키보드가 눌렸는지 확인할때 사용함

 if(!form.userPW.value){

  alert('비밀번호를 입력해주세요');

  form.userPW2.value = "";

  form.userPW.focus();

  return;

 }

 if(form.userPW.value.length == form.userPW2.value.length){

  if(form.userPW.value ==form.userPW2.value){

   form.name.focus();

  }

  else{

   alert('비밀번호가 일치하지 않습니다.');

   form.userPW.value="";

   form.userPW2.value="";

   form.uwerPW.focus();

   //form.userPW2.value="";

   //form.uwerPW.focus();

  }

 }

}

​

function CheckDup(){

 //아이디 중복확인

 

 if(!document.joinus.userID.value){

  alert('아이디 입력후 중복검사를 해주세요.')

  document.joinus.userID.focus();

  return;

 }

 var w=340;

 var h= 140;

 var x = (screen.width-w) /2;

 var y = (screen.height-h) /2;

 window.open('member/list.do?id='+ document.joinus.userID.value,'check', 'left=' + x + ', top=' + y + ', width=' + w + ', height=' + h);

}

</script>

</head>

<body>

	<form name="joinus" method="post" action="/member/login.do">

		<input type="hidden" name="checkID" value="no" />
		<!--중복검사를 위한 위해 checkID변수에 no라는 값을 입력-->

		<div class="joinBox">

			<h1 class="tit">회원가입</h1>

			<div class="AlignRight MAT30">
				<span class="blet">* </span>표시는 필수입니다.
			</div>

			<table class="table_row W100P MAT10">

				<colgroup>

					<col style="">

					<col style="">

				</colgroup>

				<tr>

					<th><span class="blet">*</span> 아이디</th>

					<td><input type="text" name="userID" size="20" maxlength="16" />
						<input type="button" value="중복 검사" onClick="CheckDup();"
						class="btnDup"></td>

				</tr>

				<tr>

					<th><span class="blet">*</span> 비밀번호</th>

					<td><input type="password" name="userPW" size="20"
						maxlength="16" /> <span class="f12 fC666">※ 8~16글자의 영어 또는
							숫자 혼용</span></td>

				</tr>

				<tr>

					<th><span class="blet">*</span> 비밀번호 확인</th>

					<td><input type="password" name="userPW2" size="20"
						maxlength="16" onKeyup="CheckPW(this.form);" /></td>

					<!--onKeypress, onKeyDown, onKeyup-->

				</tr>

				<tr>

					<th><span class="blet">*</span> 이름</th>

					<td><input type="text" name="name" size="15" maxlength="6" /></td>

				</tr>

				<tr>

					<th>전화</th>

					<td><input type="text" name="tel" size="15" maxlength="15" /></td>

				</tr>

				<tr>

					<th>이메일</th>

					<td><input type="text" name="email" size="30" maxlength="40" /></td>

				</tr>
				
					<tr>

					<th>주소</th>

					<td><input type="text" name="email" size="30" maxlength="40" /></td>

				</tr>

			</table>

			</table>

			<div class="btnZone">

				<input type="button" onClick="verify(this.form);" class="btnOk"
					value="확인"> <input type="button" onClick="history.go(-1);"
					class="btnC" value="뒤로">

			</div>

		</div>

	</form>

</body>

</html>

​
