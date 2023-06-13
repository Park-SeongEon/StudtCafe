<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



	<!-- Sidebar -->
	<div id="sidebar">
		<header>
			<a href="${contextPath}/main/main.do">Study Cafe</a>
		</header>
		<ul class="nav">
			<li class="active"><a href="${contextPath}/main/main.do"><i class="zmdi zmdi-view-dashboard"></i> Dashboard</a></li>
			<c:forEach var="item" items="${katlist}">
				<li><a href="${contextPath}/board/list.do?katNo=${item.kateNo}">${item.kateName}</a></li>
			</c:forEach>
			<li><a href="${contextPath}/admin/list.do?">공지사항</a></li>
			<li><a href="${contextPath}/admin/memberlist.do?${item.kateNo}">유저목록</a></li>
		</ul>
	</div>
