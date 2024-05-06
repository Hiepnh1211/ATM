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
			<td> <%= utils.option(Constants.FUNCTION_DEPOSIT) %> </td>
			<td> <%= utils.option(Constants.FUNCTION_WITHDRAW) %> </td>
		</tr>
		<tr>
			<td> <%= utils.option(Constants.FUNCTION_BALANCE_ENQUIRY) %> </td>
			<td> <%= utils.option(Constants.FUNCTION_TRANSFER_MONEY) %> </td>
		</tr>
		<tr>
			<td> <%= utils.option(Constants.FUNCTION_CHANGE_PASSWORD) %> </td>
			<td> <%= utils.exit() %> </td>
		</tr>
	</table>
		
	</div>
</body>
</html>