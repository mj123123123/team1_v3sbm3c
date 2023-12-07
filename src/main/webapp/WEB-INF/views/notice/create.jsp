<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9093/</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

  <div class='title_line'>${noticeVO.title } 글 등록 </div>
  
  <aside class="aside_right">
    <a href="./create.do?noticeno=${noticeVO.noticeno }">등록</a>
    <span class='menu_devide'> | </span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>