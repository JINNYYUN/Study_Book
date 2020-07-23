<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<h3>입력페이지</h3>
<form id="frm">
	이름 : <input type="text" name="name" size="20" placeholder="이름"><br><br>
	생년월일 : <input type="text" name="birth" size="20" placeholder="생년원일"><br><br>
	
	<input type="button" id="btn" value="OK">
</form>

<script>
$(document).ready(function (){
	$("#btn").on("click", function(){
		$("#frm").attr("action","index1NewFile.jsp");
		$("#frm").submit();
	});
});
</script>
</body>
</html>