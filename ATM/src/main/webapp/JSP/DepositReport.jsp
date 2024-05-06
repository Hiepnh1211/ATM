<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.*, java.util.List, Models.Transaction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Withdrawal report</title>
</head>
 <%= Constants.TABLE_STYLE %>
<body>
<div align="center">

	<% 
		Utilities utils = new Utilities();
		AdminServices adminServices = new AdminServices();
	%>

	Withdrawal report
	<% out.print(Constants.DATE_PICKER); %>
	<form action="DepositReport.jsp" method="post">
		<label for="datepicker">Select Date:</label>
		<input type="text" id="datepicker" name="date">
		<button type="submit">Submit</button>
	</form>
	<table>
			<tr>
				<th>Name</th>
    			<th>User ID</th>
    			<th>Withdraw Amount</th>
    			<th>Balance</th>
			</tr>
	
	<%
		out.print(utils.toAdminMenu()); 
		if(request.getMethod().equalsIgnoreCase("post")){
			
			if(request.getParameter("date") != null){
				String date = request.getParameter("date"); 
				String[] pickedDate = date.split("/");
				Date checkDate = Date.valueOf(LocalDate.of(Integer.valueOf(pickedDate[2]), Integer.valueOf(pickedDate[0]), Integer.valueOf(pickedDate[1])));
				List<Transaction>withdrawalRecord = adminServices.depositReport(checkDate);
				
				for(Transaction transaction : withdrawalRecord){			
				
	%>
		
			<tr>
				<td><%= utils.getUserById(transaction.getIdNumber()).getName() %></td>
				<td><%= transaction.getIdNumber() %></td>
				<td><%= transaction.getAmount() %></td>
				<td><%= transaction.getBalance() %></td>
			</tr>
	
	<%
				}
			}
		}
	%>
	</table>
</div>
</body>
</html>