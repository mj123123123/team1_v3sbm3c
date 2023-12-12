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

	<div class='title_line'>[축제/행사] 카테고리</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>
	<div class="menu_line"></div>

	<table class="table table-hover">
		<colgroup>
			<col style='width: 80%;' />
			<col style='width: 20%;' />
		</colgroup>
		<thead>
			<tr>
				<th class="th_bs">카테고리 이름</th>
				<th class="th_bs">자료수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="fcateVO" items="${list}" varStatus="info">
				<c:if test="${fcateVO.visible == 'Y'}">
					<c:set var="fcateno" value="${fcateVO.fcateno}" />

					<tr>
						<td class="td_bs">
							<a href="../festival/list_by_fcateno.do?fcateno=${fcateno}" style="display: block; font-weight: bold; color: olive;">${fcateVO.name}</a>
						</td>
						<td class="td_bs">${fcateVO.cnt}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>

	</table>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
