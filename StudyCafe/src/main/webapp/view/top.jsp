<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
		<c:choose>
			<c:when test="${empty userId }">
				<nav>
					<div class="container-fluid">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><i class="zmdi zmdi-notifications text-danger"></i> </a></li>
							<li><a href="/member/main.do">로그인</a></li>
							<li><a href="/member/main.do">회원가입</a></li>
						</ul>
					</div>
				</nav>
			</c:when>
			<c:when test="${!empty userId }">
<<<<<<< Updated upstream
	s		<nav class="navbar navbar-default">
=======
				<nav>
>>>>>>> Stashed changes
					<div class="container-fluid">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><i class="zmdi zmdi-notifications text-danger"></i> </a></li>
							<li><a href="#">${userId}</a></li>
						</ul>
					</div>
				</nav>
			</c:when>
		</c:choose>

		
		<div class="top">
			<span class="font-nanum">메뉴 / </span>
			<a class="font-nanum font-blue">${katTargetName} </a>	
		</div>
		