<%-- Document : book-ticket.jsp Created on : 2 Jun, 2022, 10:25:13 PM Author : ASUS --%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate" %>
<%@page import="java.sql.*" %>
<%@page import="com.servlet.ConnectDB" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
  
    <%
        if(session.getAttribute("UID") == null){
            response.sendRedirect("login.jsp");
        }
    %>


<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Ticket | SMARAKAM |</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        <style>

            #img-book{
                width:70%;
                border-radius: 10px;
            }

            @media(max-width:500px){

                #img-book{
                    width: 90%;
                }
            }

            #booking-form {

                width: 750px;
                display: flex;
                flex-direction: column;
                margin: 30px auto;
                padding: 15px;
                border-radius: 8px;

            }

            #no-of-visitors-form {
                border: 1px solid grey;
                width: 750px;
                display: flex;
                flex-direction: column;
                margin: 30px auto;
                padding: 15px;
                border-radius: 8px;

            }

            @media(max-width:760px){

                #booking-form, #no-of-visitors-form{
                    width: 90%;
                }
            }

            #booking-form input,
            #booking-form select {
                margin: 10px auto;
                width: 90%;
            }

            #number-of-visitors,
            #monument-id,
            #date {
                display: none;
            }


        </style>
    </head>

    <body>
        <%!
            private ConnectDB connect;
            private PreparedStatement prt;
            private ResultSet rst;
            private String sql;

        %>
        <div class="container-fluid">

            <div class="row bg-primary py-3">
                <h3 class="text-center text-light">e-Ticketing Dashboard</h3>
              
            </div>

            <div class="row my-2">
                <div class='col'>
                    <div class="container">
                        <div class="row p-3">
                            <%                                String mid = request.getParameter("mid");
                                LocalDate d = LocalDate.parse(request.getParameter("date"));
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                                String date = d.format(formatter);

                                this.connect = new ConnectDB();
                                this.sql = "select *from monument where m_id=?";

                                try {

                                    this.prt = this.connect.conn.prepareStatement(sql);
                                    this.prt.setString(1, mid);

                                    this.rst = this.prt.executeQuery();

                                    if (this.rst.next()) {

                                        out.println("<div class='col-sm-6 card bg-light p-3'>"
                                                + "<img src='upload/" + mid + "/" + mid + "_0.jpg'  class='mx-auto' id='img-book'>"
                                                + "</div>"
                                                + "<div class='col-sm-6 card p-3 bg-light'>"
                                                + "<div class='vcenter'>"
                                                + "<h4 class='my-2'>" + this.rst.getString("m_name") + "</h4>"
                                                + "<p>" + this.rst.getString("m_address") + "</p>"
                                                + "<h6>" + this.rst.getString("m_city") + ", " + this.rst.getString("m_state") + "</h6>"
                                                + "<h6>Booking for Date : " + date + "</h6>"
                                                + "</div>"
                                                + "</div>");

                                    } else {
                                        //send redirect
                                    }

                                } catch (Exception e) {

                                    String msg = e.getMessage();
                                    out.println("<h3>" + msg + "</h3>");

                                } finally {
                                    try {
                                        this.rst.close();
                                        this.prt.close();
                                        this.connect.conn.close();

                                    } catch (Exception exp) {

                                    }
                                }


                            %>

                        </div>
                    </div>
                </div>
            </div>


            <div class='row'>

                <!-- number of visitors form -->
                <form id="no-of-visitors-form" class='bg-light'>
                    <label for="">Select No. of Visitors : </label>
                    <select name="" id="no-of-heads" class="w-50 d-block mx-2  my-4">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                    </select>
                    <input type="submit" class="btn btn-primary" value="Proceed">
                </form>


                <!-- Booking form . this will be visible after above form submit -->
                <form id="booking-form" class="bg-light">


                </form>




            </div>


        </div>
        <script src='js/jquery-3.6.0.js'></script>
        <script>

            $(document).ready(function () {

                $("#no-of-visitors-form").submit(function (e) {

                    e.preventDefault();

                    var count = $("#no-of-heads").val();

                    var mid = '<%= mid%>';
                    var date = '<%= d.toString()%>';

                    var output = "<input type='number' value='" + count + "' id='number-of-visitors' name='count'><input type='text' value='" + mid + "' id='monument-id' name='mid'><input type='text' value='" + date + "' id='date' name='date'>";

                    for (var i = 1; i <= count; i++) {

                        output = output + "<b class='text-center'>Visitor" + i + "</b><input type='text' name='name" + i + "' placeholder='Enter Name' required> <input type='number' name='age" + i + "' placeholder='Enter Age' required><select name='gender" + i + "' id='gender-box'><option value='M'>Male</option><option value='F'>Female</option></select> <br>";

                    }

                    output = output + "<input type='submit' value='Book Now' class='btn-primary'>";

                    $("#booking-form").html(output).css("border", "1px solid grey").show();


                });



                $("#booking-form").submit(function (e) {

                    e.preventDefault();

                    $.ajax({

                        url: "BookTicket",
                        type: "post",
                        data: $("#booking-form").serialize(),
                        success: function (result) {

                            if (result) {

                                $("#form-response").show().addClass("alert-success").removeClass("alert-danger").html("Booking Successfull ");
                                $(location).attr("href", "my-bookings.jsp"); //#redirection

                            } else {

                                $("#form-response").show().addClass("alert-danger").removeClass("alert-success").html("Booking Failed");

                            }
                            $("#add-validator-btn").removeAttr("disabled").val("Submit");
                        }

                    });


                });


            });
        </script>
    </body>

</html>