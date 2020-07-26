<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
body {
	display : flex;
	justify-content : center;
	
	align-items : center;
	align-content : center;
}

#btn {
	margin : auto;
	
	background-color: #555555; /* Green */
	border: none;
	color: white;
	padding: 12px 24px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
}
</style>

</head>
<body>
<input type="button" value="고객목록 바로가기" id="btn"> 

<script>
	const adminBtn = document.getElementById("btn");
	
	adminBtn.addEventListener("click", pageFunc);
	
	function pageFunc(event){
		location.href = "custuserlist.jsp";
	}
	
</script>

</body>
</html>