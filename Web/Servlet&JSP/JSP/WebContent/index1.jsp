<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- scriptlet의 종류 --%>

<%!
	// 선언의 영역 : 변수(global)를 선언, 함수, class
	public void func(){
		System.out.println("func() 호출");	
	}	
	int gl_num = 0;
%>

<%
	// 구현부 logic
	func();

	int num = 0;
	
	gl_num++;
	num++;
	
	out.println("gl_num = " + gl_num);
	out.println("<br>");
	out.println("num = " + num);
%>
<br><br>
<%-- value --%>
<%=123 %>



</body>
</html>






