<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:choose>
	<c:when test="${bookmark eq 0}">
	<a href="javascript:addbookmark();"><img src="../resources/img/bookmark/a.png" width="40" height="40"></a>
    </c:when>
    <c:otherwise>
	<a href="javascript:delbookmark();"><img src="../resources/img/bookmark/b.png" width="40" height="40"></a>
	</c:otherwise>
</c:choose>


</body>
</html>