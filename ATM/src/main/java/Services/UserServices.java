package Services;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import Database.Connector;
import Models.Transaction;
import Models.Transfer;
import Models.User;

public class UserServices {
	Connector connector = new Connector();
	Utilities utils = new Utilities();
	
	public boolean checkPassword(String userId, String password) {
		try {
			String getUserPin = "SELECT pin FROM user_info WHERE id_number = ? AND pin = ?";
			PreparedStatement getPinStatement = connector.getConnection().prepareStatement(getUserPin);
			getPinStatement.setString(1, userId);
			getPinStatement.setString(2, password);
			ResultSet rs = getPinStatement.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(SQLException sqlError) {
			return false;
		}
		return false;
	}
	
	public Transaction deposit(User user, double amount) throws SQLException {
		int transactionCount = 0;
		List<Transaction> depositList = user.getTransactions();
		for(int i = 0; i < depositList.size(); i++) {
			if(depositList.get(i).getDate().equals(Date.valueOf(LocalDate.now())) && depositList.get(i).getType().equalsIgnoreCase("Deposit")){
				transactionCount++;
			}
		}
		
		if(amount > Constants.MAXIMUM_TRANSACTION_AMOUNT || transactionCount >= 5) {
			return null;
		}else {
			user.setBalance(user.getBalance() + amount);
			
			String balanceUpdate = "UPDATE user_info SET balance = ? WHERE id_number = ?";
			PreparedStatement balanceUpdateStatement = connector.getConnection().prepareStatement(balanceUpdate);
			balanceUpdateStatement.setDouble(1, user.getBalance());
			balanceUpdateStatement.setString(2, user.getIdNumber());
			
			String transactionId = utils.transactionIdGenerator(user.getIdNumber(),LocalDateTime.now().toString() , Constants.FUNCTION_DEPOSIT);
			Date transactionDate = Date.valueOf(LocalDate.now());
			
			Transaction transaction = new Transaction(transactionId, user.getIdNumber(), transactionDate, amount, user.getBalance(), Constants.TRANSACTION_TYPE_DEPOSIT);
			
			String depositMoney = "INSERT INTO transaction_info VALUES (?,?,?,?,?,?)";
			PreparedStatement depositStatement = connector.getConnection().prepareStatement(depositMoney);
			depositStatement.setString(1, transactionId);
			depositStatement.setInt(2, Integer.parseInt(user.getIdNumber()));
			depositStatement.setString(3, Constants.TRANSACTION_TYPE_DEPOSIT);
			depositStatement.setDate(4, Date.valueOf(LocalDate.now()));
			depositStatement.setDouble(5, amount);
			depositStatement.setDouble(6, user.getBalance());
			
			balanceUpdateStatement.execute();
			depositStatement.execute();
			return transaction;
		}
	}
	
	public Transaction withdraw(User user, double amount) throws SQLException {
		int transactionCount = 0;
		List<Transaction> depositList = user.getTransactions();
		for(int i = 0; i < depositList.size(); i++) {
			if(depositList.get(i).getDate().equals(Date.valueOf(LocalDate.now())) && depositList.get(i).getType().equalsIgnoreCase("Withdraw")){
				transactionCount++;
			}
		}
		
		if(amount > Constants.MAXIMUM_TRANSACTION_AMOUNT || transactionCount >= 5 || amount > user.getBalance()) {
			return null;
		}else {
			user.setBalance(user.getBalance() - amount);
			String balanceUpdate = "UPDATE user_info SET balance = ? WHERE id_number = ?";
			PreparedStatement balanceUpdateStatement = connector.getConnection().prepareStatement(balanceUpdate);
			balanceUpdateStatement.setDouble(1, user.getBalance());
			balanceUpdateStatement.setString(2, user.getIdNumber());
			
			String transactionId = utils.transactionIdGenerator(user.getIdNumber(),LocalDateTime.now().toString() , Constants.FUNCTION_WITHDRAW);
			Date transactionDate = Date.valueOf(LocalDate.now());
			
			Transaction transaction = new Transaction(transactionId, user.getIdNumber(), transactionDate, amount, user.getBalance(), Constants.TRANSACTION_TYPE_WITHDRAW);
			
			String withdrawMoney = "INSERT INTO transaction_info VALUES (?,?,?,?,?,?)";
			PreparedStatement withdrawStatement = connector.getConnection().prepareStatement(withdrawMoney);
			withdrawStatement .setString(1, transactionId);
			withdrawStatement .setInt(2, Integer.parseInt(user.getIdNumber()));
			withdrawStatement .setString(3, Constants.TRANSACTION_TYPE_WITHDRAW);
			withdrawStatement .setDate(4, Date.valueOf(LocalDate.now()));
			withdrawStatement .setDouble(5, amount);
			withdrawStatement .setDouble(6, user.getBalance());
			
			balanceUpdateStatement.execute();
			withdrawStatement .execute();
			return transaction;
		}
	}
	
	public Transfer trasferMoney(User sender, User receiver, double amount) throws SQLException {
		
		String BalanceUpdate = "UPDATE user_info SET balance = ? WHERE id_number = ? ";
		PreparedStatement BalanceUpdateStatement = connector.getConnection().prepareStatement(BalanceUpdate);
		String addTransaction = "INSERT INTO transaction_info VALUES(?,?,?,?,?,?)";
		PreparedStatement addTransactionStatement = connector.getConnection().prepareStatement(addTransaction);
		String addTransfer = "INSERT INTO transfer VALUES(?,?,?)";
		PreparedStatement addTransferStatement = connector.getConnection().prepareStatement(addTransfer);
		
		String transferId = utils.transactionIdGenerator(sender.getIdNumber(), LocalDateTime.now().toString(), Constants.FUNCTION_TRANSFER_MONEY);
		Date transactionDate = Date.valueOf(LocalDate.now());
		
			sender.setBalance(sender.getBalance() - amount);
			receiver.setBalance(receiver.getBalance() + amount);
			
			try {
				BalanceUpdateStatement.setDouble(1, sender.getBalance());
				BalanceUpdateStatement.setString(2, sender.getIdNumber());
				BalanceUpdateStatement.execute();
				
				BalanceUpdateStatement.setDouble(1, receiver.getBalance());
				BalanceUpdateStatement.setString(2, receiver.getIdNumber());
				BalanceUpdateStatement.execute();
				
				Transfer transaction = new Transfer(transferId, sender.getIdNumber(), transactionDate, amount, sender.getBalance(), Constants.FUNCTION_TRANSFER_MONEY,receiver.getIdNumber(),receiver.getBalance());
				
				addTransactionStatement.setString(1, transferId);
				addTransactionStatement.setString(2, sender.getIdNumber());
				addTransactionStatement.setString(3, Constants.FUNCTION_TRANSFER_MONEY);
				addTransactionStatement.setDate(4, Date.valueOf(LocalDate.now()));
				addTransactionStatement.setDouble(5, amount);
				addTransactionStatement.setDouble(6, sender.getBalance());
				
				addTransactionStatement.execute();
				
				addTransferStatement.setString(1, transferId);
				addTransferStatement.setString(2, receiver.getIdNumber());
				addTransferStatement.setDouble(3, receiver.getBalance());
				
				addTransferStatement.execute();
				
				return transaction;
				
			}catch (SQLException e) {
				return null;
			}
			
	}
	
	public boolean changePassword(User user, String oldPassword, String newPassword, String confirmNewPassword) throws SQLException {
		if(!newPassword.equals(confirmNewPassword) || !oldPassword.equals(user.getPin()) || oldPassword.equals("") || newPassword.equals("") || confirmNewPassword.equals("")) {
			return false;
		}else {
			user.setPin(newPassword);
			String passwordUpdate = "UPDATE user_info SET pin = ? where id_number = ?";
			PreparedStatement passwordUpdateStatement = connector.getConnection().prepareStatement(passwordUpdate);
			passwordUpdateStatement.setString(1, newPassword);
			passwordUpdateStatement.setString(2, user.getIdNumber());
			
			passwordUpdateStatement.execute();
			return true;
		}
		
	}
	
}
