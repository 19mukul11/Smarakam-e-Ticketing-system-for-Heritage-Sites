
<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>






<%@page import="java.sql.*"%>
<%@page import="com.servlet.ConnectDB"%>
<!-- ADMIN PANEL HOME  -->




<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOME | SMARAKAM ADMIN PANEL | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
    </head>

    <body>
        <div class="container-fluid" id="outermost-container">

            <%@include file="../include/admin-header.jsp" %>

                <div class="row" id="main-content">

                    <!--- INCLUDING SIDE PANEL -->
                    <%@include 
                        file="../include/side-panel.jsp"
                    %>
                   

                       <!--- MAIN PANEL -->
                    <div class="col-10 " id="main-panel">
                        <div id="home-panel">
                            
                            <div class="tile">
                                <span class="my-5 d-block">
                                    <%
                                    
                                        ConnectDB c = new ConnectDB();
                                        PreparedStatement prt=null;
                                        ResultSet rst=null;
                                        
                                        String sql = "select count(*) as bookings from booking";
                                        
                                        try{
                                            
                                            prt = c.conn.prepareStatement(sql);
                                            rst = prt.executeQuery();
                                            if(rst.next()){
                                                
                                                int sum = rst.getInt("bookings");
                                                out.println("Total Bookings : <br><b>"+sum+"</b>");
                                            }
                                            
                                            
                                        }catch(Exception e){
                                            out.print(e);
                                        }
                                        
                                    
                                    %>
                                </span>
                            </div>
                            <div class="tile">
                                <span class="my-5 d-block">
                                    <%
                                    
                                        
                                        
                                        sql = "select count(*) as users from user";
                                        
                                        try{
                                            
                                            prt = c.conn.prepareStatement(sql);
                                            rst = prt.executeQuery();
                                            if(rst.next()){
                                                
                                                int sum = rst.getInt("users");
                                                out.println("Registered Users : <br><b>"+sum+"</b>");
                                            }
                                            
                                            
                                        }catch(Exception e){
                                            out.print(e);
                                        }
                                        
                                    
                                    %>
                                </span>
                            </div>
                            <div class="tile">
                                <span class="my-5 d-block">
                                    <%
                                    
                                        sql = "select count(*) as monuments from monument";
                                        
                                        try{
                                            
                                            prt = c.conn.prepareStatement(sql);
                                            rst = prt.executeQuery();
                                            if(rst.next()){
                                                
                                                int sum = rst.getInt("monuments");
                                                out.println("Total Monuments : <br><b>"+sum+"</b>");
                                            }
                                            
                                            
                                        }catch(Exception e){
                                            out.print(e);
                                        }
                                        
                                    
                                    %>
                                </span>
                            </div>
                            <div class="tile">
                               <span class="my-5 d-block">
                                    <%
                                    sql = "select count(*) as validators from validator";
                                        
                                        try{
                                            
                                            prt = c.conn.prepareStatement(sql);
                                            rst = prt.executeQuery();
                                            if(rst.next()){
                                                
                                                int sum = rst.getInt("validators");
                                                out.println("Total Validators : <br><b>"+sum+"</b>");
                                            }
                                            
                                            
                                        }catch(Exception e){
                                            out.print(e);
                                        }
                                        
                                    
                                    %>
                                </span>
                            </div>
                                
                                <%
                                
                                    try{
                                        
                                    }finally{
                                        rst.close();
                                        prt.close();
                                        c.conn.close();
                                    }
                                %>
                        </div>
                    </div>
                </div>




        </div>



        <script src="../js/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>


    </body>

    </html>