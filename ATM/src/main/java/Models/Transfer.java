package Models;

import java.util.Date;

public class Transfer extends Transaction{
	private String receiverID;
	private double receiverBalance;
	
	
	public Transfer() {
		
	}

	public Transfer(String transactionID, String idNumber, Date date, double withdrawAmount, double balance,
			String type, String receiverID, double receiverBalance) {
		super(transactionID, idNumber, date, withdrawAmount, balance, type);
		this.receiverID = receiverID;
		this.receiverBalance = receiverBalance;
		// TODO Auto-generated constructor stub
	}

	public String getReceiverID() {
		return receiverID;
	}

	public void setReceiverID(String receiverID) {
		this.receiverID = receiverID;
	}

	public double getReceiverBalance() {
		return receiverBalance;
	}

	public void setReceiverBalance(double receiverBalance) {
		this.receiverBalance = receiverBalance;
	}
	
}
