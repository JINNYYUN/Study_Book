<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String str = "Hello JSP";
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- HTML 주석문 -->

<%-- JSP 주석문 --%>

<%--
	JSP : Java Server Page
	
								  Web Application Server
					request
Client				---- >		Web Server   -- > Container		-- > DB(Server)
html								대기			Servlet(Get, Post)
Java Script										  java(html)
CSS									해석				JSP(--)	
JQuery(Ajax)		< ----
Vue, React			response
 --%>
 
<h1>Hello JSP</h1>

<%
	// java 영역
	// Scriptlet = script + applet 
	System.out.println("console 출력");

	/*
		내장(암시)객체 : new를 통해서 생성하지 않고 바로 사용할 수 있는 class
				
		out			-> Scriptlet(java)에서 Web으로 출력해 주는 객체
		request		-> 매개변수의 값을 취득하는 경우 사용하는 객체, 객체를 저장시에도 사용
		response	-> 이동을 실시하는 객체. sendRedirect
		session		-> 객체를 저장시에도 사용
		pageContext -> forward
				
	*/

%>

<%
out.println("<h3>Hello Jsp</h3>");
%>

<%
System.out.println("str = " + str);
out.println("str = " + str);	
%>
<br>
<%=str %>

<%
for(int i = 0;i < 10; i++){
%>
	<p class="demo">p tag <%=i %></p>
<%
}
%>	

<%
for(int i = 0;i < 10; i++){
	out.println("<p class='demo'>p tag " + i + "</p>");	
}
%>

<%--
	jsp, html 차이점
	jsp = java + html
	html은 입력받고 넘겨주는 처리가 가능. 넘겨 받은 값을 출력해 주는 것은 어렵다 -> Ajax 	
 --%>
 
str:<input type="text" value="<%=str %>">
<br>
<p><%=str %></p>

<textarea rows="10" cols="20"><%=str %></textarea>


</body>
</html>







