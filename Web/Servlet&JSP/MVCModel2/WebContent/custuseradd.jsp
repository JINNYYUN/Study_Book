<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>custuseradd</title>

<style>
	body{
		width : 400px;
		margin: 0 auto;
	}
	table{
		border-top: 1px solid #444444;
    	border-collapse: collapse;
		text-align: center;
	}
	
	th, td {
	    border-bottom: 1px solid #444444;
	
  	}
  	.tag{
  		background-color : #f6f6f6;
  	}
  	.input{
  		text-align: left;
  	}
  	.buttonBox{
		text-align: center;
	}
	td input{
		width : 100%;
		height : 43px;
		
		padding :0px;
	}
	
	.btn{
		background-color: #555555;
		border: none;
		color: white;
		padding: 12px 24px;
		margin : 20px 5px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 13px;
	}
	#cancelBtn{
		background-color: #9e9e9e;
	}
</style>
</head>
<body>
<h1>고객 추가</h1>

<form action="adduser" method="post">
<input type="hidden" name="work" value="dataSave">
<table>
	<col width="100px"><col width="300px">
	
	<tr>
		<th class="tag">아이디</th>
		<td class="input">
			<input type="text" name="id" size="20">
		</td>
	</tr>
	
	<tr>
		<th class="tag">이름</th>
		<td class="input">
			<input type="text" name="name" size="20">
		</td>
	</tr>	
	<tr>
		<th class="tag">주소</th>
		<td class="input">
			<input type="text" name="address" size="20">
		</td>
	</tr>
	
</table>
<div class="buttonBox">
	<input type="submit" value="고객추가" class="btn">
	<input type="reset" value="취소" class="btn" id="cancelBtn">
</div>

</form>

</body>
</html>