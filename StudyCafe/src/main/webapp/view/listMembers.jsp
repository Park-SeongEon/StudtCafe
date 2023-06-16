<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

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
<c:choose>
	<c:when test='${msg=="deleted"}'>
		<script>
			window.onload = function () {
				alert("회원 정보를 삭제했습니다.");
			}
		</script>
	</c:when>
</c:choose>
</style>
</head>
<body>


	<div id="viewport">

		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="top.jsp"></jsp:include>
			<div class="container-fluid">
				<h1>List</h1>
				<div class="container">
					<div class="row">
						<form method="post" name="search" >
							<table class="pull-right">
								<tr>
									<td>
										<select class="form-control" name="searchField">
											<option value="0">선택</option>
											<option value="user_name">이름</option>
											<option value="userID">아이디</option>
										</select>
									</td>
									<td><input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>
									<td><button type="submit" class="btn btn-success">검색</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<br>
				<div class="container">
					<div class="row">
						<table class="active table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #2e8b57; text-align: center;">번호</th>
									<th style="background-color: #2e8b57; text-align: center;">아이디</th>
									<th style="background-color: #2e8b57; text-align: center;">이름</th>
									<th style="background-color: #2e8b57; text-align: center;">Email</th>
									<th style="background-color: #2e8b57; text-align: center;">연락처</th>
									<th style="background-color: #2e8b57; text-align: center;">가입일</th>
									<th style="background-color: #2e8b57; text-align: center;">최근접속일</th>
									<th style="background-color: #2e8b57; text-align: center;">회원등급</th>
									<th style="background-color: #2e8b57; text-align: center;">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${list ==null }">
										<tr height="10">
											<td colspan="4">
												<p align="center">
													<b><span style="font-size: 9pt;">등록된 회원이 없습니다.</span></b>
												</p>
											</td>
										</tr>
									</c:when>
									<c:when test="${list !=null }">
										<c:forEach var="item" items="${list }" varStatus="articleNum">
											<tr align="center">
												<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
												<td width="5%">${articleNum.count}</td>
												<td width="20%">${item.userId}</td>
												<td width="15%">${item.userName}</td>
												<td width="20%">${item.userEmail}</td>
												<td width="10%">${item.userCp}</td>
												<td width="10%">${item.regDate}</td>
												<td width="10%">${item.joinDate}</td>
												<td width="5%">${item.userGrade}</td>
												<td width="5%" colspan="2"><input type="button" value="삭제" onclick="location.href='${contextPath}/admin/remove.do?id=${item.userId}'"></td>
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