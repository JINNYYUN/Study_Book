<%@page import="dto.CustUserDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CustUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CustUserDao dao = CustUserDao.getInstance();
	List<CustUserDto> list = dao.getCustUserList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>custuserlist</title>
<style>
	body{
		width : 700px;
		margin: 0 auto;
	}
	table{
		border-top: 1px solid #444444;
    	border-collapse: collapse;
		text-align: center;
	}
	
	th, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
  	}
	
	.buttonBox{
		text-align: center;
	}
	
	.btn{
		background-color: #555555; /* Green */
		border: none;
		color: white;
		padding: 12px 24px;
		margin : 20px 5px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
	}
	
	#deleteBtn{
		
		margin-top : 5px;
		
	}
</style>
</head>
<body>

<h1>고객목록</h1>

<form action="muldle.jsp" method="post">
	<table style="width:700">
		<col width="100"><col width="300"><col width="300">

		<tr bgcolor="#f6f6f6">
			<th bgcolor="bdbdbd">
				<input type="checkbox" name="alldel" onclick="deletechecks(this.checked)">
			</th>
			<th>ID</th>
			<th>NAME</th>
		</tr>

		<%
			if(list.size()==0){	//하나도 없다
				%>
				<tr bgcolor = "#f6f6f6">
					<td colspan = "3" align="center">고객 리스트가 존재하지 않습니다.</td>
				</tr>

				<%
			}else{	//있다
				for(int i = 0; i<list.size(); i++){
					CustUserDto cust = list.get(i);
					%>
					<tr >
						<td align="center" bgcolor="#f6f6f6">
							<input type="checkbox" name="delck" value="<%=cust.getId()%>">
						</td>
						<td>
							<%=cust.getId() %>
						</td>
						<td>
							<a href="custuserdetail.jsp?id=<%=cust.getId()%>">
								<%=cust.getName() %>
							</a>
						</td>
					</tr>
					<%
				}
			}
		%>		
	</table>
	<input type="submit" value="고객정보 삭제" id="deleteBtn">
	<div class="buttonBox">
	
		<input type="button" value="고객정보 추가" class="btn" id="addBtn">
	</div>
	
</form>
<script>
	function deletechecks( ch ){
		//오브젝트를 가져온다
		let arrCheck = document.getElementsByName("delck");
		
		for(let i=0; i<arrCheck.length; i++){
			arrCheck[i].checked = ch;
		}
	}
</script>
<script>
	const addBtn = document.querySelector("#addBtn");
	
	addBtn.addEventListener("click", addFunc);
	
	function addFunc(event){
		location.href = "custuseradd.jsp";
	}	
</script>
</body>
</html>