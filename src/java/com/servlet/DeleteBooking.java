package com.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteBooking extends HttpServlet {

    //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private String sql;
    private String output;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        //FETCHING FORM DATA
        String bid = request.getParameter("bid");

        //ESTABLISH CONNECTION
        this.c = new ConnectDB();

        this.sql = "delete from ticket_detail where b_id=?";

        try {

            prt = c.conn.prepareStatement(sql);

            prt.setString(1, bid);

            //EXECUTING QUERY
            if (prt.executeUpdate() > 0) {

                this.sql = "delete from booking where b_id=?";

                prt = c.conn.prepareStatement(this.sql);

                prt.setString(1, bid);
                
                if(prt.executeUpdate() > 0){
                    
                    response.sendRedirect("admin/view-bookings.jsp");
                }
            }

           

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
