package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "shop_db";
    private final String portNumber = "3306";
    private final String userID = "root";
    private final String password = "phuoc2006@"; // Thay mật khẩu DB tại đây

    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName + "?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, userID, password);
    }
}