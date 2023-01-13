
package com.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;




public class EditUser extends HttpServlet {

    
    //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private String sql;
    private String output;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        //FETCHING FORM DATA
        String uname = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String uid = request.getParameter("uid");
     

        //ESTABLISH CONNECTION
        this.c = new ConnectDB();

        this.sql = "update user set u_name=?, u_email=?, u_phone=? where u_id=?";

        try {

            prt = c.conn.prepareStatement(sql);

            prt.setString(1, uname);
            prt.setString(2, email);
            prt.setString(3, phone);
            prt.setString(4, uid);
           
            //EXECUTING QUERY
            prt.executeUpdate();

            out.print(true);

        } catch (Exception exp) {

            String msg = exp.getMessage();
            out.println(msg);

        } finally {
            try {
                System.out.println("Resources Freed");
                this.prt.close();
                this.c.conn.close();

            } catch (Exception ex) {

            }
        }

    }


}
