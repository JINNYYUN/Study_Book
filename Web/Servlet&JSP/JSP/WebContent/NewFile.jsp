<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3>NewFile.jsp</h3>
<%
//String name = request.getParameter("name");
//System.out.println(name);

String name = (String)request.getAttribute("name");
System.out.println(name);
%>

<input type="text" value="<%=name %>">

</body>
</html>



