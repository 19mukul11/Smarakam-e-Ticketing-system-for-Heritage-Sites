//  CLASS FOR ESTABLISHING DATABASE CONNECTION

package com.servlet;

import java.sql.*;


public class ConnectDB {
    
    public Connection conn;
    
    private String url = "jdbc:mysql://localhost:3306/smarakamJava";
    private String username = "root";
    private String password = "";
    
    //CONSTRUCTOR
    public ConnectDB(){
        
        try{
            
            //LOADING 
            Class.forName("com.mysql.jdbc.Driver");
            
            //CREATING CONNECTION
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connection Established");
            
            
        }catch(Exception exp){
            System.out.println("Connection Failed "+exp);
        }
        
    }
    
    public static void main(String args[]){
        
        new ConnectDB();
    }
    
}
