<%@page import="sample01.YouClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Object obj = request.getAttribute("cls");
if(obj == null){	
}
YouClass cls = (YouClass)obj;

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

번호:<input type="text" value="<%=cls.getNum() %>">
<br>
이름:<input type="text" value="<%=cls.getName() %>">

</body>
</html>





