<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
%>        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsdetail.jsp</title>
<style>
.container{
	
	width : 800px;
	margin : 0 auto;
}

.buttonbox{
	text-align : right;
	padding-top : 5px;
}


.answerbox {
	display : flex;
	justify-content : center;
	padding : 20px;
}


</style>

</head>
<body>
<!-- 
	<table>
	작성자(id)	<td>
	제목
	작성일(wdate)
	조회수
	정보
	내용	textarea
 -->

<%
MemberDto mem = (MemberDto)request.getSession().getAttribute("login");
%>

<%
BbsDao dao = BbsDao.getInstance();

dao.readcount(seq);
BbsDto bbs = dao.getBbs(seq);
%>

<div class="container">
<h1>상세 글 보기</h1>



<table border="1">
<colgroup>
	<col style="width: 200px">
	<col style="width: 600px">
</colgroup>

<tr>
	<th>작성자</th>
	<td><%=bbs.getEmail() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=bbs.getTitle() %></td>
</tr>

<tr>
	<th>작성일</th>
	<td><%=bbs.getWdate() %></td>
</tr>

<tr>
	<th>조회수</th>
	<td><%=bbs.getReadcount() %></td>
</tr>

<tr>
	<th>정보</th>
	<td><%=bbs.getRef() %>-<%=bbs.getStep() %>-<%=bbs.getDepth() %></td>
</tr>

<tr>
	<th>내용</th>
	<td align="center">
	<textarea rows="15" cols="90" readonly="readonly"><%=bbs.getContent() %></textarea>
	</td>
</tr>
</table>
<div align="right" class="buttonbox">
<%
	//글작성자와 로그인한 사람이 동일할 때 수정과 삭제가 가능하다.
	if(bbs.getEmail().equals(mem.getEmail())){
		%>
		<button type="button" onclick="updateBbs(<%=bbs.getSeq()%>)" class="button">수정</button>
		<button type="button" onclick="deleteBbs(<%=bbs.getSeq()%>)" class="button">글 삭제</button>
		<%
	}
	//글목록으로 돌아가는 버튼 추가
%>
</div>
<!-- 댓글 방법 1
<button type="button" onclick="answer(<%=bbs.getSeq()%>)">댓글</button>
 -->
<!-- 댓글 방법 2-->
<div class="answerbox">
<form action="answer.jsp" method="get">
	<input type="hidden" name="seq" value="<%=bbs.getSeq()%>">
	<input type="submit" value="댓글쓰기">
</form> 
</div>
</div>

<script>
function updateBbs(seq){
	location.href="bbsupdate.jsp?seq="+seq;
}
function deleteBbs(seq){
	location.href="bbsdelete.jsp?seq="+seq;
}
</script>
</body>
</html>




