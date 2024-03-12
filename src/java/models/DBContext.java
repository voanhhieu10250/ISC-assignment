/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author daing
 */
public class DBContext {
    // Khai báo method getConnection có thể gây ra SQLException
    public static Connection getConnection() throws SQLException{
        String url = "jdbc:sqlserver://localhost\\MSSQLSERVER01:51784;databaseName=PlantShop;user=sa;password=12345678;encrypt=false";
        Connection con = null;
        try {
            //Loading a driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //Creating a connection
            con = DriverManager.getConnection(url);
        } catch (Exception ex) {
            ex.printStackTrace();
            // Gây ra SQLException
            throw new SQLException(ex.getMessage());
        }
        return con;
    }
}