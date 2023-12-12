<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>Festival world</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>축제/행사 리뷰(전체)</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>
	<div class="menu_line"></div>

	<table class="table table-hover">
		<colgroup>
			<col style="width: 20%;"></col>
			<col style="width: 45%;"></col>
			<col style="width: 20%;"></col>
			<col style="width: 15%;"></col>
		</colgroup>
		<thead>
			<tr>
				<th style='text-align: center;'>파일</th>
				<th style='text-align: center;'>제목</th>
				<th style='text-align: center;'>등록일</th>
				<th style='text-align: center;'>작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="freviewVO" items="${list }" varStatus="info">
				<c:set var="reviewno" value="${freviewVO.reviewno }" />
				<c:set var="thumb1" value="${freviewVO.thumb1 }" />

				<tr onclick="location.href='./read.do?reviewno=${reviewno}'" style="cursor: pointer;">
					<td>
						<c:choose>
							<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
								<%-- 이미지인지 검사 --%>
								<%-- registry.addResourceHandler("/festival/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
								<img src="/freview/storage/${thumb1 }" style="width: 120px; height: 90px;">
							</c:when>
							<c:otherwise>
								<!-- 이미지가 없는 경우 기본 이미지 출력: /static/festival/images/none1.png -->
								<img src="/freview/images/none1.png" style="width: 120px; height: 90px;">
							</c:otherwise>
						</c:choose>
					</td>
					<td class="td_bs_left">
						<span style="font-weight: bold;">${freviewVO.title }</span>
						<br>
						<c:choose>
							<c:when test="${freviewVO.content.length() > 160 }">
                  ${freviewVO.content.substring(0, 160) }...
                </c:when>
							<c:otherwise>
                  ${freviewVO.content }
                </c:otherwise>
						</c:choose>
					</td>

					<td class="td_bs">
						<span style="font-weight: bold;">${freviewVO.rdate }</span>
						</a>
					</td>

					<td class="td_bs">
						<span style="font-weight: bold;">${freviewVO.nickname }</span>
						</a>
					</td>

				</tr>
			</c:forEach>
		</tbody>

	</table>
	<!-- 페이지 목록 출력 부분 시작 -->
	<DIV class='bottom_menu'>${paging }</DIV>
	<%-- 페이지 리스트 --%>
	<!-- 페이지 목록 출력 부분 종료 -->

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
