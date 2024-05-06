package Models;

import java.util.List;

public class User {
	private String idNumber;
	private String pin;
	private String name;
	private String contactNumber;
	private String gender;
	private String address;
	private double balance;
	private String role;
	private List<Transaction> transactions;
	
	public User() {
		
	}

	public User(String idNumber, String pin, String name, String contactNumber, String gender,
			String address, double balance, List<Transaction> transaction, String role) {
		super();
		this.idNumber = idNumber;
		this.pin = pin;
		this.name = name;
		this.contactNumber = contactNumber;
		this.gender = gender;
		this.address = address;
		this.balance = balance;
		this.transactions = transaction;
		this.role = role;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public List<Transaction> getTransactions() {
		return transactions;
	}

	public void setTransactions(List<Transaction> transactions) {
		this.transactions = transactions;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}
