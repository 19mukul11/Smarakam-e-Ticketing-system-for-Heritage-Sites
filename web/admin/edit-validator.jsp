<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>


<%-- 
    Document   : EDit-user
    Created on : 2 Jun, 2022, 11:44:37 PM
    Author     : mukul
--%>

<%@page import="com.servlet.ConnectDB"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Validator | Smarakam Admin Panel</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
        <style>

            #edit-validator-form{
                display: flex;
                width: 80%;
                padding: 10px;
                margin: 20px auto;
                border: 1px solid grey;
            }
            
            #edit-validator-form input{
                width:90%;
                margin: 10px auto;
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


                <!--- MAIN PANEL -->
                <div class="col-10 " id="main-panel">
                    <div class="row">
                        <h3 class="text-center my-3">Update Validator Account</h3>

                        <div class="col" id="">


                            <%!
                                private ConnectDB connect;
                                private PreparedStatement prt;
                                private ResultSet rst;
                                private String sql = null;
                            %>

                            <%
                                String vid = request.getParameter("vid");
                                this.connect = new ConnectDB();
                                this.sql = "select *from validator where v_id=?";

                                try {

                                    this.prt = this.connect.conn.prepareStatement(this.sql);
                                    this.prt.setString(1, vid);

                                    this.rst = this.prt.executeQuery();

                                    if (this.rst.next()) {

                                        String name = this.rst.getString("v_name");
                                        String email = this.rst.getString("v_email");
                                       
                                       
                                        out.println("<form id='edit-validator-form'>"
                                                + "<span id='form-response' class='text-center p-1 mx-auto d-block mt-3 rounded'></span>"
                                                 + "<input type='text' placeholder='New User Name' class='ro d-none' name='vid' required value='"+vid+"' >"
                                                 + "<input type='text' placeholder='New User Name' class='ro' name='name' required value='"+name+"' >"
                                                + "<input type='email' placeholder='New Email ID' class='ro' name='email' required value='"+email+"'>"
                                               
                                                + "<input type='submit' value='Submit' id='edit-validator-btn' class='btn btn-primary w-75 mx-auto d-block'>"
                                                      + "</form>");
                                    } else {
                                        //redirection
                                    }

                                } catch (Exception e) {
                                    
                                    out.println(e.getMessage());
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


               $("#edit-validator-form").submit(function(e){
                   
                   e.preventDefault();
                   
                   $.ajax({
                       
                       url:"../EditValidator",
                       type: "post",
                       data : $("#edit-validator-form").serialize(),
                       success : function(result){
                           if(result){
        
                               $("#form-response").show().html("Validator Updated Successfully !").addClass("alert-success").removeClass("alert-danger");
                               $(location).attr("href","view-validators.jsp");
                            }else{
                               $("#form-response").show().html("Failed To Update! "+result).addClass("alert-danger").removeClass("alert-success");
                           }
                       }
                   });
                   
               });

            });

        </script>
    </body>
</html>
