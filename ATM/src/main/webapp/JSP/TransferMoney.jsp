<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Models.User, Services.UserServices, Services.Utilities ,Models.Transaction, Models.Transfer"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer money</title>
</head>
<body>
		<%
			User user = (User)session.getAttribute("user");
			Utilities utils = new Utilities();
			UserServices userServices = new UserServices();
		%>
		User: <%= user.getIdNumber() %> <br>
		Name: <%= user.getName() %> <br>
		Balance: <div id="output"></div> <br>
		
		<form action="TransferMoney.jsp" method="post">
			<table style="with: 100%">
    		<tr>
     		<td>Receiver</td>
     		<td><input type="number" name="receiver" maxlength="8"></td>
     		</tr>
     		<tr>
     		<td>Amount</td>
     		<td><input type="text" step="0.01" name="amount" value=0></td>
     		</tr>
     		</table>
     		<input type="submit" value="Transfer">
		</form>
		
		<%
			out.print(utils.toMenu());
			if(request.getMethod().equalsIgnoreCase("post")){
				
				if(request.getParameter("amount") != null && request.getParameter("receiver")!= null){
					try{
						String amount = (String)request.getParameter("amount");
						String receiver = (String)request.getParameter("receiver");
						
						if(utils.getUserById(receiver) != null && Double.parseDouble(amount) > 0 && Double.parseDouble(amount) <= user.getBalance()){
							Transfer transfer = userServices.trasferMoney(user, utils.getUserById(receiver), Double.parseDouble(amount));
							out.print("Money transfered to User - " + receiver + " by " + amount + "<br>");
							out.print("Transfer ID: " + transfer.getTransactionId());
							
						}else if(utils.getUserById(receiver) == null) {
							out.print("<p style='color:red;'>Unable to find receiver</p>");
							
						}else if(Double.parseDouble(amount) <= 0){
							out.print("<p style='color:red;'>Unable to transfer</p>");
							
						}else if(Double.parseDouble(amount) > user.getBalance()) {
							out.print("<p style='color:red;'>Your balance is not enough to transfer</p>");
							
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
</body>
</html>