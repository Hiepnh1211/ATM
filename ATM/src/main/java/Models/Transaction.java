package Models;

import java.util.Date;

public class Transaction {
	private String transactionId;
	private String idNumber;
	private Date date;
	private String type;
	private double amount;
	private double balance;
	
	public Transaction() {
		
	}

	public Transaction(String transactionID ,String idNumber,Date date, double withdrawAmount, double balance, String type) {
		super();
		this.transactionId = transactionID;
		this.idNumber = idNumber;
		this.date = date;
		this.amount = withdrawAmount;
		this.balance = balance;
		this.type = type;
	}



	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	
	
}
