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

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<div id="viewport">

		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">

			<jsp:include page="top.jsp"></jsp:include>

			<div class="container-fluid">
				<div class="wrapper" style="margin-top: 150px;">
					<%-- 통계영역 --%>
					<div class="stats" style="margin-bottom: 50px;">
						<table>
							<tbody>
								<tr>
									<td class="enf" title="test">
										<div class="sub-wrapper">
											<p class="title left-2"></p>
											<p class="title-1">사용</p>
											<p class="value-1">
												<fmt:formatNumber value="${enfCount.enf_yesterday_cnt}"
													type="number" />
											</p>
											<p class="title-2"></p>
											<p class="value-2">
												<fmt:formatNumber value="${enfCount.enf_month_cnt}"
													type="number" />
											</p>
										</div>
									</td>
									
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/sidebar.js"></script>
</body>
</html>