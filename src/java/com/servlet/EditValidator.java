
package com.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;




public class EditValidator extends HttpServlet {

    
    //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private String sql;
    private String output;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        //FETCHING FORM DATA
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String vid = request.getParameter("vid");
     

        //ESTABLISH CONNECTION
        this.c = new ConnectDB();

        this.sql = "update validator set v_name=?, v_email=? where v_id=?";

        try {

            prt = c.conn.prepareStatement(sql);

            prt.setString(1, name);
            prt.setString(2, email);
           prt.setString(3,vid);
           
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
