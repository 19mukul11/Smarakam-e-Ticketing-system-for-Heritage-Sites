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

public class EditMonument extends HttpServlet {

    //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private String sql;
    private String output;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        //FETCHING FORM DATA
        String mid = request.getParameter("mid");
        String monumentName = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String description = request.getParameter("description");
        int slots = Integer.parseInt(request.getParameter("slots"));
        String openingTime = request.getParameter("opening-time");
        String closingTime = request.getParameter("closing-time");

        //ESTABLISH CONNECTION
        this.c = new ConnectDB();

        sql = "update monument set m_name=?,m_address=?,m_city=?,m_state=?,m_description=?, opening_time=?,closing_time=?,slots_per_day=? where m_id=?";

        try {

            prt = c.conn.prepareStatement(sql);

            prt.setString(1, monumentName);
            prt.setString(2, address);
            prt.setString(3, city);
            prt.setString(4, state);
            prt.setString(5, description);
            prt.setString(6, openingTime);
            prt.setString(7, closingTime);
            prt.setInt(8, slots);
            prt.setString(9, mid);

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
