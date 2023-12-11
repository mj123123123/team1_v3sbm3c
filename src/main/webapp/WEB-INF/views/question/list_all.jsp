<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>Festival Question</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>질문 목록(전체)</div>
  
  <td><a href="../tcate/list_by_tcateno.do?tcateno=${tcateVO.tcateno }" class='title_link'>${tcateVO.name }</a></td>

  <aside class="aside_right">
    <a href="./create.do?tcateno=${tcateVO.tcateno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
    <div style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_all.do'>
      <input type='hidden' name='tcateno' value='${tcateVO.tcateno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.quest != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='quest' id='quest' value='${param.quest }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='quest' id='quest' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-info btn-sm'>검색</button>
      <c:if test="${param.quest.length() > 0 }">
        <button type='button' class='btn btn-info btn-sm' 
                    onclick="location.href='./list_by_tcateno.do?tcateno=${tcateVO.tcateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </div>
  
  <div class="menu_line"></div>

  <table class="table table-hover">
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <thead>
      <tr>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>내용</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    </thead>
    <tbody>
        <c:forEach var="questionVO" items="${list }" varStatus="info">
          <c:set var="questno" value="${questionVO.questno }" />
          <c:set var="title" value="${questionVO.title }" />
    
          <tr onclick="location.href='./read.do?questno=${questno}'" style="cursor: pointer;">
            <td class="td_bs">
              <span style="font-weight: bold;">${questionVO.title }</span><br>
            </td>
            <td class="td_bs">
              <c:choose>
                <c:when test="${questionVO.quest.length() > 160 }">
                  ${questionVO.quest.substring(0, 160) }...
                </c:when>
                <c:otherwise>
                  ${questionVO.quest }
                </c:otherwise>
              </c:choose>
              (${questionVO.rdate.substring(0, 16) })
            </td>
            <td class="td_bs">
              <a href="../answer/create.do?questno=${questno }&now_page=${param.now_page}" title="등록"><img src="/question/images/create.png" class="icon"></a>
              <a href="/question/update_quest.do?questno=${questno }&tcateno=${tcateno}&now_page=${param.now_page}" title="수정"><img src="/question/images/update.png" class="icon"></a>
              <a href="/question/delete.do?questno=${questno }&tcateno=${tcateno}&now_page=${param.now_page}" title="삭제"><img src="/question/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
    </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>