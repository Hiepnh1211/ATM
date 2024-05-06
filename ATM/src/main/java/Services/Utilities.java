package Services;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Database.Connector;
import Models.Transaction;
import Models.User;

public class Utilities {
	Connector connector = new Connector();
	
	public boolean checkName(String name) {
		if(name.length() < Constants.MINIMUM_NAME_LENGTH || name.length() > Constants.MAXIMUM_NAME_LENGTH) {
			return false;
		}
		return true;
	}
	
	public boolean checkContactNumber(String contactNumber) {
		if(contactNumber.length() < Constants.MAXIMUM_CONTACT_NUMBER_LENGTH) {
			return false;
		}
		char[] number  = contactNumber.toCharArray();
		for(int i = 0; i < number.length; i++) {
			if(Character.isAlphabetic(number[i])) {
				return false;
			}
		}
		return true;
	}
	
	public boolean checkBalance(User user, double amount) {
		if(user.getBalance() > amount ) {
			return true;
		}
		return false;
	}
	
	public User getUserById(String id){
		String getById = "SELECT * FROM user_info WHERE id_number = ?";
		
		try {
			PreparedStatement getByIdStatement = connector.getConnection().prepareStatement(getById);
			getByIdStatement.setString(1,id);
			ResultSet resultSet = getByIdStatement.executeQuery();
			if(resultSet.next()) {
				User user = new User(
						resultSet.getString(1), 
						resultSet.getString(2), 
						resultSet.getString(3), 
						resultSet.getString(4), 
						resultSet.getString(5), 
						resultSet.getString(6), 
						resultSet.getDouble(7), 
						getTransactionRecord(id),
						resultSet.getString(8));
				return user;
			}	
		}catch(SQLException sqlError) {
			return null;
		}
		return null;
	}
	
	public List<Transaction> getTransactionRecord(String id){
		List<Transaction> transactionList = new ArrayList<Transaction>();
		
		String getTransactionList = "SELECT * FROM transaction_info WHERE id_number = ? ORDER BY transaction_date DESC";
		
		try {
			PreparedStatement getTransactionListStatement = connector.getConnection().prepareStatement(getTransactionList);
			getTransactionListStatement.setString(1, id);
			
			ResultSet resultSet = getTransactionListStatement.executeQuery();
			while (resultSet.next()) {
				transactionList.add(new Transaction(resultSet.getString(1), 
													resultSet.getString(2),
													resultSet.getDate(4), 
													resultSet.getDouble(5),
													resultSet.getDouble(6), 
													resultSet.getString(3)));
			}
			return transactionList;
		}catch(SQLException sqlError) {
			return null;
		}
	}
	
	public String textField(String type, String name) {
		String textField = "<input type=\""+type+"\" name=\""+name+"\" ><br>\r\n";
		return textField;
	}
	
	public String option(String function) {
		String servletName = function.replaceAll("\\s", "");
		String result = "<form action=\""+ servletName +".jsp\" method =\"post\">\r\n"
				+ "		<input type=\"submit\" value=\""+ function +"\">\r\n"
				+ "	</form>";
		return result;
	}
	
	public String padLeftZeros(String inputString, int length) {
	    if (inputString.length() >= length) {
	        return inputString;
	    }
	    StringBuilder sb = new StringBuilder();
	    while (sb.length() < length - inputString.length()) {
	        sb.append('0');
	    }
	    sb.append(inputString);

	    return sb.toString();
	}
	
	public String toMenu() {
		return"<form action=\"UserMenu.jsp\">\r\n"
				+ "		<input type=\"submit\" value=\"Back\">\r\n"
				+ "	</form>";
	}
	
	public String exit() {
		return"<form action=\"IdCheck.jsp\">\r\n"
				+ "		<input type=\"submit\" value=\"Exit\">\r\n"
				+ "	</form>";
	}
	
	public String toAdminMenu() {
		return"<form action=\"AdminMenu.jsp\">\r\n"
				+ "		<input type=\"submit\" value=\"Back\">\r\n"
				+ "	</form>";
	}
	
	public String submit(String label) {
		return "<input type=\"submit\" value=\""+label+"\">\r\n";
	}
	
	public String transactionIdGenerator(String idNumber, String date, String type) {
		String base = idNumber + date + type;
		try{
	        final MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        final byte[] hash = digest.digest(base.getBytes("UTF-8"));
	        final StringBuilder hexString = new StringBuilder();
	        for (int i = 0; i < hash.length; i++) {
	            final String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) 
	              hexString.append('0');
	            hexString.append(hex);
	        }
	        return hexString.toString();
	    } catch(Exception ex){
	       throw new RuntimeException(ex);
	    }

	}
}
