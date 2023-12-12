<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="name" value="${festivalVO.title }" />

<c:set var="contentsno" value="${freviewVO.contentsno }" />
<c:set var="reviewno" value="${freviewVO.reviewno }" />
<c:set var="thumb1" value="${freviewVO.thumb1 }" />
<c:set var="file1saved" value="${freviewVO.file1saved }" />
<c:set var="title" value="${freviewVO.title }" />
<c:set var="content" value="${freviewVO.content }" />
<c:set var="nickname" value="${freviewVO.nickname }" />
<c:set var="rdate" value="${freviewVO.rdate }" />
<c:set var="map" value="${freviewVO.map }" />
<c:set var="file1" value="${freviewVO.file1 }" />
<c:set var="size1_label" value="${freviewVO.size1_label }" />
<c:set var="word" value="${freviewVO.word }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Festival world</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>
		<A href="./list_by_contentsno.do?contentsno=${festivalVO.contentsno }" class='title_link'> ${festivalVO.title }</A>
	</DIV>

	<aside class="aside_right">
		<%-- 회원으로 로그인해야 메뉴가 출력됨 --%> 
		<c:if test="${sessionScope.member_id != null }">
			<%--
      http://localhost:9093/festival/create.do?contentsno=1
      http://localhost:9093/festival/create.do?contentsno=2
      http://localhost:9093/festival/create.do?contentsno=3
      --%>
			<a href="./create.do?contentsno=${contentsno }">등록</a>
			<span class='menu_divide'>│</span>
			<a href="./update_text.do?reviewno=${reviewno}&now_page=${param.now_page}&word=${param.word }">글 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./update_file.do?reviewno=${reviewno}&now_page=${param.now_page}">파일 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./map.do?contentsno=${contentsno }&reviewno=${reviewno}">지도</a>
			<span class='menu_divide'>│</span>
			<a href="./delete.do?reviewno=${reviewno}&now_page=${param.now_page}&contentsno=${contentsno}">삭제</a>
			<span class='menu_divide'>│</span>
		</c:if>

		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_fcateno.do?fcateno=${fcateno }&now_page=${param.now_page}&word=${param.word }">목록형</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_fcateno_grid.do?fcateno=${fcateno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>
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

	<DIV class='menu_line'></DIV>

	<fieldset class="fieldset_basic">
		<ul>
			<li class="li_none">
				<DIV style="width: 100%; word-break: break-all;">
					<c:choose>
						<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
							<%-- /static/festival/storage/ --%>
							<img src="/festival/storage/${file1saved }" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
						</c:when>
						<c:otherwise>
							<!-- 기본 이미지 출력 -->
							<img src="/festival/images/none1.png" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
						</c:otherwise>
					</c:choose>


					<span style="font-size: 1.5em; font-weight: bold;">${title}</span>
					<br>
					<span style="font-size: 0.9em; font-weight: bold;">
						작성자: ${nickname}
					</span>
					<br> <br>${content}
				</DIV>
			</li>

			<c:if test="${map.trim().length() > 0 }">
				<li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
					<DIV style='text-align: center; width: 640px; height: 360px; margin: 0px auto;'>${map }</DIV>
				</li>
			</c:if>

			<br>

			<li class="li_none" style="clear: both;">
				<DIV style='text-decoration: none;'>
					<span style="font-size: 1em;">
						<br> <br>등록일: ${rdate}
					</span>
				</DIV>
			</li>

			<li class="li_none" style="clear: both;">
				<DIV style='text-decoration: none;'>검색어(키워드): ${word }</DIV>
			</li>

			<li class="li_none">
				<div>
					<c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/festival/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label}) 
            <a href='/download?dir=/festival/storage&filename=${file1saved}&downname=${file1}'>
							<img src="/festival/images/download.png" class="icon">
						</a>
					</c:if>
				</div>
			</li>
		</ul>
	</fieldset>

	</DIV>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

