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
	<script src="../../js/bootstrap.js"></script>
	<script src="../../js/sidebar.js"></script>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
	<title>JSP 게시판 웹 사이트</title>

</head>
<body>

	<div id="viewport">
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="../common/top.jsp"></jsp:include>
			<div class="main_back">
				<div class="container">
					<h1 style="font-family: Namum">공지사항</h1>
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
								<td>
									<%-- <a href="${contextPath}/board/Form.do?katNo=${katTargetNo}" class="btn btn-success pull-right" data-toggle="modal" data-target="#myModal">모달 열기</a> --%>
									<a href="#" data-toggle="modal" data-target="#myModal"  class="btn back-blue2 addbtn pull-right">글쓰기</a>
								</td>
							</tr>
						</table>
					</form>
					<div style="width:100%; height:70%; overflow:auto">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="active table1" style=" border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="text-align: center; vertical-align: middle;"></th>
									<th style="text-align: center; vertical-align: middle;">제목</th>
									<th style="text-align: center; vertical-align: middle;">내용</th>
									<th style="text-align: center; vertical-align: middle;">조회수</th>
									<th style="text-align: center; vertical-align: middle;">작성일</th>
									<th style="text-align: center; vertical-align: middle;">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${list ==null }">
										<tr height="10">
											<td colspan="6">
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
												<td width="5%">${item.rownum}</td>
												<td width="25%"><a href="${contextPath}/admin/view.do?brdNo=${item.brdNo}&katNo=${katTargetNo}">${item.title}</a></td>
												<td width="45%"><a href="${contextPath}/admin/view.do?brdNo=${item.brdNo}&katNo=${katTargetNo}">${item.content}</a></td>
												<td width="10%">${item.cnt}</td>
												<td width="10%">${item.regDate}</td>
												<td width="5%" colspan="2"><input type="button" value="삭제" onclick="location.href='${contextPath}/admin/remove.do?katNo=${katTargetNo}&brdNo=${item.brdNo}'"></td>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="text-center">
						<c:if test="${tot != null }">
							<ul class="pagination">
								<c:choose>
									<c:when test="${tot > 100 }">
										<c:forEach var="page" begin="1" end="10" step="1">
											<c:if test="${section > 1 && page==1 }">
												<li><a class="no-uline" href="/admin/list.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; prev </a></li>
											</c:if>
											<li><a class="no-uline" href="/admin/list.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
												
											<c:if test="${page ==10 }">
												<li><a class="no-uline" href="/admin/list.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;next</a></li>
											</c:if>
										</c:forEach>
									</c:when>
									<c:when test="${tot == 100 }">
										<c:forEach var="page" begin="1" end="10" step="1">
											<li><a class="no-uline" href="#">${page} </a><li>
										</c:forEach>
									</c:when>
						
									<c:when test="${tot< 100 }">
										<c:forEach var="page" begin="1" end="${tot/10 +1}" step="1">
											<c:choose>
												<c:when test="${page== pageNum }">
													<li><a class="sel-page" href="/admin/list.do?section=${section}&pageNum=${page}">${page } </a></li>
												</c:when>
												<c:otherwise>
													<li><a class="no-uline" href="/admin/list.do?section=${section}&pageNum=${page}">${page } </a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
								</c:choose>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" role="dialog">
		<form action="/admin/add.do" method="post">
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