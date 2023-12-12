<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Festival world</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<!-- /static 기준 -->
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>
		${festivalVO.title } > 리뷰 등록하기
	</div>

	<aside class="aside_right">
		<a href="./list_by_contentsno.do?contentsno=${param.contentsno}">리뷰 목록</a>
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
			<button type='submit' class='btn btn-dark btn-sm'>검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class='btn btn-dark btn-sm'
					onclick="location.href='./list_by_contentsno.do?contentsno=${festivalVO.contentsno}&word='">검색 취소</button>
			</c:if>
		</form>
	</div>

	<div class='menu_line'></div>

	<form name='frm' method='post' action='./create.do?contentsno=${param.contentsno}' enctype="multipart/form-data">
		<input type="hidden" name="contentsno" value="${param.contentsno }">

		<div>
			<label>작성자</label> <input type='text' name='nickname' value='' required="required" autofocus="autofocus"
				class="form-control" style='width: 100%; font-weight: bold; color: blue;'>
		</div>
		<div>

			<label>제목</label> <input type='text' name='title' value='축제 이름을 적어주세요!' required="required" autofocus="autofocus"
				class="form-control" style='width: 100%; color: #8B4513;'>
		</div>
		<div>
			<label>리뷰(리뷰)</label>
			<textarea name='content' required="required" class="form-control" rows="5" style='width: 100%;'></textarea>
		</div>
		<div>
			<label>검색어</label> <input type='text' name='word' value='' required="required" class="form-control"
				style='width: 100%;'>
		</div>
		<div>
			<label>이미지</label> <input type='file' class="form-control" name='file1MF' id='file1MF' value='' placeholder="파일 선택">
		</div>
		<div>
			<label>패스워드</label> <input type='password' name='pwd' value='' required="required" class="form-control"
				style='width: 50%;'>
		</div>
		<div class="content_body_bottom">
			<button type="submit" class="btn btn-dark btn-sm">등록하기</button>
			<button type="button" onclick="location.href='./list_by_contentsno.do?contentsno=${param.contentsno}'"
				class="btn btn-dark btn-sm">목록(취소)</button>
		</div>

	</form>


	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>