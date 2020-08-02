<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq);
%>
<%
	MemberDto mem = (MemberDto)request.getSession().getAttribute("login");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//부모글(기본글)
	BbsDao dao = BbsDao.getInstance();
	BbsDto parentBbs = dao.getBbs(seq);
%>

<!--테이블은 총 2개-->
<div align="center">
	<!--
	<1번 테이블> - 부모글(뿌려주는 역할)
	기본글
		작성자
		제목
		작성일
		조회수
		정보
		내용 > 원래 READONLY로 만들어야 함.
	 -->
	<h1>원본 글</h1>
	
	<table border="1">
	<colgroup>
		<col style="width: 200px">
		<col style="width: 400px">
	</colgroup>
	
	<tr>
		<th>작성자</th>
		<td><%=parentBbs.getEmail() %></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><%=parentBbs.getTitle() %></td>
	</tr>
	
	<tr>
		<th>작성일</th>
		<td><%=parentBbs.getWdate() %></td>
	</tr>
	
	<tr>
		<th>조회수</th>
		<td><%=parentBbs.getReadcount() %></td>
	</tr>
	
	<tr>
		<th>정보</th>
		<td></td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td align="center">
		<textarea rows="15" cols="90" readonly="readonly"><%=parentBbs.getContent() %></textarea>
		</td>
	</tr>
	</table>
<hr>
	<%-- <2번 테이블>
	답글
		로그인이메일(세션에 들어있는 이메일 정보)
		제목
		내용
	 --%>
	<h1>답글</h1>
	<form action="answerAf.jsp" method="post">
	<input type="hidden" name="seq" value="<%=parentBbs.getSeq() %>" >
	<table border="1">
	<colgroup>
		<col style="width: 200px">
		<col style="width: 400px">
	</colgroup>
	
	<tr>
		<th>작성자</th>
		<td>
			<%-- <input type="text" name="id" size="50px" value="<%=mem.getId() %>"> --%>
			<input type="text" name="email" size="50px" value=<%=mem.getEmail() %> readonly="readonly">
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
	</table>
	<button type="submit" value="댓글 작성">댓글작성</button>
	</form>
</div>
 
</body>
</html>