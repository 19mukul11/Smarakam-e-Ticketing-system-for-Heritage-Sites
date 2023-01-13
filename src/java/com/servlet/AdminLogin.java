/*
        SERVLET FOR ADMIN LOGIN
 */
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class AdminLogin extends HttpServlet{
    
    //Instance Memeber Variables
    private ConnectDB c;
    private String sql;
    private ResultSet rst;
    private PreparedStatement prt;
    
    
    public AdminLogin(){
        this.c=null;
        this.sql = null;
        this.rst = null;
        this.prt = null;
    }
    
    //IMPLEMENTED SERVICE METHOD
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        
        //creating db connection
        this.c = new ConnectDB();
        this.sql = "select *from admin where a_email=? and a_pwd=?";
        
        try{
           
            prt = this.c.conn.prepareStatement(this.sql);
            this.prt.setString(1, email);
            this.prt.setString(2, pwd);
            
            this.rst = prt.executeQuery();
            
            if(this.rst.next()){
                //CREDENTIALS MATCHED
                
                HttpSession session = request.getSession(true);
                session.setAttribute("A_UID", this.rst.getString("a_id"));
                session.setAttribute("A_NAME", this.rst.getString("a_name"));
                session.setAttribute("ROLE", "ADMIN");
                
                out.print("true");
                
            }else{
                out.print("false");
            }
            
        }catch(Exception exp){
            
            //HANDLING ERRORS AND EXCEPTIONS
            out.println(exp.getMessage());
            
        }finally{
            
            try{
                this.rst.close();
                this.prt.close();
                this.c.conn.close();
                
            }catch(SQLException exp){
                
            }
 
        }
      
        
        
    }
}
