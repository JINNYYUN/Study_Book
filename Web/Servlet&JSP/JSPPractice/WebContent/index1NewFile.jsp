<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	
	System.out.println("name:" + name);
	System.out.println("birth:" + birth);
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
out.println("<p>이름:" + name + "</p>");
%>

<p>생년월일:<%=birth %></p>

</body>
</html>




