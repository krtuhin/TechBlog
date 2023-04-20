package com.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {

        try {
            if (con == null) {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1524:orcl2", "scott", "system");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
