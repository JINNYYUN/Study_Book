<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbswrite.jsp</title>
</head>
<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
	response.sendRedirect("login.jsp");
	%>
	<script type="text/javascript">
	location.href = "";
	</script>
	<%
}
%>  

<a href="logout.jsp">로그 아웃</a>

<h1>글쓰기</h1>

<div align="center">

<form action="bbswriteAf.jsp" method="post">

	<table border="1">
	<col width="200"><col width="400">
	
	<tr>
		<th>이메일</th>
		<td>
			<%-- <input type="text" name="id" size="50px" value="<%=mem.getId() %>"> --%>
			<input type="text" name="id" size="50px" value=<%=mem.getEmail() %> readonly="readonly">
		</td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="title" size="50px">
		</td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td>
			<textarea rows="20" cols="50px" name="content"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			&nbsp;&nbsp;<input type="submit" value="글쓰기">
		</td>
	</tr>
	
	</table>

</form>
</div>

<a href="bbslist.jsp">글목록</a>


</body>
</html>




