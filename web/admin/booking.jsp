<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>



<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%-- 
    Document   : Booking
    Created on : 2 Jun, 2022, 11:44:37 PM
    Author     : mukul
--%>

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
        <title>Booking | Smarakam Admin Panel</title>
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

                    <div class='row'>
                        <div class='col'>
                            <h3 class='text-center my-4'>Booking Information</h3>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col">
                            <%
                                String bid = request.getParameter("bid");

                                this.sql = "select *from booking inner join monument on booking.m_id = monument.m_id inner join user on booking.u_id = user.u_id where b_id=?";
                                this.connect = new ConnectDB();

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.prt.setString(1, bid);

                                    this.rst = this.prt.executeQuery();

                                    if (this.rst.next()) {

                                        String uname = this.rst.getString("u_name");
                                        String uemail = this.rst.getString("u_email");
                                        String mname = this.rst.getString("m_name");
                                        String mcity = this.rst.getString("m_city");
                                        String mstate = this.rst.getString("m_state");
                                        int s = this.rst.getInt("status");
                                        String status="";
                                        if(s==1)
                                            status = "<label class='text-success'>Active</label>";
                                        else if(s==0)
                                            status  ="<label class='text-danger'>Cancelled</label>";
                                        else
                                            status = "<label class='text-warning'>Verified</label>";

                                        LocalDate d = LocalDate.parse(this.rst.getString("date"));
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                                        String date = d.format(formatter);

                                        String heads = this.rst.getString("no_of_heads");

                                        out.println("<table class='table table-striped table-bordered  w-75 mx-auto text-center'>"
                                                + "<tr>"
                                                + "<th>Visit Status: </th>"
                                                + "<th>" +  status+ "</th>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Booking ID : </th>"
                                                + "<td>" + bid + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>User Name : </th>"
                                                + "<td>" + uname + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>User Email : </th>"
                                                + "<td>" + uemail + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Monument : </th>"
                                                + "<td>" + mname + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Location : </th>"
                                                + "<td>" + mcity + ", " + mstate + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Date of Visit : </th>"
                                                + "<td>" + date + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>No. of Heads : </th>"
                                                + "<td>" + heads + "</td>"
                                                + "</tr>"
                                                + "</table>");
                                        
                                        this.sql = "select *from ticket_detail where b_id=?";
                                        this.prt = this.connect.conn.prepareStatement(this.sql);
                                        this.prt.setString(1, bid);
                                        
                                        this.rst = this.prt.executeQuery();
                                        
                                        
                                        out.println("<h4 class='text-center mt-5'>Visitors Details</h4>");
                                        
                                        out.println("<table class='table table-striped table-bordered w-75 mx-auto mt-1 text-center'><thead>"
                                                + "<th>Visitor Name</th>"
                                                + "<th>Age</th>"
                                                 + "<th>Gender</th>"
                                                + "</thead><tbody>");
                                        
                                        
                                        while(this.rst.next()){
                                            
                                            String name = this.rst.getString("visitor_name");
                                            int age = this.rst.getInt("age");
                                            String gender = this.rst.getString("gender");
                                            
                                            out.println("<tr>"
                                                    + "<td>"+name+"</td>"
                                                    + "<td>"+age+"</td>"
                                                    + "<td>"+gender+"</td>"
                                                    + "</tr>");
                                        }
                                        
                                        
                                        
                                                
                                    } else {
                                        //error for redirect

                                    }

                                } catch (Exception e) {

                                    System.out.println(e.getMessage());
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
        </div>s

        <script src="../js/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>
        <script>



        </script>
    </body>
</html>
