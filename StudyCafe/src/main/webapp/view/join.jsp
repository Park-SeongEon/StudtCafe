<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><c:set var="contextPath"
	value="${pageContext.request.contextPath}" />
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

	var form = document.joinForm;
	
	function join(){
		//value를 조건식 안에서 사용하면
		//값이 있을 때 true, 값이 없을 때 false
		if(!form.id.value){
			alert("아이디를 입력해주세요.");
			form.id.focus();
			return;
		}
		if(form.userID.value.length < 4 || form.userID.value.length > 16){
			alert("아이디는 4자 이상, 16자 이하로 입력해주세요.")
			form.id.focus();
			return;
		}
		if(!form.name.value){
			alert("이름을 입력해주세요.");
			form.name.focus();
			return;
		}
		if(!form.password.value){
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
			return;
		}
		
		//8자리 이상, 대문자, 소문자, 숫자, 특수문자 모두 포함되어 있는 지 검사
		let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		let hangleCheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/
		
		if(!reg.test(form.password.value)){
			alert("비밀번호는 8자리 이상이어야 하며, 대문자/소문자/숫자/특수문자 모두 포함해야 합니다.");
			form.password.focus();
			return;
		}
		
		//같은 문자를 4번 사용할 수 없다.
		if(/(\w)\1\1\1/.test(form.password.value)){
			alert("같은 문자를 4번 이상 사용하실 수 없습니다.");
			form.password.focus();
			return;
		}
		
		//비밀번호 안에 아이디가 있을 때
		if(form.password.value.search(form.id.value) != -1){
			alert("비밀번호에 아이디를 포함할 수 없습니다.");
			form.password.focus();
			return;
		}
		
		//비밀번호에 한글이 있으면 안된다.
		if(hangleCheck.test(form.password.value)){
			alert("비밀번호에 한글을 사용할 수 없습니다.");
			form.password.focus();
			return;
		}
		
		//비밀번호에 공백을 포함할 수 없다.
		if(form.password.value.search(/\s/) != -1){
			alert("비밀번호에 공백 없이 입력해주세요.");
			form.password.focus();
			return;
		}
		
		if(form.password.value != form.password_re.value){
			alert("비밀번호를 확인해주세요.");
			form.password.focus();
			return;
		}
		
		if(!form.id.readOnly){
			alert("아이디 중복 검사를 진행해주세요.");
			return;
		}
		form.submit();
	}
	
	$("input[name='userID']").on("click", function(){
		form.id.readOnly = false;
	})
	
	function checkId(){
		var xhr = new XMLHttpRequest();
		
		xhr.open("GET", "join_ok.jsp?id=" + document.getElementById("id").value, true);
		xhr.send();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				document.getElementById("result").innerHTML = xhr.responseText.trim();
				if(xhr.responseText.search("가능") != -1){
					form.id.readOnly = true;
				}
			}
		}
	}

</script>
</head>
<body>
	<form name="joinForm" method="post" action="/member/save.do">
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
					<td><input type="text" name="userID" size="20" maxlength="16" /><input
						type="button" value="중복 검사" onClick="CheckDup();" class="btnDup"></td>
				</tr>
				<tr>
					<th><span class="blet">*</span> 비밀번호</th>
					<td><input type="password" name="userPW" size="20"
						maxlength="16" /> <span class="f12 fC666">※ 8~16글자의 영어
							또는숫자 혼용</span></td>
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
