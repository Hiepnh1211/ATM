<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1" import="Services.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ID Check</title>
</head>
<body>
 <div align="center">
  <h1>ATM Login Form</h1>
  <form action="IdCheck.jsp" method="post">
   <table style="with: 100%">
    <tr>
     <td>User ID</td>
     <td><input type="text" maxlength="8" name="username" /></td>
    </tr>
    <tr>
   </table>
   <input type="submit" value="Submit" />
  </form>
  <% 
 		Utilities utils = new Utilities();
		if (request.getMethod().equalsIgnoreCase("post")) {
        	String username = request.getParameter("username");
        	
        	if (utils.getUserById(username) != null) {
            	session.setAttribute("user", utils.getUserById(username));
            	response.sendRedirect(request.getContextPath() + "/JSP/Password.jsp");
        		
        	}else if(username.length() < 8){
        		out.println("<p style='color:red;'>Invalid username</p>");
        	}
    	}
	%>
 </div>
</body>
</html>