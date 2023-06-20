<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div style="width: 100%; height: 70%; overflow: auto">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="active table table1" style="border: 1px solid #dddddd">
		<thead>
			<tr>
				<th style="text-align: center; vertical-align: middle;">번호</th>
				<th style="text-align: center; vertical-align: middle;">제목</th>
				<th style="text-align: center; vertical-align: middle;">작성자</th>
				<th style="text-align: center; vertical-align: middle;">작성일</th>
			</tr>
		</thead>
		<tbody>
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
				<c:when test="${list != null }">
					<c:forEach var="item" items="${list }" varStatus="articleNum">
						<tr align="center">
							<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
							<td width="4%">${item.rownum}</td>
							<td width="20%"><a
								href="${contextPath}/board/view.do?brdNo=${item.brdNo}&katNo=${katTargetNo}">${item.title}</a></td>
							<td width="10%">${item.cnt}</td>
							<td width="30%">${item.regDate}</td>
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
							<li><a class="no-uline"
								href="/board/list.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
									prev </a></li>
						</c:if>
						<li><a class="no-uline"
							href="/board/list.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>

						<c:if test="${page ==10 }">
							<li><a class="no-uline"
								href="/board/list.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;next</a></li>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${tot == 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<li><a class="no-uline" href="#">${page} </a>
						<li>
					</c:forEach>
				</c:when>

				<c:when test="${tot< 100 }">
					<c:forEach var="page" begin="1" end="${tot/10 +1}" step="1">
						<c:choose>
							<c:when test="${page== pageNum }">
								<li><a class="sel-page"
									href="/board/list.do?section=${section}&pageNum=${page}">${page }
								</a></li>
							</c:when>
							<c:otherwise>
								<li><a class="no-uline"
									href="/board/list.do?section=${section}&pageNum=${page}">${page }
								</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</ul>
	</c:if>
</div>

