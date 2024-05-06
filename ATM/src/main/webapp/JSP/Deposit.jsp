<%@page import="Models.Transaction"%>
<%@page import="Services.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.UserServices, Models.User, Services.Utilities, Services.Constants"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deposit</title>
</head>
<body>
	<div align="center">
	
	<%
		Utilities utils = new Utilities();
		User user = (User)session.getAttribute("user");
		double balance = user.getBalance();
		UserServices userServices = new UserServices();
	%>
	
	Deposit Money <br>
	Balance: <div id="balance"></div>
		<form action="Deposit.jsp" method="post">
   			<table style="with: 100%">
    		<tr>
     		<td>Amount</td>
     		<td><input type="text" step="0.01" name="amount" value = 0></td>
    		</tr>
    		<tr>
   		</table>
   		<input type="submit" value="Deposit" />
   		</form>
   		
   		<%
			out.print(utils.toMenu());
  			if(request.getMethod().equalsIgnoreCase("post")){
  				
  				if(request.getParameter("amount") != null){
  					try{
  						String amount = (String)request.getParameter("amount");
  						Transaction transaction = userServices.deposit(user, Double.parseDouble(amount));
  	  					
  	  	  				if(Double.parseDouble(amount) > 0 && transaction !=null) {
  	  	  					out.print("Deposited, you balance: " + balance + " -> " + user.getBalance() +"<br>");
  	  	  					out.print("Transaction ID: " + transaction.getTransactionId());
  	  	  					
  	  	  				}else if(Double.parseDouble(amount) > Constants.MAXIMUM_TRANSACTION_AMOUNT){
  	  	  					out.print("<p style='color:red;'>You are depositting to much</p>");
  	  	  					
  	  	  				}else if( Double.parseDouble(amount) <= 0){
  	  	  					out.print("<p style='color:red;'>Please Deposit</p>");
  	  	  					
  	  	  				}else{
  	  	  					out.print("<p style='color:red;'>You have ran out of depositting times today</p>");
  	  	  				}
  					}catch(NumberFormatException numberError){
  						out.print("<p style='color:red;'>Wrong format</p>");
  					}
  				}	
  			}
   		%>
   		<script>
    	var message = '<%= user.getBalance() %>';
    	document.getElementById('balance').innerHTML = message;
		</script>
	</div>
</body>
</html>