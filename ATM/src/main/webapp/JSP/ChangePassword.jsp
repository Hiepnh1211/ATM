<%@page import="java.util.concurrent.Delayed"%>
<%@page import="Services.UserServices"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Models.User, Services.Utilities"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
</head>
<body>
	<%
		Utilities utils = new Utilities();
		User user = (User)session.getAttribute("user");
	%>
		
	Change password
	<form action="ChangePassword.jsp" method="post">
		<table style="with: 100%">
    		<tr>
     		<td>Old Password</td>
     		<td><input type="password" name="oldPass" maxlength="4"></td>
     		</tr>
     		<tr>
     		<td>New Password</td>
     		<td><input type="password" name="newPass" maxlength="4"></td>
     		</tr>
     		<tr>
     		<td>Confirm New Password</td>
     		<td><input type="password" name="confirmNewPass" maxlength="4"></td>
    		</tr>
   		</table>
   		<input type="submit" value="Change password" />
	</form>
	
	<% 
		out.print(utils.toMenu());
		if(request.getMethod().equalsIgnoreCase("post")){
			String oldPassword = (String) request.getParameter("oldPass");
			String newPassword = (String) request.getParameter("newPass");
			String confirmNewPassword = (String) request.getParameter("confirmNewPass");
			
			if(oldPassword != null){
				if(!oldPassword.equals(user.getPin())) {
					out.print("<p style='color:red;'>Invalid password</p>");
				}else if(!newPassword.equals(confirmNewPassword)){
					out.print("<p style='color:red;'>Unable to confirm new password</p>");
				}else if(newPassword.length() < 4){
					out.print("<p style='color:red;'>new password too short</p>");
				}else{
					UserServices userServices = new UserServices();
					userServices.changePassword(user, oldPassword, newPassword, confirmNewPassword);
					out.print("<p>Your password has been successfully change</p>");
					response.sendRedirect(request.getContextPath() + "/JSP/IdCheck.jsp");
				}
			}else{
				out.print("<p style='color:red;'>Please input you password</p>");
			}
		}
	%>
</body>
</html>