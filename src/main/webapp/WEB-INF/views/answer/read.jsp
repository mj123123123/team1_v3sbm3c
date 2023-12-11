<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ansno" value="${answerVO.ansno }" />
<c:set var="questno" value="${answerVO.questno }" />
<c:set var="adminno" value="${answerVO.adminno }" />
<c:set var="ans" value="${answerVO.ans }" />
<c:set var="rdate" value="${answerVO.rdate }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>Festival Answer</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <!-- <DIV class='title_line'>
    <A href="./list_by_tcateno.do?tcateno=${tcateVO.tcateno }" class='title_link'>${tcateVO.name }</A>
  </DIV>  -->

  <aside class="aside_right">
    <a href="./create.do?questno=${questionVO.questno }">등록</a>
    <span class='menu_divide'>│</span>
    <a href="./update_answer.do?ansno=${ansno}&now_page=${param.now_page}">수정</a>
    <span class='menu_divide'>│</span>
    <a href="./delete.do?ansno=${ansno}&now_page=${param.now_page}">삭제</a>
    <span class='menu_divide'>│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>

  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
          <span style="font-size: 1.5em; font-weight: bold;">${questionVO.title}</span> <span style="font-size: 1em;"></span>
          <br> ${ans}
          <br><br><br> ${rdate}
        </DIV>
      </li>
    </ul>
  </fieldset>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>