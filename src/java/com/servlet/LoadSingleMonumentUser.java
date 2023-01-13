
package com.servlet;

import java.io.IOException;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;



public class LoadSingleMonumentUser extends HttpServlet {
    
    //INSTANCE MEMBER VARIABLES
    private ConnectDB connect;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql;
    private String output;
    
    //CONSTRUCTOR
    public LoadSingleMonumentUser(){
        
        this.connect = null;
        this.prt = null;
        this.rst = null;
        this.sql = "select *from monument where m_id=?";
        this.output = null;
        
    }
    

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        
        PrintWriter out = response.getWriter();

        String mid = request.getParameter("mid");
        
        System.out.println(mid);
        
    }

}
