/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;

public class ViewMonumentsTable extends HttpServlet {

    //INSTANCE MEMBERS
    private ConnectDB connect;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql;
    private String output;

    //CONSTRUCTOR
    public ViewMonumentsTable() {

        this.prt = null;
        this.rst = null;
        this.sql = "select *from monument";
        this.output = null;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        this.connect = new ConnectDB();
        try {

            this.prt = connect.conn.prepareStatement(this.sql);

            this.rst = this.prt.executeQuery();

            this.output = "<table class='table table-bordered table-striped w-75 mx-auto text-center'>"
                    + "<thead>"
                    + "<th>Monument ID</th>"
                    + "<th>Monument Name</th>"
                    + "<th>Location</th>"
                    + "<th>Action Buttons</th>"
                    + "</thead><tbody>";

            while (rst.next()) {

                String mid = rst.getString("m_id");
                String name = rst.getString("m_name");
                String city = rst.getString("m_city");

                this.output += "<tr>"
                        + "<td>" + mid + "</td>"
                        + "<td>" + name + "</td>"
                        + "<td>" + city + "</td>"
                        + "<td>"
                        + "<a href='monument.jsp?mid="+mid+"' class='btn-sm btn-success mx-2'>View</a>"
                        + "<a href='edit-monument.jsp?mid="+mid+"' class='btn-sm btn-warning mx-2'>Edit</a>"
                        + "<a href='' class='btn-sm btn-danger mx-2'>Delete</a>"
                        + "</td>"
                        + "</tr>";

            }

            this.output += "</tbody></table>";
            out.print(output);

        } catch (Exception exp) {

            String msg = exp.getMessage();
            out.print("<h4 class='text-center'>" + msg + "</h4>");

        } finally {

            try {
                this.rst.close();
                this.prt.close();
                this.connect.conn.close();

            } catch (SQLException exp) {

            }
        }

    }

}
