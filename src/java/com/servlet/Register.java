//  USER REGISTER SERVLET
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;

public class Register extends HttpServlet{
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        
        PrintWriter out = response.getWriter();
        
        
        //FETCHING REGISTER FORM DATA
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pwd = request.getParameter("pwd");
        
        //GENERATING UNIQUE USER ID
        Random rd = new Random();
        String uid = "U"+rd.nextInt(1000000000);
        
        ConnectDB c = new ConnectDB();
        
        //SQL QUERY
        String sql = "insert into user values(?,?,?,?,?)";
        PreparedStatement prt = null;
        
        try{
            //PREPARING STATEMENT
            prt = c.conn.prepareStatement(sql);
            
            prt.setString(1,uid);
            prt.setString(2,name);
            prt.setString(3,email);
            prt.setString(4,phone);
            prt.setString(5,pwd);
            
            prt.executeUpdate();
                
            prt.close();
            c.conn.close();
            out.print("true");
     
                
        }catch(Exception exp){     
           
            out.print(exp.getMessage().toString());
            
        }finally{
               try{
                   System.out.println("Finally block Executed");
                   prt.close();
                   c.conn.close();
               }catch(Exception e){
                   
               }
        }
       
    }
}
