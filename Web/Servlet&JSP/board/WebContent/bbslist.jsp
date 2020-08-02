<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
	//댓글의 depth와 image를 추가하는 함수	depth=1 > ' ' /	depth=2 > '  '
	//이미지와 여백을 만들어주는 함수
	public String arrow(int depth){
		String rs = "<img src='./image/arrow.png' width='20px' height='20px'>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; //여백
		
		String ts = "";
		
		for(int i=0; i<depth; i++){
			ts += nbsp;
		}
		
		//depth가 0이면 앞에 아무것도 넣지 말고
		//depth가 0이 아니면 '공백 + 이미지'를 추가한다.
		return depth==0? "":ts+rs;
	}
%>
    
<%
	Object ologin = session.getAttribute("login");
	MemberDto mem = null;
	if(ologin == null){
		%>
		<script>
		alert("로그인 해 주십시오");
		location.href = "login.html";
		</script>
		<%
	}else{
		mem = (MemberDto)ologin;
	}

%>

<%
	//검색
	String choice = request.getParameter("searchOption");
	String searchWord = request.getParameter("searchWord");
	
	System.out.println("choice:" + choice);
	System.out.println("searchWord:" + searchWord);
	
	//검색카테고리가 지정되지 않았을 경우
	if(choice == null || choice.equals("")){
		choice = "sel"; //임시 값으로 지정해준다.
		searchWord = "";
	}
	
	//검색 입력값이 입력되지 않았을 경우
	if(searchWord == "" || searchWord == null){
		searchWord = "";
		choice = "sel";
	}
%>

<%	//리스트를 불러옴
	BbsDao dao = BbsDao.getInstance();
//	List<BbsDto> list = dao.getBbsList();
//	List<BbsDto> list = dao.getBbsList(choice, searchWord);
%>

<% //페이징을 위한 전체 글의 갯수를 가져온다.

	String spageNumber = request.getParameter("pageNumber");
	int pageNumber = 0; //현재 페이지(처음 들어왔을 때)
	if(spageNumber !=null && !spageNumber.equals("")){	//파라미터가 넘어왔을 때(느낌표에 주의)
		pageNumber = Integer.parseInt(spageNumber);
	}
	System.out.println("pageNumber: " + pageNumber);
	
	List<BbsDto> list = dao.getBbsPagingList(choice, searchWord, pageNumber);
	
//	int len = dao.getAllBbs();
	int len = dao.getAllBbs(choice, searchWord);
	System.out.println("총 글의 갯수 : " + len);
	
	int bbsPage = len/10;
	if(len % 10 > 0){
		bbsPage = bbsPage+1; 
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판리스트</title>
<style>
	.container{
		width : 820px;
		margin : 0 auto;
	}
</style>

	<script type="text/javascript">
		$(document).ready(function () {
			let searchWord = "<%=searchWord %>";
			if (searchWord == "") return;

			let obj = document.getElementById("choice");
			obj.value = "<%=choice%>";
			obj.setAttribute("selected", "selected");
		});
	</script>

</head>
<body>
<h3 align = "right">
	환영합니다<%=mem.getName() %>님
</h3>
<div class="container">
<h1>게시판</h1>
	<table border="1">
		<col width="70"><col width="600"><col width="150">
		<tr>
			<th>번호</th><th>제목</th><th>작성자</th>
		</tr>

		<%
		if(list == null || list.size() == 0){
		%>
			<tr>
				<td colspan="3">작성된 글이 없습니다</td>
			</tr>
			<%
		}else{	
			for(int i = 0;i < list.size(); i++){
			BbsDto bbs = list.get(i);
			%>
				<tr>
					<th><%=i+1 %></th>
					<td>
						<%=arrow(bbs.getDepth()) %>
						<%
						if(bbs.getDel()==1){
						%>
							삭제된 게시글입니다.
						<% 
						} else{
							%>
							<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a>
							<%
						}
						 %>
						
					</td>
					<td align="center"><%=bbs.getEmail()%></td>
				</tr>
			<%
				}
			}
			%>
		</table>
	<div align="center">	
		<%
		for(int i = 0;i < bbsPage; i++){
			if(pageNumber == i){	// 1 [2] [3] 
				%>
				<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
					[<%=i+1 %>]
				</span>&nbsp;
			<%
			}
			else{	// 그외 페이지
			%>
				<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)" 
					style="font-size: 15pt; color: #000; font-weight:bold;  text-decoration: none">
					[<%=i+1 %>]
				</a>&nbsp;		
			<%
			}	
		}
		%>
	</div>	
		
	<br>
	<div align="right">
		<a href="bbswrite.jsp" >글쓰기</a>
	</div>
	<br>
	<div id="searchForm" align = "center">
	    <select name="searchOption" id="searchOption">        
	        <option value="TITLE">제목</option>
	        <option value="CONTENT">내용</option>
	        <option value="EMAIL">이메일</option>
	    </select>
	    <input type="text" name="searchWord" id="searchWord" value="<%=searchWord %>">
	    <button onclick="searchBbs()">검색</button>
	</div>
</div>

<script type="text/javascript">
	function searchBbs(pageNum){
		var searchOption = document.getElementById("searchOption").value;
		var searchWord = document.getElementById("searchWord").value;
		
		location.href = "bbslist.jsp?searchOption=" + searchOption + "&searchWord=" + searchWord;
	}

	function goPage(pageNum){
		
		var searchOption = document.getElementById("searchOption").value;
		var searchWord = document.getElementById("searchWord").value;
		
		location.href = "bbslist.jsp?searchOption=" + searchOption + "&searchWord=" + searchWord + "&pageNumber=" + pageNum;
	}
</script>

</body>
</html>