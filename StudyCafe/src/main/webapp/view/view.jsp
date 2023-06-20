<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("cache-control","no-store");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
<meta charset="UTF-8">
<title>글보기</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/sidebar.css">
<link rel="stylesheet" href="../css/list.css">
<link rel="stylesheet" href="../css/message.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/sidebar.js"></script>

<script type="text/javascript">
      function backToList(obj){
	    obj.action="${contextPath}/board/list.do?katNo=3";
	    obj.submit();
	  }
   
      function fn_modify_artlce(obj) {
    	  obj.action= "${contextPath}/board/mod.do?brdNo=0";
    	  obj.submit();
      }
      
      function fn_remove_article(url,brdNo) {
    	  var form = document.createElement("form");
    	  form.setAttribute("method", "post");
    	  form.setAttribute("action", url);
    	  var brdNoInput = document.createElement("input");
    	  brdNoInput.setAttribute("type","hidden");
    	  brdNoInput.setAttribute("name","brdNo");
    	  brdNoInput.setAttribute("value","brdNo");
    	  form.appendChild(brdNoInput);
    	  document.body.appendChild(form);
    	  form.submit();
      }
      
   </script>
</head>
<body>
	<div id="viewport">
		<!--SideBar  -->
		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<!--Top  -->
			<jsp:include page="top.jsp"></jsp:include>
				<span>글번호:${info.brdNo}</span>
					<div class='pull-right'>유저:${userId}&nbsp</div>
					<div class='pull-right'>등록일자:${info.regDate}</div>
					<!-- Content -->
					<div id="content2">
						<div class="group">
						
							<input type="text" value="${brdNo.title }" id="i_title" required>
							<span class="highlight"></span> <span class="bar"></span>
						</div>
					</div>
					<div
						style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>
					<form id="message-form" action="#" method="post" name="frmArticle"
						enctype="multipart/form-data">
						<div class="group">
							<input type="text1" value="${brdNo.content }" name="content"
								id="i_content" required> <span class="highlight"></span>
							<span class="bar"></span>
						</div>

						<input type=button value="수정하기"
							onClick="fn_modify_artlce(this.form)">
						<input type=button value="삭제하기"
							onClick="fn_remove_article('${contextPath}/board/remove.do', ${deleted.brdNo})">
						<input type=button value="리스트로 돌아가기"
							onClick="backToList(this.form)">

						<div
							style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>

						<div id="messages">Connecting...</div>
						<div class="group">
							<input type="text" placeholder="Write your message here..." name="content" id="messages" required> 
							<span class="highlight"></span> 
							<span class="bar"></span> 
							<input type=button value="답글쓰기" onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${Comment.comNo})">

							<div style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>

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
								<c:when test="${comment !=null }">
									<c:forEach var="item" items="${comment }" varStatus="articleNum">
										<tr align="center">
											<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
											<td width="4%">${userId}</td>
											<td width="20%">${item.comContent}</td>
											<td width="10%">${item.cnt}</td>
											<td width="10%">${item.regDate}</td>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
					</form>
				</div>

			</div>
			<input type="hidden" name="userId" value="${userId}">
		</div>
	</div>

</body>
</html>