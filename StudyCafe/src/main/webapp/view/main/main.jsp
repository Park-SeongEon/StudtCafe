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
<link rel="stylesheet" href="<c:url value="/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/css/sidebar.css"/>">
<link rel="stylesheet" href="<c:url value="/css/main.css"/>">
<title>Study & Cafe</title>
</head>
<body>
	<div id="viewport">
		<!--SideBar  -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="../common/top.jsp"></jsp:include>
			<div class="main_back">			
				<div class="container">
					<h1 style="font-family: Namum; text-align: center;">좌석배치</h1>
					<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>
					<div class="wrapper" style="text-align:center;margin-top: 10px;">
						<table style="width:80%;margin-left: auto;margin-right: auto;">
							<tr> 
							<c:forEach items="${list}" var="item" begin="0" end="8" varStatus="stat">
								<td>
									<c:if test="${item.seatComment =='02'}">
										<div class="card active">
											<div class="card-head">
												<p>${item.seatTypeName} <span>${item.seatNo}</span> </p> 
											</div>
											<div class="card-main">
												<p>${item.seatCommentData}</p>
											</div>
										</div>		
									</c:if>
									<c:if test="${item.seatComment =='01'}">
										<div class="card">
											<div class="card-head">
												<p>${item.seatTypeName} <span>${item.seatNo}</span> </p> 
											</div>
											<div class="card-main">
												<p>${item.seatCommentData}</p>
											</div>
										</div>		
									</c:if>									
								</td>
							</c:forEach>
							</tr>
							<tr>
							<c:forEach items="${list}" var="item" begin="9" end="17" varStatus="stat">
								<td>
									<c:if test="${item.seatComment =='02'}">
										<div class="card active">
											<div class="card-head">
												<p>${item.seatTypeName} <span>${item.seatNo}</span> </p> 
											</div>
											<div class="card-main">
												<p>${item.seatCommentData}</p>
											</div>
										</div>		
									</c:if>
									<c:if test="${item.seatComment =='01'}">
										<div class="card">
											<div class="card-head">
												<p>${item.seatTypeName} <span>${item.seatNo}</span> </p> 
											</div>
											<div class="card-main">
												<p>${item.seatCommentData}</p>
											</div>
										</div>		
									</c:if>								
								</td>
							</c:forEach>
							</tr>
						</table>
						<table style="width:80%; margin-left: auto;margin-right: auto;">
							<tr>
								<c:forEach items="${list}" var="item" begin="18" end="21" varStatus="stat">
									<td>
										<div class="room">
											<div class="room-head">
												<p>${item.seatTypeName} ${item.seatNo}</p>
											</div>
											<div class="room-main">
												<p>${item.seatCommentData}</p>
											</div>
										</div>
									</td>
								</c:forEach>
							<tr>
						</table>
						<%-- 통계영역 --%>
						
					</div>

					<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>

					<table style="width:85%;margin-left: auto;margin-right: auto;">
						<colgroup>
							<col width="30%" />
							<col width="70%" />
						</colgroup>						
						<tbody>
							<tr>
								<td>
									<div class="statis">
									 	<div class="statis-head">
									    	<h2 class="statis-title" style="font-family: Namum;">좌석 현황</h2>
										</div>
									 	<div class="statis-body">
											<p class="title-1">남은좌석수</p>
											<p class="value-1">
												<fmt:formatNumber value="${statis.seatcnt}" type="number" />
											</p>
											<p class="title-2">좌석수</p>
											<p class="value-2">
												<fmt:formatNumber value="${statis.totalcnt}" type="number" />
											</p>
									  	</div>
									</div>								
								</td>
								<td>
									<div class="notice">
										<p class="title">최신글보기</p>
										<a href="${contextPath}/board/list.do?katNo=3" class="btn">더보기</a>
										<table class="notice-list">
											<tbody>
												<c:forEach var="item" items="${viewlist}" varStatus="rows">
													<tr>
														<td class="subject">
															<a href="${contextPath}/board/view.do?brdNo=${item.brdNo}&katNo=${3}" title="게시글 상세보기">${item.title}</a>
														</td>
														<td class="date">${item.userId}</td>
														<td class="date">${item.regDate}</td>
														<td class="date">${item.cnt}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<%-- 공지사항 --%>
				</div>
			</div>
		</div><!-- Content End  -->
		<input type="hidden" id="userId" name="userId" value="${userId}">
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="<c:url value="/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/js/main.js"/>"></script>
	
</body>
</html>