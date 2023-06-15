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
											<option value="bbsTitle">제목</option>
											<option value="userID">작성자</option>
											
										</select>
									</td>
									<td><input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>
									<td><button type="submit" class="btn btn-dark">검색</button></td>
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
									<th style="background-color: #455A64; text-align: center;">번호</th>
									<th style="background-color: #455A64; text-align: center;">제목</th>
									<th style="background-color: #455A64; text-align: center;">글내용</th>
									<th style="background-color: #455A64; text-align: center;">작성자</th>
									<th style="background-color: #455A64; text-align: center;">작성일</th>
									<th style="background-color: #455A64; text-align: center;">추천수</th>
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
												<td width="10%"><a href="${contextPath}/board/view.do?brdNo=${item.brdNo}&katNo=${katTargetNo}">${item.title}</a></td>
												<td width="50%">${item.content}</td>
												<td width="10%">${item.cnt}</td>
												<td width="10%">${item.regDate}</td>
												<td width="10%">${item.voteNo}</td>
												
												  
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class=container style="text-align: center">	
				<a href="${contextPath}/board/Form.do?katNo=${katTargetNo}" class="btn btn-success pull-right" >글쓰기</a>				
			</div>	
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>