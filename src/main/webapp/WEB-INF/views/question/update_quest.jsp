<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="questno" value="${questionVO.questno }" />
<c:set var="tcateno" value="${questionVO.tcateno }" />
<c:set var="memberno" value="${questionVO.memberno }" />
<c:set var="title" value="${questionVO.title }" />
<c:set var="quest" value="${questionVO.quest }" />
<c:set var="rdate" value="${questionVO.rdate }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>Festival world</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <DIV class='title_line'> ${title } > 수정</DIV>
  <aside class="aside_right">
    <a href="./create.do?questno=${questionVO.questno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class='menu_line'></div>
  
  <form name='frm' method='post' action='./update_quest.do'>
    <!-- <input type="hidden" name="tcateno" value="${tcateno }"> 
        <input type="hidden" name="now_page" value="${param.now_page }">-->
    <input type="hidden" name="questno" value="${questno }">

    
    <div>
       <label>제목</label>
       <input type='text' name='title' value='${title }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label>내용</label>
       <textarea name='quest' required="required" class="form-control" rows="12" style='width: 100%;'>${quest }</textarea>
    </div>    

    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark btn-sm">저장</button>
      <button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
    </div>
  
  </FORM>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>