<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
		function toggleLogout() {
			var logoutText = document.getElementById("logoutText");
			if (logoutText.innerText === "로그아웃") {
				logoutText.innerText = "로그인";
				// TODO: 로그아웃 동작 추가
			} else {
				logoutText.innerText = "로그아웃";
				// TODO: 로그인 동작 추가
			}
		}

		$(document).ready(function(){
		  $('#btn').click(function(){
		    $('#slideTogglebox').slideToggle();
		  });
		});
	
	</script>
	
<!DOCTYPE html>

<link rel="stylesheet" href="../css/toggle.css" />
<c:choose>
	<c:when test="${empty userId }">
		<nav>
			<div class="container-fluid">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><i
							class="zmdi zmdi-notifications text-danger"></i> </a></li>
					<li><a href="/member/main.do">로그인</a></li>
					<li><a href="/member/join.do">회원가입</a></li>
				</ul>
			</div>
		</nav>
	</c:when>
	<c:when test="${!empty userId}">
        <div class="container-fluid">
            <ul class="nav navbar-nav navbar-right">
                <li id="btn"><a href="#">${userId}</a>
                    <ul id="slideTogglebox">
                        <li><a href="/member/updatefrom.do">회원정보수정</a></li>
                        <li><a href="/member/logout.do" onclick="toggleLogout()"><span id="logoutText">로그아웃</span></a></li>
                    </ul>
                </li>
            </ul>
        </div>
</c:when>
</c:choose>



<div class="top">
	<span class="font-nanum">메뉴 / </span> <a class="font-nanum font-blue">${katTargetName}
	</a>
</div>
