<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.* , java.util.List, Models.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account report</title>
</head>
 <%= Constants.TABLE_STYLE %>
<body>
	<div align="center">
		<% 
			Utilities utils = new Utilities();
			AdminServices adminServices = new AdminServices();
		%>
		
		Account report
		<table>
			<tr>
				<th>Name</th>
    			<th>User ID</th>
    			<th>PIN</th>
    			<th>Contact number</th>
    			<th>Gender</th>
			</tr>
			
			<% 
				out.print(utils.toAdminMenu());
					List<User> userList = adminServices.accountReport();
					for(User user : userList){
						
					
			%>
			<tr>
				<td><%=user.getName()%></td>
				<td><%=utils.padLeftZeros(user.getIdNumber(), Constants.ID_NUMBER_LENGTH) %></td>
				<td><%=utils.padLeftZeros(user.getPin() , Constants.ID_PIN_LENGTH)%></td>
				<td><%=user.getContactNumber() %></td>
				<td><%=user.getGender() %></td>
			</tr>
			<%
					}
			%>
		</table>
	</div>
</body>
</html>