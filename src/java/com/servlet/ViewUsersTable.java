/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class ViewUsersTable extends HttpServlet{
    
    //INSTANCE MEMBER VARIABLES
    private ConnectDB connect;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql;
    private String output;
    
  
    // constructor
    public ViewUsersTable(){
        
        this.connect = null;
        this.prt = null;
        this.rst = null;
        this.sql = "select *from user";
        this.output=null;
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        PrintWriter out = response.getWriter();
        
        this.connect = new ConnectDB();
        
        
        try{
            this.prt = connect.conn.prepareStatement(this.sql);
            this.rst = this.prt.executeQuery();
            
            this.output = "<table class='table table-bordered table-striped w-75 mx-auto text-center'>"
                    + "<thead>"
                    + "<th>User ID</th>"
                    + "<th>User Name</th>"
                    + "<th>Email</th>"
                    + "<th>Phone</th>"
                    + "<th>Action Buttons</th>"
                    + "</thead><tbody>";
            
            while(this.rst.next()){
                
                String uid = rst.getString("u_id");
                this.output += "<tr>"
                        + "<td>"+rst.getString("u_id")+"</td>"
                        + "<td>"+rst.getString("u_name")+"</td>"
                        + "<td>"+rst.getString("u_email")+"</td>"
                        + "<td>"+rst.getString("u_phone")+"</td>"
                        + "<td>"
                        + "<a href='user-account.jsp?uid="+uid+"' class='btn-sm btn-success mx-2'>View</a>"
                            + "<a href='edit-user.jsp?uid="+uid+"' class='btn-sm btn-warning mx-2'>Edit</a>"
                            + "<a href='' class='btn-sm btn-danger mx-2'>Delete</a>"
                        + "</td>"
                        + "</tr>";
            }
            
            out.println(this.output);
            
        }catch(Exception exp){
            
            String msg = exp.getMessage();
            out.println(msg);
            
        }finally{
            
            try{
                this.rst.close();
                this.prt.close();
                this.connect.conn.close();
                
            }catch(SQLException ex){
                
            }
        }
       
        
        
    }
    
}