<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- request(요청) --%>
<%
	// = getParameter( name문자열 )

	// setAttribute( 객체의 해당 문자열  , 객체 )
	// = getAttribute( 객체의 해당 문자열 )

	// [] = getParameterValues

	// HttpServletRequest
	String name = request.getParameter("name");
	System.out.println("name:" + name);
	
	String age = request.getParameter("age");
	System.out.println("age:" + age);
	
	String hobby[] = request.getParameterValues("hobby");
	
	if(hobby != null && hobby.length > 0){
		for(int i = 0;i < hobby.length; i++){
			System.out.println("hobby:" + hobby[i]);
		}
	}

%>

</body>
</html>