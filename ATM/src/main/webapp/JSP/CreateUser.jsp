<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.Utilities, Models.User, Services.AdminServices, Services.Constants"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create user</title>
</head>
<body>
	<div align="center">
	<% 
		Utilities utils = new Utilities();
		AdminServices adminServices = new AdminServices();
	%>
		Create user
		<form action="CreateUser.jsp" method="post">
			<table style="width: 100%">
				<tr>
					<td>Name:</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td><select name="gender">
							<option>Male</option>
							<option>Female</option>
					</select></td>
				</tr>
				<tr>
					<td>Contact number</td>
					<td><input type="text" maxlength="10" name="contactNumber"></td>
				</tr>
				<tr>
					<td>Address:</td>
					<td><input type="text" name="address"></td>
				</tr>
				<tr>
					<td><input type="submit" value="Create"></td>
				</tr>
			</table>
		</form>
		<%=utils.toAdminMenu()%>
		<%
			if(request.getMethod().equalsIgnoreCase("post")){
				if(request.getParameter("name") != null && request.getParameter("contactNumber")!= null && request.getParameter("address")!= null){
					String name = request.getParameter("name");
					String gender = request.getParameter("gender");
					String contactNumber = request.getParameter("contactNumber");
					String address = request.getParameter("address");
					
					if(utils.checkName(name) && utils.checkContactNumber(contactNumber)){
						User newUser = adminServices.createAccount(name, contactNumber, gender, address);
						
		%>
			<table style="width: 100%">
				<tr>
					<td>User:</td>
					<td><%=newUser.getIdNumber() %></td>
				</tr>
				<tr>
					<td>PIN:</td>
					<td><%=newUser.getPin() %></td>
				</tr>
				<tr>
					<td>Name:</td>
					<td><%=newUser.getName() %></td>
				</tr>
				<tr>
					<td>Gender</td>
					<td><%=newUser.getGender() %></td>
				</tr>
				<tr>
					<td>Contact Number:</td>
					<td><%=newUser.getContactNumber() %></td>
				</tr>
				<tr>
					<td>Address:</td>
					<td><%=newUser.getAddress() %></td>
				</tr>
				<tr>
					<td>Has been created</td>
				</tr>
				
			</table>
		<%
						
					}else if(!utils.checkName(name)){
						out.print("<p style='color:red;'>Invalid name</p>");
						
					}else if(!utils.checkContactNumber(contactNumber)){
						out.print("<p style='color:red;'>Invalid contact number</p>");
					}
					
				}else if(request.getParameter("name") == null){
					out.print("<p style='color:red;'>Missing name</p>");
					
				}else if(request.getParameter("contactNumber")== null){
					out.print("<p style='color:red;'>Missing contact number</p>");
					
				}else if(request.getParameter("address")== null){
					out.print("<p style='color:red;'>Missing address</p>");
				}
			}
		%>
	</div>
</body>
</html>