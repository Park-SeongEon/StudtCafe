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
<link rel="stylesheet" href="../css/main.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<div id="viewport">
		<!--SideBar  -->
		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<!--Top  -->
			<jsp:include page="top.jsp"></jsp:include>
			<div class="container-fluid">
				<div class="wrapper" style="text-align:center;margin-top: 10px;">
					<table style="width:80%">
						<tr>
						<c:forEach begin="0" end="8" varStatus="stat">
							<td>
								<div class="card">
									<div class="card-head">
										<p>좌석 ${stat.count}</p>
									</div>
									<div class="card-main">
										<p>빈자리</p>
									</div>
								</div>
							</td>
						</c:forEach>
						</tr>
						<tr>
						<c:forEach begin="9" end="17" varStatus="stat">
							<td>
								<div class="card">
									<div class="card-head">
										<p>좌석 ${stat.count}</p>
									</div>
									<div class="card-main">
										<p>빈자리</p>
									</div>
								</div>
							</td>
						</c:forEach>
						</tr>
					</table>
					<table style="width:80%">
						<tr>
							<c:forEach begin="1" end="3" varStatus="stat">
								<td>
									<div class="room">
										<div class="room-head">
											<p>룸 ${stat.count}</p>
										</div>
										<div class="room-main">
											<p>빈자리</p>
										</div>
									</div>
								</td>
							</c:forEach>
						<tr>
					</table>
					<%-- 통계영역 --%>
					
				</div>
			</div>
		</div><!-- Content End  -->
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/sidebar.js"></script>
</body>
</html>