<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- Sidebar -->
	<div id="sidebar">
		<header>
			<a href="${contextPath}/main/main.do">			
				<!--<img src="../img/logo.png" width="120" height="60"></img>-->				 

				 Study Cafe
			</a>
		</header>
		<ul class="nav">
			<c:choose>
				<c:when test="${0 eq katTargetNo}">
					<li class="active"><a class="eng" href="${contextPath}/main/main.do"><i class="zmdi zmdi-view-dashboard"></i> Dashboard</a></li>
				</c:when>
				<c:otherwise>
					<li><a class="eng" href="${contextPath}/main/main.do"><i class="zmdi zmdi-view-dashboard"></i> Dashboard</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="item" items="${katlist}">
				<c:choose>
					<c:when test="${item.kateNo eq katTargetNo}">
						<li class="active"><a href="${contextPath}/board/list.do?katNo=${item.kateNo}">${item.kateName}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextPath}/board/list.do?katNo=${item.kateNo}">${item.kateName}</a></li>				
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${userId == 'admin'}">
				<c:choose>
					<c:when test="${1 eq katTargetNo}">
						<li class="active"><a href="${contextPath}/admin/list.do?katNo=1">공지사항</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextPath}/admin/list.do?katNo=1">공지사항</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${2 eq katTargetNo}">
						<li class="active"><a href="${contextPath}/admin/memberlist.do?katNo=2">회원목록</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextPath}/admin/memberlist.do?katNo=2">회원목록</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${100 eq katTargetNo}">
						<li class="active"><a href="${contextPath}/admin/kate.do?katNo=100">카테고리</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${contextPath}/admin/kate.do?katNo=100">카테고리</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>
