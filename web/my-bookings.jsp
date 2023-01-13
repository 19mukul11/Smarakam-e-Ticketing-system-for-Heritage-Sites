<%-- 
    Document   : my-bookings.jsp
    Created on : 3 Jun, 2022, 12:29:41 AM
    Author     : ASUS
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>
<%@page import='com.servlet.ConnectDB' %>

<%

    if((String)session.getAttribute("UID") == null){
        response.sendRedirect("login.jsp");
    }

%>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Bookings | SMARAKAM | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">

    </head>

    <body>
        
        
        
        
        
        <div id="outermost-container" class="container-fluid">

            <!-- Including Header-->
            <%@include file="include/header.jsp" %>

            <div>
                <h3 class='text-center my-3'>My Bookings</h3>
            </div>

            <%!
                private ConnectDB connect;
                private PreparedStatement prt;
                private ResultSet rst;
                private String sql = "select *from booking inner join monument on booking.m_id = monument.m_id where u_id=? and status=1 order by date";
                private String sql2 = "select *from ticket_detail where b_id=?";

            %>

            <div class='row' id="filter-box">
                    <form id="filter-bookings-form" class="">
                        <select name='filter-box' required>
                             <option value="">-Select-</option>
                            <option value="2">Previous Visits</option>
                            <option value="0">Cancelled Visits</option>
                        </select>
                        <input type="submit" value="Apply Filter" class="btn-sm btn-success" />
                    </form>
                </div>

            <div class='container pb-5' id='main-container'>

                
                <%                    
                    
                    this.connect = new ConnectDB();
                    boolean flag = false;
                    
                    try {

                        this.prt = this.connect.conn.prepareStatement(this.sql);
                        this.prt.setString(1, (String) session.getAttribute("UID"));
                        this.rst = this.prt.executeQuery();

                        out.println("<h6 class='text-success text-center my-3'>Upcoming Trips</h6>");
                        while (this.rst.next()) {

                            String bid = this.rst.getString("b_id");
                            String mname = this.rst.getString("m_name");
                            String city = this.rst.getString("m_city");
                            int status = this.rst.getInt("status");
                            int heads = this.rst.getInt("no_of_heads");
                            LocalDate d = LocalDate.parse((String) this.rst.getString("date"));
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");
                            String date = d.format(formatter);

                            out.println("<div class='row bg-light text-center booking-box my-2 rounded'>"
                                    + "<div class='col-sm-6'>"
                                    + "<div class='row '>"
                                    + "<div class='col text-danger'>ID : " + bid + "</div>"
                                    + "<div class='col '>" + mname + ", " + city + "</div>"
                                    + "</div>"
                                    + "</div>"
                                    + "<div class='col-sm-6'>"
                                    + "<div class='row'>"
                                    + "<div class='col'>" + date + "</div>"
                                    + "<div class='col'>Heads : " + heads + "&nbsp; &nbsp;<button class='btn-sm btn-danger cancel-btn' data-bid="+bid+">Cancel</button></div>"
                                    + "</div>"
                                    + "</div>"
                                    + "</div>");
                            
                            flag = true;

                        }
                        
                        if(!flag){
                            out.println("<h4 class='text-center text-danger my-4'>No Upcoming Visits</h4>");
                        }


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

            <!-- INCLUDING FOOTER -->
            <%@include file="include/footer.jsp" %>

        </div>
        <script src="js/jquery-3.6.0.js"></script>
        <script src="js/script.js">
        </script>
        <script>
            
            $(document).ready(function(){
                
                
                $("#filter-bookings-form").submit(function(e){
                    
                    e.preventDefault();
                    
                    $.ajax({
                        url : "FilterBookings",
                        type: "post",
                        data : $("#filter-bookings-form").serialize(),
                        success : function(result){
                           
                            $("#main-container").html(result);
                        }
                              
                                
                    });
                });
                
                $(document).on("click",".cancel-btn",function(){
                    
                    var id = $(this).data("bid");
                    
                    if(confirm("Are you sure, you want to cancel this ticket ? ")){
                        
                        //AJAX CALL FOR CANCEL TICKET
                        $.ajax({
                            url : "CancelTicket",
                            type: "post",
                            data : { bid: id },
                            success : function(result){
                                
                                if(result){
                                    alert("Ticket Booking : "+id+" CANCELLED Successfully !");
                                    location.reload();
                                }else{
                                     alert("Failed to Cancel, try again !!");
                                }
                            }
                        });
                    }    
          
                    
                    
                });
                
                
                
                
            });
        </script>
    </body>

</html>