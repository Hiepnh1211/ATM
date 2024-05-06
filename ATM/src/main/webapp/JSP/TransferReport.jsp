<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.*, java.util.List, Models.Transfer, Models.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer report</title>
</head>
<%= Constants.TABLE_STYLE %>
<body>
	<div align="center">
	<% 
		Utilities utils = new Utilities();
		AdminServices adminServices = new AdminServices();
	%>
	
	Transfer report
	<%= Constants.DATE_PICKER %>
	<form action="TransferReport.jsp" method="post">
		<label for="datepicker">Select Date:</label>
		<input type="text" id="datepicker" name="date">
		<button type="submit">Submit</button>
	</form>
	
	<table>
		<tr>
			<th>Sender Name</th>
    		<th>Sender ID</th>
    		<th>Sender Balance</th>
    		<th>Transfer Amount</th>
    		<th>Receiver Name</th>
    		<th>Receiver ID</th>
    		<th>Receiver Balance</th>
		</tr>
		
	<%
		out.print(utils.toAdminMenu()); 
		if(request.getMethod().equalsIgnoreCase("post")){
			
			if(request.getParameter("date") != null){
				String date = request.getParameter("date"); 
				String[] pickedDate = date.split("/");
				Date checkDate = Date.valueOf(LocalDate.of(Integer.valueOf(pickedDate[2]), Integer.valueOf(pickedDate[0]), Integer.valueOf(pickedDate[1])));
				List<Transfer> transferRecord = adminServices.transferReport(checkDate);
				
				for(Transfer transfer : transferRecord){			
				
	%>
			<tr>
				<td><%= utils.getUserById(transfer.getIdNumber()).getName() %></td>
				<td><%= transfer.getIdNumber() %></td>
				<td><%= transfer.getBalance() %></td>
				<td><%= transfer.getAmount() %></td>
				<td><%= utils.getUserById(transfer.getReceiverID()).getName() %></td>
				<td><%= transfer.getReceiverID() %></td>
				<td><%= transfer.getReceiverBalance() %></td>
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