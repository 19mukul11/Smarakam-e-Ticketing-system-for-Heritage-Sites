<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>


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
        <title>View Validators | Smarakam Admin Panel</title>
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
                        <h3 class="text-center my-3">Validator Accounts</h3>

                        <div class="col" id="booking-table-box">

                            <%
                                this.sql = "select *from validator";
                                this.connect = new ConnectDB();

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.rst = this.prt.executeQuery();

                                    out.println("<table class='table table-bordered table-striped mx-auto text-center' style='width:90%'>"
                                            + "<thead>"
                                            + "<th>Validator ID</th>"
                                            + "<th>Validator Name</th>"
                                            + "<th>Email</th>"
                                            + "<th>Action Buttons</th>"
                                            + "</thead><tbody>");

                                    while (this.rst.next()) {

                    
                                        String vid = this.rst.getString("v_id");
                                        String vname = this.rst.getString("v_name");
                                        String email = this.rst.getString("v_email");
                                       
                                  

                                        out.println("<tr>"
                                                + "<td>" + vid + "</td>"
                                                + "<td>" + vname + "</td>"
                                                + "<td>" + email + "</td>"
                                                + "<td>"
                                                + "<a href='validator.jsp?vid="+vid+"' class='btn-sm btn-success mx-1'>View</a>"
                                                + "<a href='edit-validator.jsp?vid="+vid+"' class='btn-sm btn-warning mx-1'>Edit</a>"
                                                + "<a class='btn-sm btn-danger mx-1'>Delete</a>"
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
        </div>s

        <script src="../js/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>
        <script>

            $(document).ready(function () {



            });

        </script>
    </body>
</html>
