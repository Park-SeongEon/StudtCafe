<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
${session.userId}
		<c:choose>
			<c:when test="${empty userId }">
				<nav class="navbar navbar-default">
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
	s		<nav class="navbar navbar-default">
					<div class="container-fluid">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><i class="zmdi zmdi-notifications text-danger"></i> </a></li>
							<li><a href="#">${userId}</a></li>
						</ul>
					</div>
				</nav>
			</c:when>
		</c:choose>
