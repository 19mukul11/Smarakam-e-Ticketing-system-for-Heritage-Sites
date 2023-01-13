/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Random;

/**
 *
 * @author ASUS
 */
public class AddValidator extends HttpServlet {

    private ConnectDB connect;
    private PreparedStatement prt;
    private String sql;

    public AddValidator() {

        this.connect = null;
        this.prt = null;
        this.sql = "insert into validator values(?,?,?,?)";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        this.connect = new ConnectDB();

        try {

            this.prt = this.connect.conn.prepareStatement(this.sql);

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pwd = request.getParameter("pwd");

            //GENERATING UNIQUE USER ID
            Random rd = new Random();
            String vid = "V" + rd.nextInt(1000000000);

            this.prt.setString(1,vid);
            this.prt.setString(2,name);
            this.prt.setString(3,email);
            this.prt.setString(4,pwd);
            
            this.prt.executeUpdate();
            out.print("true");

        } catch (Exception ep) {

            String msg = ep.getMessage();
            out.print(msg);
            
        } finally {
            try{
                this.prt.close();
                this.connect.conn.close();
                
            }catch(Exception exp){
                
            }
                  
        }
    }
}
