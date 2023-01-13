<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>


<%-- 
    Document   : user-account
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
        <title>User Account | Smarakam Admin Panel</title>
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
                            <h3 class='text-center my-4'>User Account</h3>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col">
                            <%
                                String uid = request.getParameter("uid");

                                this.sql = "select *from user where u_id=?";
                                this.connect = new ConnectDB();

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.prt.setString(1, uid);

                                    this.rst = this.prt.executeQuery();

                                    if (this.rst.next()) {

                                        String id = request.getParameter("uid");
                                        String uname = this.rst.getString("u_name");
                                        String email = this.rst.getString("u_email");
                                         String phone = this.rst.getString("u_phone");
                                      

                                        out.println("<table class='table table-bordered table-striped text-center w-75 mx-auto border-1 border-dark'>"
                                                 + "<tr>"
                                                + "<th>User ID : </th>"
                                                + "<td>" + uid + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>User Name : </th>"
                                                + "<td>" + uname + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>User Email : </th>"
                                                + "<td>" + email + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>User Phone : </th>"
                                                + "<td>" + phone + "</td>"
                                                + "</tr>"
                                                + "</table>");

                                    } else {
                                        //error for redirect
                                        
                                    }

                                } catch (Exception e) {

                                    System.out.println(e.getMessage());
                                } finally {
                                    
                                    try{
                                        this.rst.close();
                                        this.prt.close();
                                        this.connect.conn.close();
                                        
                                    }catch(Exception e){
                                        
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
