<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	int seq = Integer.parseInt(request.getParameter("seq"));
	String email= request.getParameter("email");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	//확인용
	System.out.println("seq:"+ seq);
	System.out.println("email:"+email);
	System.out.println("title:"+title);
	System.out.println("content:"+content);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>answerAf</title>
</head>
<body>
<%
	BbsDao dao = BbsDao.getInstance();
	boolean isS = dao.answer(seq, new BbsDto(email,title,content));
	
	if(isS){
		%>
		<script>
			alert("답글 입력 성공!");
			location.href = "bbslist.jsp";
		</script>
		<%
	}
	else{
		%>
		<script>
			alert("답글 입력 실패");
			location.href="bbslist.jsp";
		</script>
		
		<%
	}
%>
</body>
</html>