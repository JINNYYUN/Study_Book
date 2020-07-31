<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
	String email = request.getParameter("user[email]");
	String pwd = request.getParameter("user[password]");
	String name = request.getParameter("user[name]");
	
	System.out.println("email:" + email);
	System.out.println("pwd:" + pwd);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberDao dao = MemberDao.getInstance();

boolean isS = dao.addMember(new MemberDto(email, pwd, name, 0));

if(isS){
%>
	<script type="text/javascript">
	alert("성공적으로 가입되었습니다");
	location.href = "login.html";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("다시 기입해 주십시오");
	location.href = "sign_up.jsp";
	</script>
<%
}
%>
</body>
</html>