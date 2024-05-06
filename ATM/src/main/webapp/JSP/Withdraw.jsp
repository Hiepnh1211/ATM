<%@page import="Models.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Services.UserServices, Models.User, Services.Utilities, Services.Constants"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Withdraw</title>
</head>
<body>
<div align="center">

	<%
		Utilities utils = new Utilities();
		User user = (User)session.getAttribute("user");
		double balance = user.getBalance();
		UserServices userServices = new UserServices();
	%>

	Withdrawing Money <br>
	Balance: <div id="output"></div>
		<form action="Withdraw.jsp" method="post">
   			<table style="with: 100%">
    		<tr>
    		<td></td>
     		<td>Amount</td>
     		<td><input type="text" name="amount" value = 0></td>
    		</tr>
    		<tr>
   		</table>
   		<input type="submit" value="Withdraw" />
   		</form>
   		
   		<%
   			out.print(utils.toMenu());
  			if(request.getMethod().equalsIgnoreCase("post")){
  				
  				if(request.getParameter("amount") != null){
  					try{
  						String amount = (String) request.getParameter("amount");
  						Transaction transaction = userServices.withdraw(user, Double.parseDouble(amount));
  	  	  				if(Double.parseDouble(amount) > 0 && transaction != null) {
  	  	  					
  	  	  					out.print("Withdrawed, you balance: " + balance + " -> " + user.getBalance()+"<br>");
  	  	  					out.print("Transaction ID: " + transaction.getTransactionId());
  	  	  					
  	  	  				}else if(Double.parseDouble(amount) > Constants.MAXIMUM_TRANSACTION_AMOUNT ){
  	  	  					out.print("<p style='color:red;'>You are withdrawing to much</p>");
  	  	  					
  	  	  				}else if( Double.parseDouble(amount) <= 0){
  	  	  					out.print("<p style='color:red;'>Please Withdraw</p>");
  	  	  					
  	  	  				}else if( Double.parseDouble(amount) > user.getBalance()){
  	  	  					out.print("<p style='color:red;'>You don't have enough money to withdraw</p>");
  	  	  					
  	  	  				}else{
  	  	  					out.print("<p style='color:red;'>You have ran out of withdrawing times today</p>");
  	  	  				}
  					}catch(NumberFormatException numberError){
  						out.print("<p style='color:red;'>Wrong format</p>");
  					}
  				}
  			}
  			
   		%>
   		<script>
    	var message = '<%= user.getBalance() %>';
    	document.getElementById('output').innerHTML = message;
		</script>
	</div>
</body>
</html>