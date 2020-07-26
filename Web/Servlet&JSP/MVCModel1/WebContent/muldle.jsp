<%@page import="dao.CustUserDao"%>
<%@page import="dto.CustUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	String delck[] = request.getParameterValues("delck");
	
	CustUserDao dao = CustUserDao.getInstance();
	
	boolean isS = true;
	
	if(delck != null){
		isS = dao.deleteCustUsers(delck);
		
		/*
		for(int i = 0; i<delck.length; i++){
			System.out.println(delck[i]);
			
			dao.deleteCustUser(delck[i]);
		}
		*/
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>muldle.jsp</title>
</head>
<body>
<%
	if(isS==true){
		%>
		<script>
		alert("삭제되었습니다.");
		location.href = "custuserlist.jsp";
		</script>
		<% 
	}else{
		%>
		<script>
		alert("삭제되지 않았습니다");
		location.href = "custuserlist.jsp";
		</script>
		<% 
	}
%>
</body>
</html>