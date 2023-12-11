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

  <DIV class='title_line'> ${questionVO.title } > 답변 수정</DIV>
  <aside class="aside_right">
    <a href="./create.do?questno=${questionVO.questno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class='menu_line'></div>
  
  <form name='frm' method='post' action='./update_text.do'>
    <input type="hidden" name="questno" value="${questno }">
    <input type="hidden" name="ansno" value="${ansno }">
    <input type="hidden" name="now_page" value="${param.now_page }">
 
    <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'></textarea>
    </div>    

    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark btn-sm">저장</button>
      <button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
    </div>
  
  </FORM>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>