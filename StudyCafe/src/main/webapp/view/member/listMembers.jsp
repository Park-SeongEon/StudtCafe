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
	<link rel="stylesheet" href="../../css/bootstrap.css">
	<link rel="stylesheet" href="../../css/sidebar.css">
	<link rel="stylesheet" href="../../css/list.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Study & Cafe</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

</style>
<c:choose>
	<c:when test='${msg=="deleted"}'>
		<script>
			window.onload = function () {
				alert("회원 정보를 삭제했습니다.");
			}
		</script>
	</c:when>
</c:choose>

</head>
<body>
	<div id="viewport">
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="../common/top.jsp"></jsp:include>
			<div class="main_back">
				<div class="container">
					<h1 style="font-family: Namum">회원 목록</h1>
					<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>
					<form method="post" name="search">
						<table class="pull-right">
							<tr>
								<td>
									<select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="bbsTitle">제목</option>
										<option value="userID">작성자</option>
									</select>
								</td>
								<td>
									<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>
								<td><button type="button" class="btn btn-white btn-dark">검색</button></td>
							</tr>
						</table>
					</form>
					<div id="memberList">
						<jsp:include page="member_list.jsp"></jsp:include>
					</div>
					

				</div>
			</div>
		</div>
	</div>

	<script src="../../js/bootstrap.js"></script>
</body>
</html>