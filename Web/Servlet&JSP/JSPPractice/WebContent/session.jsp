<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int c;

	if(request.getSession().getAttribute("count") !=null){
		c=(Integer)session.getAttribute("count");
	}else{ //카운트가 없을 때
		c= 0;
	}
	
	c++;
%>
<p>페이지에 <%=c %>번 방문했습니다.</p>

<%
session.setAttribute("count", new Integer(c));
%>
</body>
</html>