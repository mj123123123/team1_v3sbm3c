<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>Festival world</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->
  
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>카테고리 삭제</div>
  
  <aside class="aside_right">
    <a href="./create.do?fcateno=${fcateVO.fcateno }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div> 
  
  <div id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <form name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
      <input type="hidden" name="fcateno" value="${param.fcateno }"> <%-- 삭제할 카테고리 번호 --%>

      <c:choose>
        <c:when test="${count_by_fcateno >= 1 }"> <%-- 자식 레코드가 있는 상황 --%>
          <div class="msg_warning">
            관련 자료 ${count_by_fcateno } 건이 발견되었습니다.<br>
            관련 자료와 카테고리를 모두 삭제하시겠습니까?
          </div>
            
          <label>관련 카테고리 이름</label>:  ${fcateVO.name } 
          <a href="../festival/list_by_fcateno.do?fcateno=${fcateVO.fcateno }&now_page=1" title="관련 카테고리로 이동"><img src='/fcate/images/link.png' class="icon"></a>
          &nbsp;      
          <button type="submit" id='submit' class='btn btn-danger btn-sm' style='height: 28px; margin-bottom: 5px;'>관련 자료와 함게 카테고리 삭제</button>
          
        </c:when>
        <c:otherwise> <%-- 자식 레코드가 없는 상황 --%>
          <div class="msg_warning">카테고리를 삭제하면 복구 할 수 없습니다.</div>
          <label>카테고리 이름</label>: ${fcateVO.name }
      
          <button type="submit" id='submit' class='btn btn-warning btn-sm' style='height: 28px; margin-bottom: 5px;'>삭제</button>          
        </c:otherwise>
      </c:choose>      

      <button type="button" onclick="location.href='/fcate/list_all.do'" class='btn btn-info btn-sm' style='height: 28px; margin-bottom: 5px;'>취소</button>
    </form>
  </div>
  
  <table class="table table-hover">
    <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 40%;'/>
        <col style='width: 10%;'/>    
        <col style='width: 20%;'/>
        <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">순서</th>
          <th class="th_bs">카테고리 이름</th>
          <th class="th_bs">자료수</th>
          <th class="th_bs">등록일</th>
          <th class="th_bs">기타</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="fcateVO" items="${list }" varStatus="info">
          <c:set var="fcateno" value="${fcateVO.fcateno }" />
    
          <tr>
            <td class="td_bs">${info.count }</td>
            <td><a href="./read.do?fcateno=${fcateno }" style="display: block;">${fcateVO.name }</a></td>
            <td class="td_bs">${fcateVO.cnt }</td>
            <td class="td_bs">${fcateVO.rdate.substring(0, 10) }</td>
            <td class="td_bs">
              <img src="/fcate/images/show.png" class="icon">
              <a href="./update_seqno_forward.do?fcateno=${fcateno }" title="우선 순위 높임"><img src="/fcate/images/decrease.png" class="icon"></a>
              <a href="./update_seqno_backward.do?fcateno=${fcateno }" title="우선 순위 낮춤"><img src="/fcate/images/increase.png" class="icon"></a>
              <a href="./update.do?fcateno=${fcateno }" title="수정"><img src="/fcate/images/update.png" class="icon"></a>
              <a href="./delete.do?fcateno=${fcateno }" title="삭제"><img src="/fcate/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
