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
	<script src="<c:url value="/js/bootstrap.js"/>"></script>
	<script src="../../js/sidebar.js"></script>
	<script src="../../js/list.js"></script>

<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
	<title>Study & Cafe</title>

</head>
<body>
	<div id="viewport">
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="../common/top.jsp"></jsp:include>
			<div class="main_back">
				<div class="container">
					<h1 style="font-family: Namum">${katTargetName}</h1>
					<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>
					<form id="frmSearch" method="post" name="search">
						<table class="pull-right">
							<tr>
								<td>
									<select class="form-control" name="searchId">
										<option value="title">제목</option>
										<option value="user_id">작성자</option>
									</select>
								</td>
								<td><input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"><input type="hidden" value="${katTargetNo}" name="katNo"></td>
								<td><button type="button" id="search" class="btn btn-white btn-dark">검색</button></td>
								<td>
									<%-- <a href="${contextPath}/board/Form.do?katNo=${katTargetNo}" class="btn btn-success pull-right" data-toggle="modal" data-target="#myModal">모달 열기</a> --%>
									<a href="#" data-toggle="modal" data-target="#myModal"  class="btn back-blue2 addbtn pull-right">글쓰기</a>
								</td>
							</tr>
						</table>
					</form>
					<div id="baordList">
						<jsp:include page="list.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" role="dialog">
		<form action="${contextPath}/board/add.do" method="post">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header back-blue">
						<span class="font-nanum">글작성</span>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="modal-title" class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<tr>
								<td>제목</td>
								<td><input class="form-control" name="title" type="text"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea class="form-control" name="content" rows="10"></textarea></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<!--  <button id="modalSubmit" type="button" class="btn btn-success">Submit</button> -->
						<button class="btn btn-success pull-right" type="submit">작성</button>
						<input type="hidden" size="67" maxlength="500" name="katNo" value="${katTargetNo}" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>