<%@page import="dto.CustUserDto"%>
<%@page import="dao.CustUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>custuserdetail</title>
<style>
	body{
		width : 700px;
		margin: 0 auto;
	}
	.table{
		border-collapse:collapse;
		text-align: center;
	}
	td{
		padding : 10px;
	}
	.button{
		text-align: center;
	}
	.btn{
		
		background-color: #555555; /* Green */
		border: none;
		color: white;
		padding: 12px 24px;
		margin : 30px 5px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
	}
	
	#backBtn{
		background-color: #9e9e9e;
	}
</style>
</head>
<body>
<%
	CustUserDao dao = CustUserDao.getInstance();
	String id = request.getParameter("id");
	CustUserDto cdto = dao.searchCustUser(id);
%>
<h1>세부정보 보기</h1>
	<table style="width:700" border="1" class="table">
		<col width="100"><col width="600">
		<tr>
			<td>
				아이디
			</td>
			<td id="id"><%=cdto.getId() %></td>
		</tr>
		<tr>
			<td>
				이름
			</td>
			<td>
				<%=cdto.getName() %>
			</td>
		</tr>
		<tr>
			<td>
				주소
			</td>
			<td>
				<%=cdto.getAddress() %>
			</td>
		</tr>
	</table>
	<div class="button">
		<input type="submit" value="수정하기" class="btn" id="updateBtn">
		<input type="button" value="돌아가기" class="btn" id="backBtn">
	</div>
	
	<script>
		const updateBtn = document.querySelector("#updateBtn");
		const backBtn = document.querySelector("#backBtn");
		
		updateBtn.addEventListener("click", updateFunc);
		backBtn.addEventListener("click", backFunc);
		
		function updateFunc(event){
			let id = document.getElementById("id").innerHTML;
			
		//	alert(id);
			location.href = "custuserupdate.jsp?id=" + id;
		}
		
		function backFunc(event){
			location.href = "custuserlist.jsp";
		}
	</script>
</body>
</html>