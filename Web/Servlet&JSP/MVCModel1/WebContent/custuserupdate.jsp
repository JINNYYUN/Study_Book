<%@page import="dto.CustUserDto"%>
<%@page import="dao.CustUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보 수정하기</title>

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
	td:last-child{
		padding : 0px 0px;
	}
	td input{
		width : 100%;
		height : 42px;
		padding :0px;
	}
</style>
</head>
<body>
<%
	CustUserDao dao = CustUserDao.getInstance();
	String id = request.getParameter("id");
	CustUserDto cdto = dao.searchCustUser(id);
%>
<h1>고객 정보 수정하기</h1>
	<table style="width:700" border="1" class="table">
		<col width="100"><col width="600">
		<tr>
			<td>
				아이디
			</td>
			<td id="id">
				<%=cdto.getId() %>
			</td>
		</tr>
		<tr>
			<td>
				이름
			</td>
			<td id="name">
				<%=cdto.getName() %>
			</td>
		</tr>
		<tr>
			<td>
				주소
			</td>
			<td>
				<input type="text" id="address" size="20" value="<%=cdto.getAddress() %>">
			</td>
		</tr>
	</table>
	<div class="button">
		<input type="button" value="수정하기" class="btn" id="updateBtn">
		<input type="button" value="취소" class="btn" id="cancelBtn">
	</div>
	
	<script>
		const updateBtn = document.querySelector("#updateBtn");
		const cancelBtn = document.querySelector("#cancelBtn");
		
		updateBtn.addEventListener("click", updateFunc);
		cancelBtn.addEventListener("click", cancelFunc);
		
		function updateFunc(event){
			let id = document.getElementById("id").innerHTML;
			let name = document.getElementById("name").innerHTML;
			let address = document.getElementById("address").value;
		//	alert(address);
			location.href = "custuserupdateAf.jsp?id=" + id+"&name="+name+"&address="+address;
		}
		
		function cancelFunc(event){
			location.href = "custuserlist.jsp";
		}
	</script>
</body>
</html>