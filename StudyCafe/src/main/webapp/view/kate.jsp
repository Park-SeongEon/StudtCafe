<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("cache-control","no-store");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">

<link rel="stylesheet" href="../css/sidebar.css">




<link rel="stylesheet" href="../css/custom.css">

<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>


	<div id="viewport">

		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="top.jsp"></jsp:include>
			<div class="container-fluid">
				<h1>카테고리</h1>
				
				<br>
				<div class="container">
					<div class="row">
						<table class="active table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #2e8b57; text-align: center;">번호</th>
									<th style="background-color: #2e8b57; text-align: center;">카테고리명</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${list ==null }">
										<tr height="10">
											<td colspan="4">
												<p align="center">
													<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
												</p>
											</td>
										</tr>
									</c:when>
									<c:when test="${list !=null }">
										<c:forEach var="item" items="${list }" varStatus="articleNum">
											<tr align="center">
												<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
												<td width="5%">${articleNum.count}</td>
												<td width="10%">${item.kateName}</td>
												<td colspan="2" ><input type="button" value="삭제" onclick="location.href='${contextPath}/admin/remove2.do?brd_no=${articleNum.count}'"></td>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>