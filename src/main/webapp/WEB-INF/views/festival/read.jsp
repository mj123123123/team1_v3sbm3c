<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="name" value="${fcateVO.name }" />

<c:set var="fcateno" value="${festivalVO.fcateno }" />
<c:set var="contentsno" value="${festivalVO.contentsno }" />
<c:set var="thumb1" value="${festivalVO.thumb1 }" />
<c:set var="file1saved" value="${festivalVO.file1saved }" />
<c:set var="title" value="${festivalVO.title }" />
<c:set var="content" value="${festivalVO.content }" />
<c:set var="rdate" value="${festivalVO.rdate }" />
<c:set var="youtube" value="${festivalVO.youtube }" />
<c:set var="map" value="${festivalVO.map }" />
<c:set var="file1" value="${festivalVO.file1 }" />
<c:set var="size1_label" value="${festivalVO.size1_label }" />
<c:set var="word" value="${festivalVO.word }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Festival world</title>
<%-- <link rel="shortcut icon" href="/images/star.png" /> /static 기준
 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>
		<A href="./list_by_fcateno.do?fcateno=${fcateVO.fcateno }" class='title_link'>${fcateVO.name }</A>
	</DIV>

	<aside class="aside_right">
		<%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
		<c:if test="${sessionScope.admin_id != null }">
			<%--
      http://localhost:9093/festival/create.do?fcateno=1
      http://localhost:9093/festival/create.do?fcateno=2
      http://localhost:9093/festival/create.do?fcateno=3
      --%>
			<a href="./create.do?fcateno=${fcateno }">등록</a>
			<span class='menu_divide'>│</span>
			<a href="./update_text.do?contentsno=${contentsno}&now_page=${param.now_page}&word=${param.word }">글 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./update_file.do?contentsno=${contentsno}&now_page=${param.now_page}">파일 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./map.do?fcateno=${fcateno }&contentsno=${contentsno}">지도</a>
			<span class='menu_divide'>│</span>
			<a href="./youtube.do?fcateno=${fcateno }&contentsno=${contentsno}">Youtube</a>
			<span class='menu_divide'>│</span>
			<a href="./delete.do?contentsno=${contentsno}&now_page=${param.now_page}&fcateno=${fcateno}">삭제</a>
			<span class='menu_divide'>│</span>
		</c:if>

		<a href="javascript:location.reload();">새로고침</a> <span class='menu_divide'>│</span> <a
			href="./list_by_fcateno.do?fcateno=${fcateno }&now_page=${param.now_page}&word=${param.word }">목록형</a> <span
			class='menu_divide'>│</span> <a
			href="./list_by_fcateno_grid.do?fcateno=${fcateno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>
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
			<button type='submit' class='btn btn-secondary btn-sm'
				style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
			<c:if test="${param.word.length() > 0 }">
				<%-- 검색 상태하면 '검색 취소' 버튼을 출력 --%>
				<button type='button' class='btn btn-secondary btn-sm'
					style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
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
							<img src="/festival/storage/${file1saved }"
								style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
						</c:when>
						<c:otherwise>
							<!-- 기본 이미지 출력 -->
							<img src="/festival/images/none1.png"
								style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'>
						</c:otherwise>
					</c:choose>


					<span style="font-size: 1.5em; font-weight: bold;">${title}</span> <span style="font-size: 1em;">${rdate}</span>
					<br> ${content}

				</DIV>
			</li>

			<c:if test="${youtube.trim().length() > 0 }">
				<li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
					<DIV style="text-align: center;">${youtube }</DIV>
				</li>
			</c:if>

			<c:if test="${map.trim().length() > 0 }">
				<li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
					<DIV style='text-align: center; width: 640px; height: 360px; margin: 0px auto;'>${map }</DIV>
				</li>
			</c:if>

			<br>
			<br>
			<br>

			<li class="li_none" style="clear: both;">
				<DIV style='text-decoration: none;'>
					<br> <br> <br> 검색어(키워드): ${word }
				</DIV>
			</li>

			<li class="li_none">
				<div>
					<c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/festival/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label}) 
            <a href='/download?dir=/festival/storage&filename=${file1saved}&downname=${file1}'><img
							src="/festival/images/download.png"></a>
					</c:if>
				</div>
			</li>
		</ul>
	</fieldset>

	</DIV>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

