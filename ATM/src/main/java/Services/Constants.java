package Services;

public class Constants {
	public static final int ID_NUMBER_LENGTH = 8;
	public static final int ID_PIN_LENGTH = 4;
	public static final double MAXIMUM_TRANSACTION_AMOUNT = 25000;
	public static final int MAXIMUM_DEPOSIT_WITHDRAW_TIME = 5;
	public static final int MINIMUM_NAME_LENGTH = 4;
	public static final int MAXIMUM_NAME_LENGTH = 50;
	public static final int MAXIMUM_CONTACT_NUMBER_LENGTH = 10;
	public static final double INITIAL_BALANCE = 0;
	public static final String TRANSACTION_TYPE_DEPOSIT = "Deposit";
	public static final String ADMIN_ROLE = "Admin";
	public static final String USER_ROLE = "User";
	public static final String TRANSACTION_TYPE_WITHDRAW = "Withdraw";
	public static final int ID_NUMBER_LIMIT = 100000000;
	public static final int PIN_NUMBER_LIMIT = 10000;
	public static final String FUNCTION_DEPOSIT = "Deposit";
	public static final String FUNCTION_WITHDRAW = "Withdraw";
	public static final String FUNCTION_BALANCE_ENQUIRY = "Balance Enquiry";
	public static final String FUNCTION_CHANGE_PASSWORD= "Change Password";
	public static final String FUNCTION_TRANSFER_MONEY= "Transfer Money";
	public static final String FUNCTION_CREATE_USER = "Create User";
	public static final String FUNCTION_WITHDRAWAL_REPORT = "Withdrawal Report";
	public static final String FUNCTION_DEPOSIT_REPORT = "Deposit Report";
	public static final String FUNCTION_TRANSFER_REPORT = "Transfer Report";
	public static final String FUNCTION_ACCOUNT_REPORT = "Account Report";
	public static final String FUNCTION_EXIT = "Id Check";
	public static final String TEXT = "text";
	public static final String AMOUNT = "<input type=\"text\" step={0.01} name=\"amount\" ><br>\r\n";
	public static final String ID_TEXT = "<input type=\"number\" maxlength=\"8\" name=\"ID\"><br>\r\n";
	public static final String TABLE_STYLE = "<style>\r\n"
			+ "table {\r\n"
			+ "  font-family: arial, sans-serif;\r\n"
			+ "	 border-collapse: collapse;"
			+ "  width: 75%;\r\n"
			+ "}\r\n"
			+ "\r\n"
			+ "td, th {\r\n"
			+ "  border: 1px solid #dddddd;\r\n"
			+ "  text-align: left;\r\n"
			+ "  padding: 8px;\r\n"
			+ "}\r\n"
			+ "\r\n"
			+ "\r\n"
			+ "}\r\n"
			+ "</style>";
	public static final String DATE_PICKER = "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\r\n"
			+ "  <!-- Include jQuery UI -->\r\n"
			+ "  <link rel=\"stylesheet\" href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css\">\r\n"
			+ "  <script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js\"></script>\r\n"
			+ "  <script>\r\n"
			+ "    $(function() {\r\n"
			+ "      // Initialize datepicker\r\n"
			+ "      $(\"#datepicker\").datepicker();\r\n"
			+ "    });\r\n"
			+ "  </script>";
	public static final String DATE_PICKER_FORM = "<form action=\"WithdrawalReport\" method=\"post\">\r\n"
			+ "        <label for=\"datepicker\">Select Date:</label>\r\n"
			+ "        <input type=\"text\" id=\"datepicker\" name=\"date\">\r\n"
			+ "        <button type=\"submit\">Submit</button>\r\n"
			+ "    </form>";
}
