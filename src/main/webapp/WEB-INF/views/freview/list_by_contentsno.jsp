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

	<div class='title_line'>${festivalVO.title }
		<c:if test="${param.word.length() > 0}">
        > 「${param.word}」 검색 ${search_count } 건
    </c:if>
	</div>

	<aside class="aside_left">
		<button type="submit" class="btn btn-success btn-sm"
			onclick="location.href='./create.do?contentsno=${festivalVO.contentsno}'"
			style="font-weight: bold; text-align: left;">📰 리뷰 등록하기</button>
	</aside>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>
	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_contentsno.do'>
			<input type='hidden' name='contentsno' value='${param.contentsno }'>

			<c:choose>
				<c:when test="${param.word != ''}">
					<input type='text' name='word' id='word' value='${param.word }'>
				</c:when>
				<c:otherwise>
					<input type='text' name='word' id='word' value=''>
				</c:otherwise>
			</c:choose>
			<button type='submit' class='btn btn-dark btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
			<c:if test="${param.word.length() > 0}">
				<button type='button' class='btn btn-dark btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
					onclick="location.href='./list_by_contentsno.do?contentsno=${param.contentsno}&word='">검색 취소</button>
			</c:if>
		</form>
	</div>

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

				<tr
					onclick="location.href='./read.do?reviewno=${reviewno}&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }&contentsno=${param.contentsno }'"
					style="cursor: pointer;">
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