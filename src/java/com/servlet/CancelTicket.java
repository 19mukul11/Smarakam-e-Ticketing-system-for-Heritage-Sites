/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


/**
 *
 * @author ASUS
 */
public class CancelTicket extends HttpServlet {

   //INSTANCE MEMBER VARIABLES
    private ConnectDB connect;
    private PreparedStatement prt;
    private String sql;
    
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
     
        PrintWriter out = response.getWriter();
        
        String bid = request.getParameter("bid");
        this.sql = "update booking set status=0 where b_id=?";
        
        this.connect = new ConnectDB();
        
        try{
            this.prt = this.connect.conn.prepareStatement(this.sql);
            this.prt.setString(1, bid);
            
            if(this.prt.executeUpdate() > 0){
                out.println(true);
            }else{
                out.println(false);
            }
            
        }catch(Exception e){
            
        }finally{
            try{
                this.prt.close();
                this.connect.conn.close();
                
            }catch(Exception w){
                
            }
        }
        
        
       
        
        
    }
}
