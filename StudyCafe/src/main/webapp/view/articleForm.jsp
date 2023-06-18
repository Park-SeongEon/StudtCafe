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
<script src="https://code.jquery.com/jquery-latest.js"></script>

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
				<h1>글쓰기</h1>
				<div class="container">
				    <div class="input-form-backgroud row">
				      <div class="input-form col-md-12 mx-auto">
				        <h4 class="mb-3">게시판</h4>
				        <form name="articleForm" method="post"   action="${contextPath}/board/mod.do?brdNo=${item.brdNo}"   enctype="multipart/form-data">
				          <div class="row">
				            <div class="col-md-6 mb-3">
				              <label for="name">제목</label>
				              <input type="text" class="form-control" id="name" placeholder="" value="${item.brdNo}" required>
				            </div>
				            
				          </div>      
				
				          <div class="mb-3">
				            <label for="address2">글쓰기<span class="text-muted">&nbsp;(필수 아님)</span></label>
							<input class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" value="${item.brdNo}" >
				          </div>
				
				          <hr class="mb-4">
				        
				          <div class="mb-4">				          
					          <button class="btn btn-success pull-right"  type="submit">작성</button>
					  		  <input type="hidden" size="67"  maxlength="500" name="katNo" value="${katTargetNo}" />
					  		  
					  		  <button class="btn btn-success pull-right"  type="button">목록보기</button>
					  		  <input type="hidden" size="67"  maxlength="500" name="katNo" value="${katTargetNo}" onClick="backToList(this.form)" />
				          </div>
				        </form>
				      </div>
				    </div>
				    <footer class="my-3 text-center text-small">
						<form action="replyForm.do" method="post">
							<%-- <input type="hidden" name="postId" value="<%= postId %>"> --%>
							<textarea name="replyContent" rows="4" cols="50" placeholder="Write your reply here"></textarea>
							<br>
							<input type="submit" value="Submit">
						</form>
				      <p class="mb-1">&copy; 2023 YD</p>
				    </footer>
				  </div>
				
				
			</div>
		</div>
	</div>
				
				
				
			</div>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>