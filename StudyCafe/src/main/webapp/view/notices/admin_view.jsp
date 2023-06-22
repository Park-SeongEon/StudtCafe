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
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/sidebar.css">
<link rel="stylesheet" href="../../css/list.css">
<link rel="stylesheet" href="../../css/message.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../../js/bootstrap.js"></script>
<script src="../../js/sidebar.js"></script>
<script src="https://kit.fontawesome.com/def66b134a.js" crossorigin="anonymous"></script>
<script type="text/javascript">
      function backToList(obj,url){
	    obj.action="${contextPath}/board/list.do?katNo=3";
	    obj.submit();
	  }
   
      function fn_modify_artlce(obj,url) {
    	  obj.action= url;
    	  obj.submit();
      }
      
      function fn_remove_article(url,brdNo) {
    	  var form = document.createElement("form");
    	  form.setAttribute("method", "post");
    	  form.setAttribute("action", url);
    	  var brdNoInput = document.createElement("input");
    	  brdNoInput.setAttribute("type","hidden");
    	  brdNoInput.setAttribute("name","brdNo");
    	  brdNoInput.setAttribute("value",brdNo);
    	  form.appendChild(brdNoInput);
    	  document.body.appendChild(form);
    	  form.submit();
      }
      
      
	function fn_reply_form(url, brdNo){
		 var form = document.createElement("form");
			 form.setAttribute("method", "post");
			 form.setAttribute("action", url);
		     var parentNOInput = document.createElement("input");
		     parentNOInput.setAttribute("type","hidden");
		     parentNOInput.setAttribute("name","brdNo");
		     parentNOInput.setAttribute("value", brdNo);
		     var parentNOInput2 = document.createElement("input");			

		     parentNOInput2.setAttribute("type","hidden");
		     parentNOInput2.setAttribute("name","content");

		     parentNOInput2.setAttribute("value", $("#comment").val());
		     
		     form.appendChild(parentNOInput);
		     form.appendChild(parentNOInput2);

		     document.body.appendChild(form);
	    	 form.submit();
		     
		 }
		
	function fn_vote(brdNo,voteNo){
		$.ajax({
			url:"/board/Updatevote.do",		// servlet 
			type: "post",
			datatype:"text",
			data: {"brdNo" : brdNo,"voteNo" : voteNo},
			success:function(data){
				//alert("s");
				//int, string, 다수의 데이터
				
				//var data = JSON.parse(obj);
				//console.log(data.id);
				//alert(json.str);
				/* var data = JSON.parse(json.map);
				alert(data); */
				//alert(json.map.title);
				if(data === 'success'){
					$('input[name=checkID]').val("ok");
					alert("추천을 하였습니다..")
					$('#message').text('사용할 수 있는 ID입니다.')   
					$('#message').css('color','green')
					
				}
				else {
					alert("이미 추천을 하였습니다.")
					$('#message').text('이미 추천을 하였습니다.')
					$('#message').css('color','red')
					
				}
			},
			error:function(){
				alert("error");
			}
		})
		     
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
					<div class="card" style="width: 100%;">
						<div class="card-body">
<!-- 							<input type="text" value="${info.title}" name="title"
								id="i_content" required>
 -->
							<h4 class="card-title">${info.title}</h4>
 			  				<p class="card-text"><i class="fa-solid fa-user"></i>${userId}</p>
							<h6 class="card-subtitle mb-2 text-muted">등록일자 : ${info.regDate}  조회수 : ${info.cnt} </h6>
						</div>
					</div>


<!--  				<div class='pull-right'>👍 : ${info.voteNo}</div>-->
					
					<div style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>
					
					<form id="message-form" action="#" method="post" name="frmArticle"
						enctype="multipart/form-data">
						<div class="group notice">
							${info.content}
							<br>
							<br>
							<br>
							<br>
							
							<span class="highlight"></span>
							<span class="bar"></span>
						</div>

						<div class="center">
							<input type=button value="👍 : ${info.voteNo}" onClick="fn_vote(${info.brdNo},${info.voteNo})">
							<input type=button value="리스트로 돌아가기" onClick="backToList(this.form,'${contextPath}/board/list.do?katNo=${katTargetNo}')"> 
							<input type=button value="수정하기" onClick="fn_modify_artlce(this.form,'${contextPath}/board/mod.do?brdNo=${info.brdNo}&katNo=${katTargetNo}')"> 
							<input type=button value="삭제하기" onClick="fn_remove_article(this.form,'${contextPath}/board/remove.do', ${info.brdNo})">
						</div>

						<div style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>

						<div id="messages">Comment...</div>
						<div class="group">
							<input type="text" id="comment"
								placeholder="댓글을 남겨주세요" name="content"
								id="messages"> <span class="highlight"></span> <span
								class="bar"></span> <input type=button value="답글쓰기"
								onClick="fn_reply_form('${contextPath}/board/addReply.do', ${info.brdNo})">

							<div style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>

							<c:choose>
								<c:when test="${list == null }">
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
										<div class="card" style="width: 18rem;">
											<div class="card-body">
												<h5 class="card-title">${item.userId}</h5>
					 			  				<p class="card-text">${item.comContent}</p>
												<h6 class="card-subtitle mb-2 text-muted">등록일자:${item.regDate}   </h6>
											</div>
										</div>										
										<div style="border-bottom: 1px solid #bdbdbd42; margin: 5px 20px 20px 20px"></div>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
					</form>
				</div>
				<input type="hidden" name="userId" value="${userId}">
			</div>
		</div>
	</div>

</body>
</html>