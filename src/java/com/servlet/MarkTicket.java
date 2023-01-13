// SERVLET FOR USER LOGIN
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class MarkTicket extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        String bid = request.getParameter("bid");
        System.out.println("Servlet Executed "+bid);
                

        ConnectDB c = new ConnectDB();
        PreparedStatement prt = null;
      
        String sql = "update booking set status=? where b_id=?";
  

        try {
           
            prt = c.conn.prepareStatement(sql);
            prt.setInt(1,2);
            prt.setString(2, bid);
          

            if(prt.executeUpdate() > 0){
                out.println(true);
            }else{
                out.println(false);
            }

       
        } catch (Exception exp) {

            out.println(exp.getMessage());

        } finally {

            try {
               
                prt.close();
                c.conn.close();
            } catch (Exception exp) {

            }

        }

    }

}
