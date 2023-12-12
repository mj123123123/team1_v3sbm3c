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

	<div class='title_line'>카테고리</div>

	<aside class="aside_right">
		<a href="./create.do?fcateno=${fcateVO.fcateno }">등록</a> <span class='menu_divide'>│</span> <a
			href="javascript:location.reload();">새로고침</a>
	</aside>
	<div class="menu_line"></div>

	<form name='frm' method='post' action='/fcate/create.do'>
		<div style="text-align: center;">
			<label>카테고리 이름</label> <input type="text" name="name" value="" required="required" autofocus="autofocus"
				class="" style="width: 50%">
			<button type="submit" class="btn btn-dark btn-sm" style="height: 28px; margin-bottom: 5px;">등록</button>
			<button type="button" onclick="location.href='./list_all.do'" class="btn btn-dark btn-sm"
				style="height: 28px; margin-bottom: 5px;">목록</button>
		</div>
	</form>

	<table class="table table-hover">
		<colgroup>
			<col style='width: 10%;' />
			<col style='width: 40%;' />
			<col style='width: 10%;' />
			<col style='width: 20%;' />
			<col style='width: 20%;' />
		</colgroup>
		<thead>
			<tr>
				<th class="th_bs">순서</th>
				<th class="th_bs">카테고리 이름</th>
				<th class="th_bs">자료수</th>
				<th class="th_bs">등록일</th>
				<th class="th_bs">기타</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="fcateVO" items="${list }" varStatus="info">
				<c:set var="fcateno" value="${fcateVO.fcateno }" />
				<c:set var="seqno" value="${fcateVO.seqno }" />

				<tr>
					<td class="td_bs">${seqno }</td>
					<td><a href="../festival/list_by_fcateno.do?fcateno=${fcateno }" style="display: block;">${fcateVO.name }</a></td>
					<td class="td_bs">${fcateVO.cnt }</td>
					<td class="td_bs">${fcateVO.rdate.substring(0, 10) }</td>
					<td class="td_bs"><a href="../festival/create.do?fcateno=${fcateno }" title="등록"><img
							src="/fcate/images/create.png" class="icon"></a> <c:choose>
							<c:when test="${fcateVO.visible == 'Y'}">
								<a href="./update_visible_n.do?fcateno=${fcateno }" title="카테고리 공개 설정"><img
									src="/fcate/images/show.png" class="icon"></a>
							</c:when>
							<c:otherwise>
								<a href="./update_visible_y.do?fcateno=${fcateno }" title="카테고리 비공개 설정"><img
									src="/fcate/images/hide.png" class="icon"></a>
							</c:otherwise>
						</c:choose> <a href="./update_seqno_forward.do?fcateno=${fcateno }" title="우선 순위 높임"><img
							src="/fcate/images/decrease.png" class="icon"></a> <a
						href="./update_seqno_backward.do?fcateno=${fcateno }" title="우선 순위 낮춤"><img
							src="/fcate/images/increase.png" class="icon"></a> <a href="./update.do?fcateno=${fcateno }" title="수정"><img
							src="/fcate/images/update.png" class="icon"></a> <a href="./delete.do?fcateno=${fcateno }" title="삭제"><img
							src="/fcate/images/delete.png" class="icon"></a></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
