<%-- 
    Document   : index.jsp
    Created on : 9 Jun, 2022, 12:06:48 AM
    Author     : ASUS
--%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%

    if (session.getAttribute("VID") == null) {
        response.sendRedirect("login.jsp");
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VALIDATOR DASHBOARD | SMARAKAM |</title>
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/style.css">

        <style>

            #validate-form{
                width: 40%;
                margin: 10px auto;
                display: none;
                border: 1px solid grey;
            }


            #check-form{
                display: flex;
                width: 600px;
                margin: auto;
                padding: 15px;
                border: 1px solid grey;
                border-radius: 12px;
                margin-top: 100px;
            }

            #check-form input{

                margin: 10px auto;
                width: 95%;
            }

        </style>
    </head>
    <body>

        <div class="container-fluid" id="outermost-container">

            <div id="validator-header" class="row bg-light border border-bottom">
                <div class="col-3 text-center">
                    <img src="../img/logo.png" width="60%" alt="logo" id="admin-logo">
                </div>

                <div class="col-7">
                    <div id="admin-info">
                        <% out.print("Validator : " + session.getAttribute("VNAME"));%>
                    </div>
                    <h2 class="text-center vcenter"><b>VALIDATOR DASHBOARD</b></h2>
                </div>

                <div class="col-2 text-center ">
                    <a href="../logout" class="btn btn-warning vcenter">Logout</a>
                </div>
            </div>

            <div class='row'>
                <%

                    LocalDate d = LocalDate.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                    String date = d.format(formatter);
                    
                    out.println("<h4 class='text-start mt-3 mx-4'>"+date+"</h4>");

                %>
            </div>

            <div class="row">

                <form id="check-form">
                    <input type="text" placeholder="Enter Ticket ID" name="bid" required id='bid'>
                    <input type="submit" value='Check Details' class="btn btn-primary">
                </form>

            </div>

            <div class="row">

                <div class="col" id="ticket-detail">

                </div>

            </div>
            <div class='row'>
                <form id='validate-form'>
                    <input type='text' value='' name='bid' id='bid2' class='d-none'>
                    <input type='submit' value='Validate Now' class='btn btn-primary'>
                </form>
            </div>


        </div>
        <script src="../js/jquery-3.6.0.js"></script>
        <script>

            $(document).ready(function () {

                $("#check-form").submit(function (e) {

                    e.preventDefault();
                    // $("#login-btn").attr("disabled","disabled").val("Logging in....");

                    var id = $("#bid").val();

                    $.ajax({

                        url: "../ValidateTicket",
                        type: "post",
                        data: $("#check-form").serialize(),
                        success: function (result) {


                            if (result.localeCompare("false") == 0) {
                                $("#ticket-detail").html("<h2 class='text-center text-danger my-4'>BOOKING NOT FOUND</h2>");
                                $("#validate-form").hide();
                            } else {
                                $("#ticket-detail").html(result);
                                $("#validate-form").show();
                                $("#bid2").val(id);
                            }

                        }
                    });

                });


                $("#validate-form").submit(function (e) {

                    e.preventDefault();

                    $.ajax({

                        url: "../MarkTicket",
                        type: "post",
                        data: $("#validate-form").serialize(),
                        success: function (result) {

                            if (result) {
                                alert("VALID ENTRY");
                                location.reload();
                            } else {
                                alert("NOT UPDATED, TRY AGAIN " + result);
                            }
                        }
                    });
                });

            });

        </script>
    </body>
</html>
