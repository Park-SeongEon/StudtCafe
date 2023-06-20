<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



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
			  })
			  
			  
			})
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
		<nav>
			<div class="container-fluid">
				<ul class="nav navbar-nav navbar-right">

					<div id="btn">
						여기를 눌러주세용

						<div id="slideTogglebox">슬라이드토글은 이렇겝니다</div>
					</div>

					<%-- 
					<li><a href="#"><i
							class="zmdi zmdi-notifications text-danger"></i> </a></li>
					<li><a href="#">${userId}</a></li>
					<li><a href="/member/updatefrom.do">회원정보수정</a></li>
					<li><a href="/member/logout.do" onclick="toggleLogout()"><span
							id="logoutText">로그아웃</span></a></li>
							
							 --%>
				</ul>
			</div>
		</nav>
	</c:when>
</c:choose>



<div class="top">
	<span class="font-nanum">메뉴 / </span> <a class="font-nanum font-blue">${katTargetName}
	</a>
</div>
