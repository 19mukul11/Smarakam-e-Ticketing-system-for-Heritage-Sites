// SERVLET FOR USER LOGIN
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ValidatorLogin extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");

        ConnectDB c = new ConnectDB();
        PreparedStatement prt = null;
        ResultSet rst = null;
        String sql = "select *from validator where v_email=? and v_pwd=?";

        try {
            prt = c.conn.prepareStatement(sql);
            prt.setString(1, email);
            prt.setString(2, pwd);

            rst = prt.executeQuery();

            if (rst.next()) {
                
                //CREDENTIALS MATCHED
                HttpSession session = request.getSession(true);
                session.setAttribute("VID", rst.getString("v_id"));
                session.setAttribute("VNAME", rst.getString("v_name"));
                session.setAttribute("ROLE", "VALIDATOR");
                
                out.print("true");
                
            } else {
                out.print("false");
            }

        } catch (Exception exp) {
            
            out.println(exp.getMessage());

        } finally {
            
            try {
                rst.close();
                prt.close();
                c.conn.close();
            }catch(Exception exp){
                
            }

        }

    }

}
