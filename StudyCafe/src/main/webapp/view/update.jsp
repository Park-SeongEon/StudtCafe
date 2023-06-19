<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
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
<title>회원정보 수정</title>
<link rel="stylesheet" href="../css/join.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            daum.postcode.load(function () {
                new daum.Postcode({
                    oncomplete: function (data) {
                        var fullAddr = data.address; // 최종 주소 변수
                        var extraAddr = ''; // 조합형 주소 변수

                        // 기본 주소와 조합형 주소를 동일하게 설정
                        document.getElementById("user_addr").value = fullAddr;

                        // 기본 주소가 도로명 타입일 때 조합형 주소 설정
                        if (data.addressType === 'R') {
                            // 법정동명이 있을 경우 추가
                            if (data.bname !== '') {
                                extraAddr += data.bname;
                            }
                            // 건물명이 있을 경우 추가
                            if (data.buildingName !== '') {
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 조합형 주소를 추가
                            fullAddr += ' (' + extraAddr + ')';
                        }

                        // 주소 정보 입력 필드에 값 설정
                        document.getElementById("user_addr").value = fullAddr;
                    }
                }).open();
            });
        }

	function update() {
		var form = document.updateForm;

		if (!form.userPW.value) {
			alert("비밀번호를 입력해주세요.");
			form.userPW.focus();
			return;
		}

		// 비밀번호 유효성 검사 로직 추가
		var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
		if (!passwordRegex.test(form.userPW.value)) {
			alert("비밀번호는 8자리 이상이어야 하며, 영문/숫자 모두 포함해야 합니다.");
			form.userPW.focus();
			return;
		}

		if (form.userPW.value !== form.userPW2.value) {
			alert("비밀번호를 확인해주세요.");
			form.userPW2.focus();
			return;
		}

		if (!form.name.value) {
			alert("이름을 입력해주세요.");
			form.name.focus();
			return;
		}
		

		form.submit();
	}
</script>
</head>
<body>
	<form name="updateForm" method="post" action="${contextPath}/member/update.do">
		<div class="joinBox">
			<h1 class="tit">회원정보 수정</h1>
			<table class="table_row W100P MAT10">
				<colgroup>
					<col style="">
					<col style="">
				</colgroup>
				<tr>
					<th><span class="blet">*</span> 비밀번호</th>
					<td><input type="password" name="userPW" size="20" maxlength="16" />
						<span class="f12 fC666">※ 8~16글자의 영어, 숫자 혼용</span>
					</td>
				</tr>
				<tr>
					<th><span class="blet">*</span> 비밀번호 확인</th>
					<td><input type="password" name="userPW2" size="20" maxlength="16" /></td>
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
                <td>
                    <input type="text" id="user_addr" placeholder="주소" size="60">
                    <input type="button" onclick="execDaumPostcode()" value="주소 찾기"><br>
                </td>
				</tr>
					<tr>
					 <th>상세주소</th>
                <td>
                    <input type="text" id="user_addr2" placeholder="상세주소" size="20">
                </td>
					</tr>
			</table>
			<div class="btnZone">
				<input type="button" onClick="update();" class="btnOk" value="수정하기">
				<input type="button" onClick="history.go(-1);" class="btnC" value="뒤로">
			</div>
		</div>
	</form>
	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>