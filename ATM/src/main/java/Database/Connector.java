package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
    private static final String dbURL = "jdbc:mysql://localhost:3306/atm";
    private static final String dbUName = "root";
    private static final String dbPasswd = "";
    private static volatile Connection connection = null;

    public Connection getConnection() {
        if (connection == null) {
            try{
                connection = DriverManager.getConnection(dbURL,dbUName,dbPasswd);
                connection.setAutoCommit(true);
            }catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
