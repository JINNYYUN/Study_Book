<%@page import="sample01.YouClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	YouClass ycls = (YouClass)session.getAttribute("ycls");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p><%=ycls.getNum() %></p>
<p><%=ycls.getName() %></p>


</body>
</html>



