<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String email = request.getParameter("user[email]");
	String pwd = request.getParameter("user[password]");
	
	System.out.println("email:" + email + "pwd:" + pwd);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAfter.jsp</title>
</head>
<body>
	<%
	MemberDao dao = MemberDao.getInstance();
	MemberDto mem = dao.login(email, pwd);
	System.out.println(mem.getEmail());
	//로그인 성공
	if(mem != null && !mem.getEmail().equals("")){	
		//login정보 저장(session)
		session.setAttribute("login", mem);
		session.setMaxInactiveInterval(30*60*60); //세션 유지 시간
	%>
		<script type="text/javascript">
			alert("안녕하세요 <%=mem.getName()%>님");
			location.href = "./bbslist.jsp";
		</script>
	<%
	}else{	//로그인 실패
	%>
		<script>
			alert("이메일과 비밀번호를 확인해주세요");
			location.href= "./login.html";
		</script>
	<%
	}
%>
</body>
</html>