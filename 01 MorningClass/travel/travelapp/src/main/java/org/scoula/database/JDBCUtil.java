package org.scoula.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.sql.SQLException;

public class JDBCUtil {
    static Connection conn = null;
    static{
        try{
            Properties proprites = new Properties();
            proprites.load(JDBCUtil.class.getResourceAsStream("/application.properties"));
            String driver = proprites.getProperty("driver");
            String url = proprites.getProperty("url");
            String id = proprites.getProperty("id");
            String password = proprites.getProperty("password");

            Class.forName(driver);
            conn = DriverManager.getConnection(url, id, password);

        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static Connection getConnection() {
        return conn;
    }
    public static void close() {
        try {
            if (conn != null) {
                conn.close();
                conn = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}