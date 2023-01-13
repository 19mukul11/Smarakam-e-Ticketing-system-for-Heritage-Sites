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
        <title>Monument | Smarakam Admin Panel</title>
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
                        <div class="col">
                            <%
                                String mid = request.getParameter("mid");

                                this.sql = "select *from monument where m_id=?";
                                this.connect = new ConnectDB();

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.prt.setString(1, mid);

                                    this.rst = this.prt.executeQuery();

                                    if (this.rst.next()) {

                                        String mname = this.rst.getString("m_name");
                                        String address = this.rst.getString("m_address");
                                        String city = this.rst.getString("m_city");
                                        String state = this.rst.getString("m_state");
                                        String description = this.rst.getString("m_description");
                                        String o_time = this.rst.getString("opening_time");
                                        String c_time = this.rst.getString("closing_time");
                                        int slots_per_day = this.rst.getInt("slots_per_day");
                                        int img_count = this.rst.getInt("img_count");

                                       
                 
                     
                         out.println("<div class='row text-center pt-4'><div class='col'>");
                         out.println("<div id='myCarousel' class='carousel slide ' data-ride='carousel'>"
                                    +"<div class='carousel-inner'>");
                         
                          out.println("<div class='carousel-item active data-interval='1500'>"
                                    + "<img class='d-block w-75 mx-auto' src='../upload/"+mid+"/"+mid+"_0.jpg' class='monument-img'>"
                                    +"</div>");


                        for(int i=1; i<img_count; i++){
                            
                            out.println("<div class='carousel-item data-interval='1500 '>"
                                        + "<img class='d-block w-75 mx-auto' src='../upload/"+mid+"/"+mid+"_"+i+".jpg'  class='monument-img' >"
                                        +"</div>");
                            
                      
                        }
                        
                        out.println("</div>"
                                    +"<a class='carousel-control-prev' href='#myCarousel' role='button' data-slide='prev'>"
                                      +"  <span class='carousel-control-prev-icon' aria-hidden='true'></span>"
                                        +"<span class='sr-only text-dark'></span>"
                                    +"</a>"
                                    +"<a class='carousel-control-next' href='#myCarousel' role='button' data-slide='next'>"
                                      +"  <span class='carousel-control-next-icon' aria-hidden='true'></span>"
                                        +"<span class='sr-only text-dark'></span>"
                                    +"</a>"
                             +"</div></div></div>");
                                                      
               
                                        out.println("<h3 class='text-center my-4'>" + mname + "</h3>");

                                        out.println("<table class='table table-bordered table-striped text-center w-75 mx-auto border-1 border-dark'>"
                                                + "<tr>"
                                                + "<th>Monument Name : </th>"
                                                + "<td>" + mname + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Address : </th>"
                                                + "<td>" + address + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>City : </th>"
                                                + "<td>" + city + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>State : </th>"
                                                + "<td>" + state + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Opening Time : </th>"
                                                + "<td>" + o_time + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Closing Time : </th>"
                                                + "<td>" + c_time + "</td>"
                                                + "</tr>"
                                                + "<tr>"
                                                + "<th>Daily Capacity : </th>"
                                                + "<td>" + slots_per_day + "</td>"
                                                + "</tr>"
                                                + "</table>");

                                        out.println("<div class='row my-4 mx-auto' style='width:80%; text-align: justify;'>"
                                                + "<h5>Description : </h5><p>" + description + "</p>"
                                                + "</div>");
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
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="../js/script.js"></script>
        <script>



        </script>
    </body>
</html>
