<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Festival world</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel='Stylesheet' type='text/css'>

</head>
<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>
		<A href="/festival/list_by_fcateno.do?fcateno=${fcateVO.fcateno }" class="title_link">${fcateVO.name }</A> >
		${festivalVO.title } > Youtube 등록/수정/삭제
	</DIV>

	<ASIDE class="aside_right">
		<A href="javascript:location.reload();">새로고침</A> <span class='menu_divide'>│</span> <A
			href="./list_by_fcateno.do?fcateno=${param.fcateno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">기본
			목록형</A> <span class='menu_divide'>│</span> <A
			href="./list_by_fcateno_grid.do?fcateno=${param.fcateno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">갤러리형</A>

	</ASIDE>

	<DIV style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_fcateno.do'>
			<input type='hidden' name='fcateno' value='${fcateVO.fcateno }'>
			<%-- 게시판의 구분 --%>

			<c:choose>
				<c:when test="${param.word != '' }">
					<%-- 검색하는 경우 --%>
					<input type='text' name='word' id='word' value='${param.word }' class='input_word'>
				</c:when>
				<c:otherwise>
					<%-- 검색하지 않는 경우 --%>
					<input type='text' name='word' id='word' value='' class='input_word'>
				</c:otherwise>
			</c:choose>
			<button type='submit' class='btn btn-dark btn-sm'>검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class='btn btn-dark btn-sm'
					onclick="location.href='./list_by_fcateno.do?fcateno=${fcateVO.fcateno}&word='">검색 취소</button>
			</c:if>
		</form>
	</DIV>

	<DIV class='menu_line'></DIV>
	<%--등록 폼 --%>
	<FORM name='frm_youtube' method='POST' action='./youtube.do'>
		<input type="hidden" name="contentsno" value="${param.contentsno }">

		<div>
			<label>Youtube 스크립트</label>
			<textarea name='youtube' class="form-control" rows="12" style='width: 100%;'>${festivalVO.youtube }</textarea>
		</div>
		<div class="content_body_bottom">
			<button type="submit" class="btn btn-dark btn-sm">저장</button>
			<button type="button" onclick="frm_youtube.youtube.value=''; frm_youtube.submit();"
				class="btn btn-dark btn-sm">Youtube 삭제</button>
			<button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
		</div>

	</FORM>

	<HR>
	<DIV style="text-align: center;">
		<H5>[참고] Youtube의 등록 방법</H5>
		<IMG src='/festival/images/youtube01.jpg' style='width: 60%;'><br>
		<br> <IMG src='/festival/images/youtube02.jpg' style='width: 60%;'><br>
	</DIV>


	<jsp:include page="../menu/bottom.jsp" />
</body>

</html>

