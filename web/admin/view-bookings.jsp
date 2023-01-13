<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>

<%-- 
    Document   : view-monuments
    Created on : 2 Jun, 2022, 11:44:37 PM
    Author     : mukul
--%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="com.servlet.ConnectDB" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Bookings | SMARAKAM ADMIN PANEL</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
        <style>

            a{
                text-decoration: none;
            }

        </style>
    </head>
    <body>
        <div class="container-fluid" id="outermost-container">

            <%@include file="../include/admin-header.jsp" %>

            <div class="row" id="main-content">

                <!--- INCLUDING SIDE PANEL -->
                <%@include 
                    file="../include/side-panel.jsp"
                    %>


                <%!
                    private ConnectDB connect;
                    private PreparedStatement prt;
                    private ResultSet rst;
                    private String sql = null;

                %>

                <!--- MAIN PANEL -->
                <div class="col-10 " id="main-panel">
                    <div class="row">
                        <h3 class="text-center my-3">Bookings</h3>

                        <div class="col" id="booking-table-box">

                            <%
                                this.sql = "select *from booking inner join monument on booking.m_id = monument.m_id inner join user on booking.u_id = user.u_id order by date desc";
                                this.connect = new ConnectDB();

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.rst = this.prt.executeQuery();

                                    out.println("<table class='table table-bordered table-striped mx-auto text-center' style='width:90%'>"
                                            + "<thead>"
                                            + "<th>Booking ID</th>"
                                            + "<th>User Name</th>"
                                            + "<th>Monument Name</th>"
                                            + "<th>Date</th>"
                                            + "<th>Status</th>"
                                            + "<th>Action Buttons</th>"
                                            + "</thead><tbody>");

                                    while (this.rst.next()) {

                                        String bid = this.rst.getString("b_id");
                                        String uname = this.rst.getString("u_name");
                                        String mname = this.rst.getString("m_name");
                               String city = this.rst.getString("m_city");
                                        LocalDate d = LocalDate.parse((String) this.rst.getString("date"));
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                                        String date = d.format(formatter);
                                        
                                        int s = this.rst.getInt("status");
                                        String status = "";
                                         if(s==1)
                                            status = "<label class='text-success'>Active</label>";
                                        else if(s==0)
                                            status  ="<label class='text-danger'>Cancelled</label>";
                                        else
                                            status = "<label class='text-warning'>Verified</label>";

                                        out.println("<tr>"
                                                + "<td>" + bid + "</td>"
                                                + "<td>" + uname + "</td>"
                                                + "<td>" + mname +", "+city+ "</td>"
                                                + "<td>" + date + "</td>"
                                                           + "<th>" + status + "</th>"
                                                + "<td>"
                                                        + "<a href='booking.jsp?bid="+bid+"' class='btn-sm btn-success mx-1'>View</a>"
                                                        + "<a class='btn-sm btn-warning mx-1'>Edit</a>"
                                                        + "<a href='../DeleteBooking?bid="+bid+"' class='btn-sm btn-danger mx-1'>Delete</a>"
                                                        + "</td>"
                                                + "</tr>");
                                    }

                                    out.println("</tbody></table>");

                                } catch (Exception e) {
                                    String msg = e.getMessage();
                                    out.println(msg);
                                } finally {

                                    try {
                                        this.rst.close();
                                        this.prt.close();
                                        this.connect.conn.close();

                                    } catch (Exception e) {

                                    }
                                }


                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="../js/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>
        <script>

            $(document).ready(function () {


                function loadMonuments() {

                    $.ajax({

                        url: "../ViewMonumentsTable",
                        type: "post",
                        success: function (result) {

                            $("#monument-table-box").html(result);
                        }

                    });
                }

                loadMonuments();

            });

        </script>
    </body>
</html>
