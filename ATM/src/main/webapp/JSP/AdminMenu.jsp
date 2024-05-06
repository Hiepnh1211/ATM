<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Models.User, Services.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Menu</title>
</head>
<body>
	<div align="center">
	Welcome
		<%
			Utilities utils = new Utilities();
			User user = (User)session.getAttribute("user");
			out.print(user.getRole() + " " + user.getIdNumber() + "-" + user.getName());
		%>
		
	<table>
		<tr>
			<td> <%= utils.option(Constants.FUNCTION_DEPOSIT_REPORT) %> </td>
			<td> <%= utils.option(Constants.FUNCTION_WITHDRAWAL_REPORT) %> </td>
		</tr>
		<tr>
			<td> <%= utils.option(Constants.FUNCTION_ACCOUNT_REPORT) %> </td>
			<td> <%= utils.option(Constants.FUNCTION_TRANSFER_REPORT) %> </td>
		</tr>
		<tr>
			<td> <%= utils.option(Constants.FUNCTION_CREATE_USER) %> </td>
			<td> <%= utils.exit() %> </td>
		</tr>
	</table>
		
	</div>
</body>
</html>