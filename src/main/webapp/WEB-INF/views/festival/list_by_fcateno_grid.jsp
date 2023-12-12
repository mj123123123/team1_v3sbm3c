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

</head>
<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>
		${fcateVO.name }
		<c:if test="${param.word.length() > 0 }">
      > 「${param.word }」 검색 ${search_count } 건
    </c:if>
	</div>

	<aside class="aside_left">
		<button type="submit" class="btn btn-success btn-sm" onclick="location.href='../freview/list_all.do'"
			style="font-weight: bold; text-align: left;">📰 모든 리뷰 보러가기</button>
	</aside>

	<aside class="aside_right">
		<%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
		<c:if test="${sessionScope.admin_id != null }">
			<a href="./create.do?fcateno=${fcateVO.fcateno }">등록</a>
			<span class='menu_divide'>│</span>
		</c:if>
		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_fcateno.do?fcateno=${param.fcateno }&now_page=${param.now_page}&word=${param.word }">목록형</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_fcateno_grid.do?fcateno=${param.fcateno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>
	</aside>

	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_fcateno.do'>
			<input type='hidden' name='fcateno' value='${param.fcateno }'>
			<%-- 게시판의 구분 --%>

			<c:choose>
				<c:when test="${param.word != '' }">
					<%-- 검색하는 경우는 검색어를 출력 --%>
					<input type='text' name='word' id='word' value='${param.word }'>
				</c:when>
				<c:otherwise>
					<%-- 검색하지 않는 경우 --%>
					<input type='text' name='word' id='word' value=''>
				</c:otherwise>
			</c:choose>
			<button type='submit' class='btn btn-dark btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
			<c:if test="${param.word.length() > 0 }">
				<%-- 검색 상태하면 '검색 취소' 버튼을 출력 --%>
				<button type='button' class='btn btn-dark btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
					onclick="location.href='./list_by_fcateno.do?fcateno=${param.fcateno}&word='">검색 취소</button>
			</c:if>
		</form>
	</div>

	<div class="menu_line"></div>

	<div style='width: 100%;'>
		<%-- 갤러리 Layout 시작 --%>
		<c:forEach var="festivalVO" items="${list }" varStatus="status">
			<c:set var="title" value="${festivalVO.title }" />
			<c:set var="content" value="${festivalVO.content }" />
			<c:set var="fcateno" value="${festivalVO.fcateno }" />
			<c:set var="contentsno" value="${festivalVO.contentsno }" />
			<c:set var="thumb1" value="${festivalVO.thumb1 }" />
			<c:set var="size1" value="${festivalVO.size1 }" />

			<!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
			<!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
			<div
				onclick="location.href='./read.do?contentsno=${contentsno}&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }&fcateno=${param.fcateno }'"
				style='width: 19%; height: 200px; float: left; margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: left; cursor: pointer;'>

				<c:choose>
					<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
						<%-- 이미지인지 검사 --%>
						<%-- registry.addResourceHandler("/festival/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
						<img src="/festival/storage/${thumb1 }" style="width: 100%; height: 120px;">
					</c:when>
					<c:otherwise>
						<!-- 이미지가 없는 경우 기본 이미지 출력: /static/festival/images/none1.png -->
						<IMG src="/festival/images/none1.png" style="width: 100%; height: 120px;">
					</c:otherwise>
				</c:choose>
				${title }

			</div>

			<%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
			<c:if test="${status.count % 5 == 0}">
				<HR class='menu_line'>
				<%-- 줄바꿈 --%>
			</c:if>

		</c:forEach>
	</div>

	<!-- 페이지 목록 출력 부분 시작 -->
	<DIV class='bottom_menu'>${paging }</DIV>
	<%-- 페이지 리스트 --%>
	<!-- 페이지 목록 출력 부분 종료 -->

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
