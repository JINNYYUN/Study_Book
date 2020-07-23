<%@page import="sample01.YouClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
class MyClass{
	private int num;
	private String name;
	
	public MyClass(){
		num = 2;
		name = "World";
	}
	public String print(){
		return num + " " + name;
	}
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MyClass mcls = new MyClass();
out.println(mcls.print());

YouClass ycls = new YouClass(12, "홍길동");
out.println(ycls.toString());
%>



</body>
</html>




