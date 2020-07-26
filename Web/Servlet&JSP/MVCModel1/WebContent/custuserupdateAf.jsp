<%@page import="dto.CustUserDto"%>
<%@page import="dao.CustUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	
	System.out.println(id+" " +name+" "+ address);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>custuserupdateAf</title>
</head>
<body>
<%
	CustUserDao dao = CustUserDao.getInstance();
	
	boolean updateCheck = dao.updateCustUser(new CustUserDto(id, name, address));
	
	if(updateCheck){
		%>
		<script type="text/javascript">
			alert('성공적으로 수정되었습니다.');
			
			let id = "<%=id%>";
		//	location.href = "custuserlist.jsp";
			location.href = "custuserdetail.jsp?id=" +id;
		</script>
		<%	
	}else{
		%>
		<script type="text/javascript">
			alert('수정에 실패했습니다.');
			let id = "<%=id%>";
			location.href = "custuserdetail.jsp?id=" +id;
		</script>
		<%
	}
	%>
</body>
</html>