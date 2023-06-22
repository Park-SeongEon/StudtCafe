<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("cache-control", "no-store");
response.setHeader("expires", "0");
response.setHeader("pragma", "no-cache");
%>
<html>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
<meta charset="UTF-8">
<title>글보기</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/sidebar.css">
<link rel="stylesheet" href="../../css/list.css">
<link rel="stylesheet" href="../../css/message.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../../js/bootstrap.js"></script>
<script src="../../js/sidebar.js"></script>
<script src="https://kit.fontawesome.com/def66b134a.js"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function backToList() {
		obj.action = "${contextPath}/board/list.do?katNo=3";
		obj.submit();
	}

	function fn_modify_artlce(obj, url) {

		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var parentNOInput = document.createElement("input");
		parentNOInput.setAttribute("type", "hidden");
		parentNOInput.setAttribute("name", "brdNo");
		parentNOInput.setAttribute("value", brdNo);
		var parentNOInput2 = document.createElement("input");

		parentNOInput2.setAttribute("type", "hidden");
		parentNOInput2.setAttribute("name", "content");

		parentNOInput2.setAttribute("value", $("#comment").val());

		form.appendChild(parentNOInput);
		form.appendChild(parentNOInput2);

		document.body.appendChild(form);
		form.submit();
	}

	function fn_remove_article(url, brdNo) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var brdNoInput = document.createElement("input");
		brdNoInput.setAttribute("type", "hidden");
		brdNoInput.setAttribute("name", "brdNo");
		brdNoInput.setAttribute("value", brdNo);
		form.appendChild(brdNoInput);
		document.body.appendChild(form);
		form.submit();
	}

	function fn_reply_form(url, brdNo) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var parentNOInput = document.createElement("input");
		parentNOInput.setAttribute("type", "hidden");
		parentNOInput.setAttribute("name", "brdNo");
		parentNOInput.setAttribute("value", brdNo);
		var parentNOInput2 = document.createElement("input");

		parentNOInput2.setAttribute("type", "hidden");
		parentNOInput2.setAttribute("name", "content");

		parentNOInput2.setAttribute("value", $("#i_content").val());

		
		var parentNOInput3 = document.createElement("input");

		parentNOInput3.setAttribute("type", "hidden");
		parentNOInput3.setAttribute("name", "title");

		parentNOInput3.setAttribute("value", $("#i_title").val());

		var parentNOInput4 = document.createElement("input");
		parentNOInput4.setAttribute("type", "hidden");
		parentNOInput4.setAttribute("name", "katNo");

		parentNOInput4.setAttribute("value", $("#katNo").val());

		
		
		form.appendChild(parentNOInput);
		form.appendChild(parentNOInput2);
		form.appendChild(parentNOInput3);
		form.appendChild(parentNOInput4);

		document.body.appendChild(form);
		form.submit();

	}
</script>

<style>
button-align {
	text-align: center;
}
</style>
</head>
<body>
	<div id="viewport">
		<!--SideBar  -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="../common/top.jsp"></jsp:include>
			<div class="main_back2">
				<div class="container">
					<form id="message-form" action="#" method="post" name="frmArticle"
						enctype="multipart/form-data">

						<div class="card" style="width: 100%;">
							<div class="card-body">
								<input type="text" value="${info.title}" name="title"
									id="i_title">

								<p class="card-text">
									<i class="fa-solid fa-user"></i>${userId}</p>
								<h6 class="card-subtitle mb-2 text-muted">등록일자 :
									${info.regDate} 조회수 : ${info.cnt}</h6>
							</div>
						</div>

						<div
							style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>


						<div class="group notice">
							<input type="text" value="${info.content}" name="content"
								id="i_content" required> <br> <br> <br> <br>

							<span class="highlight"></span> <span class="bar"></span>

							<div class="center">
								<input type=button value="수정하기"
									onClick="fn_reply_form('${contextPath}/board/save.do?brdNo=${info.brdNo}&katNo=${katTargetNo}',${info.brdNo})">
								 <input type=button value="리스트로 돌아가기" onClick="backToList()">
							</div>
						</div>
						<input type="hidden" name="userId" value="${userId}">
						<input type="hidden" id="katNo" name="katNo" value="${katTargetNo}">

					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>