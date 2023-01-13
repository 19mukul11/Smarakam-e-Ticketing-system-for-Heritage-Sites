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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Monuments | Smarakam Admin Panel</title>
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
                   

                       <!--- MAIN PANEL -->
                    <div class="col-10 " id="main-panel">
                        <div class="row">
                            <h3 class="text-center my-3">Monuments</h3>
                            
                            <div class="col" id="monument-table-box">

                            </div>
                        </div>
                    </div>
                </div>
        </div>s

        <script src="../js/jquery-3.6.0.js"></script>
        <script src="../js/script.js"></script>
        <script>

                $(document).ready(function(){


                    function loadMonuments(){

                        $.ajax({

                            url : "../ViewMonumentsTable",
                            type:"post",
                            success: function(result){

                                $("#monument-table-box").html(result);
                            }

                        });
                    }

                    loadMonuments();

                });

        </script>
    </body>
</html>
