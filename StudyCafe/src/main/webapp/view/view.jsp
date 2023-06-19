<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<head>
   	<meta charset="UTF-8">
  	<title>글보기</title>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/sidebar.css">
	<link rel="stylesheet" href="../css/list.css">
	<link rel="stylesheet" href="../css/message.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/sidebar.js"></script>

   <script type="text/javascript">
      function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
	  }
   
   </script>
</head>
<body>
<!--SideBar  -->
<jsp:include page="sidebar.jsp"></jsp:include>
<div id="viewport">
<!--Top  -->
<jsp:include page="top.jsp"></jsp:include>
<div class="wrapper fadeInDown">
<tr>
<td width="150" align="left" bgcolor="#FF9933">글번호</td>
<br>
<td width="150" align="left" bgcolor="#FF9933">유저</td>
<br>
<td width="150" align="left" bgcolor="#FF9933">등록일자</td>
</tr>
 	
<!-- Content -->
<div id="content">
	<tr>
		<td>
		<div class="group">      
			<input type="text" value="${article.title }"  id="i_title" required>
				<span class="highlight"></span>
					<span class="bar"></span>	 
					  </div>
						</td>
				     		</tr>
 <!-- <div class="container"> -->
<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>		
		<form id="message-form" action="#" method="post" name="frmArticle"
		enctype="multipart/form-data">		
		<tr>
		<td>
		<div class="group"> 	
		<input type="text"  value="${article.content }" name="content" id="i_content" required>
			 <span class="highlight"></span>
			<span class="bar"></span>	
		</div>
		</td>
		</tr>		
		
								 	 																			

		<tr id="tr_btn">
		<td colspan=2 align="center">
		<input type=button value="수정하기" onClick="update_article('${contextPath}/board/mod.do', ${BoardService.update})"> 
		<input type=button value="삭제하기" onClick="fn_remove_article('${contextPath}/board/remove.do', ${BoardService.delete})">
		<input type=button value="리스트로 돌아가기" onClick="backToList(this.form)"> 		
		</td>
		</tr>
		</table>
		
					
	
		
		<footer>
		<div id="messages">Connecting...</div>
	 	<tr>
		<td>
		<div class="group"> 	
		<input type="text" placeholder="Write your message here..." name="content" id="messages" action="#" required>
		 <span class="highlight"></span>
		<span class="bar"></span>
		<input type=button value="답글쓰기" onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})"> 
		 
		</div>
		</td>
		</tr>
		</footer>	
		</form>
	 </div>
	
	

					</div>
					<input type="hidden" name="userId" value="${userId}">
				</div>
			</div>
		</div><!-- Content End  -->
		
		
	



</body>
</html>