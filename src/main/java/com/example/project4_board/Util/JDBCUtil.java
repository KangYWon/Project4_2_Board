package com.example.project4_board.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    public static Connection getConnection(){
        Connection conn= null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try {
                conn = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/p232_22100016","p232_22100016","ahY2zi");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return conn;
    }
    /*public static void main(String ars[]) {
        Connection conn = getConnection();
        if(conn != null)
            System.out.println("DB 연결됨!");
        else
            System.out.println("DB 연결중 오류 !");
    }*/

}
