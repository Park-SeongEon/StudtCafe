<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>


	<nav class="navbar navbar-inverse">
		<div class ="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${contextPath}/main/main.do">StudyCafe📕</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="${contextPath}/main/main.do">main</a></li>
				<c:forEach var="item" items="${katlist}">
					<li><a href="${contextPath}/board/list.do?katNo=${item.kateNo}">${item.kateName}</a></li>
				</c:forEach>
				<li><a href="${contextPath}/admin/list.do?">공지사항</a></li>
				<li><a href="${contextPath}/admin/memberlist.do?${item.kateNo}">유저목록</a></li>

			</ul>
			<c:choose>
				<c:when test="${empty session.userId }">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul>
						</li>
					</ul>
				</c:when>
				<c:when test="${!empty session.userId }">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">회원관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="logoutAction.jsp">로그아웃</a></li>
								<li><a href="userUpdate.jsp">내 정보</a></li>
							</ul>
						</li>
					</ul>
				</c:when>
			</c:choose>			
		</div>
	</nav>