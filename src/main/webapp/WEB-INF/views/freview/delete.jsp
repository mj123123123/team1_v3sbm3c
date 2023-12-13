<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="reviewno" value="${freviewVO.reviewno }" />
<c:set var="contentsno" value="${freviewVO.contentsno }" />
<c:set var="title" value="${freviewVO.title }" />
<c:set var="file1" value="${freviewVO.file1 }" />
<c:set var="file1saved" value="${freviewVO.file1saved }" />
<c:set var="thumb1" value="${freviewVO.thumb1.toLowerCase() }" />
<c:set var="size1" value="${freviewVO.size1 }" />

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
	<DIV class='title_line'>${festivalVO.title } > ${title } > 리뷰 삭제</DIV>

	<aside class="aside_right">
		<a href="./create.do?contentsno=${contentsno }">📝 리뷰 등록</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_contentsno.do?contentsno=${contentsno }">📰 리뷰 목록</a>
		<span class='menu_divide'>│</span>
		<a href="javascript:location.reload();">새로고침</a>
	</aside>

	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_contentsno_search_paging.do'>
			<input type='hidden' name='contentsno' value='${festivalVO.contentsno }'>
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
			<button type='submit' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class='btn btn-secondary btn-sm'
					onclick="location.href='./list_by_contentsno.do?contentsno=${festivalVO.contentsno}&word='"
					style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색 취소</button>
			</c:if>
		</form>
	</div>

	<div class='menu_line'></div>

	<fieldset class="fieldset_basic">
		<ul>
			<li class="li_none">
				<DIV style='text-align: center; width: 50%; float: left;'>

					<c:choose>
						<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
							<img src="/freview/storage/${file1saved }" style='width: 90%;'>
						</c:when>
						<c:otherwise>
							<!-- 이미지가 없는 경우 -->
             [페스티벌] 관련 이미지가 없습니다.
            </c:otherwise>
					</c:choose>
				</DIV>

				<DIV style='text-align: left; width: 47%; float: left;'>
					<span style='font-size: 1.5em;'>${title}</span>
					<c:if test="${size1 > 0 }">
						<br>삭제되는 파일: ${file1 }
          </c:if>
					<br>
					<FORM name='frm' method='post' action='./delete.do'>
						<input type='hidden' name='reviewno' value='${reviewno}'> <input type='hidden' name='contentsno'
							value='${contentsno}'> <input type='hidden' name='now_page' value='${param.now_page}'> <br>
						<br>
						<div style='text-align: center; margin: 10px auto;'>
							<span style="color: #FF0000; font-weight: bold;">삭제를 진행 하시겠습니까? 삭제하시면 복구 할 수 없습니다.</span>
							<br>
							<br> <br>
							<br>
							<button type="submit" class="btn btn-secondary btn-sm">삭제 진행</button>
							<button type="button" onclick="history.back()" class="btn btn-secondary btn-sm">취소</button>
						</div>
					</FORM>
				</DIV>
			</li>
		</ul>
	</fieldset>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>

