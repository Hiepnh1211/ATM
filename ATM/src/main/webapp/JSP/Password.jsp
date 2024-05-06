<%@page import="Services.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Models.User, Services.UserServices, Services.Utilities"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Password Check</title>
</head>
<body>
	<div align="center">
		Welcome
		<%
			Utilities utils = new Utilities();
			User user = (User)session.getAttribute("user");
			out.print(user.getRole() + " " + utils.padLeftZeros(user.getIdNumber(), Constants.ID_NUMBER_LENGTH));
		%>
		
		  <form action="Password.jsp" method="post">
   			<table style="with: 100%">
    		<tr>
     		<td>Password</td>
     		<td><input type="password" maxlength="4" name="password" /></td>
    		</tr>
    		<tr>
   		</table>
   		<input type="submit" value="Log in" />
  </form>
  <% 
  		out.print(utils.exit());
  		UserServices userServices = new UserServices();
  		if(request.getMethod().equalsIgnoreCase("post")){
  			String password = request.getParameter("password");
  			
  			if(password.length() == 4){
  				if(userServices.checkPassword(user.getIdNumber(), password)){
  	  				session.setAttribute("user", user);
  	  				if(user.getRole().equals("User")){
  	  					response.sendRedirect(request.getContextPath() + "/JSP/UserMenu.jsp");
  	  				}else if(user.getRole().equals("Admin")){
  	  					response.sendRedirect(request.getContextPath() + "/JSP/AdminMenu.jsp");
  	  				}
  	  				
  	  			}else{
  	  				out.println("<p style='color:red;'>Invalid password</p>");
  	  			}
  			}else{
  				out.println("<p style='color:red;'>Invalid password</p>");
  			}

  		}
  %>
	</div>
</body>
</html>