
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ValidateTicket extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PrintWriter out = response.getWriter();

        String bid = request.getParameter("bid");

        ConnectDB c = new ConnectDB();
        PreparedStatement prt = null;
        ResultSet rst = null;
        String sql = "select *from booking inner join monument on booking.m_id = monument.m_id inner join user on booking.u_id = user.u_id where b_id=? and status=? and date=?";
        String output = "";

        try {
            
             LocalDate todayDate = LocalDate.now();
             
            prt = c.conn.prepareStatement(sql);
            prt.setString(1, bid);
            prt.setInt(2, 1);
            prt.setString(3,todayDate.toString());

            rst = prt.executeQuery();

            if (rst.next()) {

                String mname = rst.getString("m_name");
                String uname = rst.getString("u_name");
                String city = rst.getString("m_city");
                String state = rst.getString("m_state");
                LocalDate d = LocalDate.parse((String) rst.getString("date"));
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                String date = d.format(formatter);

                output = "<h4 class='text-center my-5'>Ticket Information</h4>";
                output += "<table class='table table-bordered table-striped w-50 mx-auto text-center'>"
                        + "<tr>"
                        + "<th>Ticket ID : </th>"
                        + "<td>" + bid + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<th>Ticket Holder : </th>"
                        + "<td>" + uname + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<th>Monument : </th>"
                        + "<td>" + mname + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<th>Location : </th>"
                        + "<td>" + city + ", " + state + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<th>Date of Visit : </th>"
                        + "<td>" + date + "</td>"
                        + "</tr>"
                        + "</table>";

                sql = "select *from ticket_detail where b_id=?";
                prt = c.conn.prepareStatement(sql);
                prt.setString(1, bid);

                rst = prt.executeQuery();
                output += "<table class='table table-striped table-bordered  border-1 w-50 mx-auto mt-1 text-center'><thead class='bg-dark text-light'>"
                        + "<th>Visitor Name</th>"
                        + "<th>Age</th>"
                        + "<th>Gender</th>"
                        + "</thead><tbody>";
                while (rst.next()) {

                    String name = rst.getString("visitor_name");
                    int age = rst.getInt("age");
                    String gender = rst.getString("gender");

                    output += "<tr>"
                            + "<td>" + name + "</td>"
                            + "<td>" + age + "</td>"
                            + "<td>" + gender + "</td>"
                            + "</tr>";
                }

                output += "</tbody></table>";
                       

                out.println(output);

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
            } catch (Exception exp) {

            }

        }

    }

}
