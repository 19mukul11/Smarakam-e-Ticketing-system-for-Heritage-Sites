<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.servlet.ConnectDB"%>
<%@page import="java.sql.*"%>


<!-- SINGLE MONUMENT  Page-->
<%
    String mid = request.getParameter("id");
%>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SMARAKAM | MONUMENT |e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        <style>


        </style>
    </head>

    <body>
        <div id="outermost-container" class="container-fluid">

            <!-- Including Header-->
            <%@include file="include/header.jsp" %>

            <!-- MAIN CONATINER -->
            <div class="container" id="main-container">

                <%!
                    //  instance members
                    private ConnectDB connect;
                    private PreparedStatement prt;
                    private ResultSet rst;
                    private String sql1 = "select *from monument where m_id=?";
                    private String sql2 = "select sum(no_of_heads) as booked from booking where m_id=? and date=? and status=1";

                %>

                <%                    this.connect = new ConnectDB();

                    String mname = null, address = null, city = null, state = null, description = null, o_time = null, c_time = null;
                    int img_count = 0, slots_per_day = 0;

                    try {

                        this.prt = this.connect.conn.prepareStatement(sql1);
                        this.prt.setString(1, mid);

                        this.rst = this.prt.executeQuery();

                        if (this.rst.next()) {

                            mname = this.rst.getString("m_name");
                            address = this.rst.getString("m_address");
                            city = this.rst.getString("m_city");
                            state = this.rst.getString("m_state");
                            description = this.rst.getString("m_description");
                            o_time = this.rst.getString("opening_time");
                            c_time = this.rst.getString("closing_time");
                            slots_per_day = this.rst.getInt("slots_per_day");
                            img_count = this.rst.getInt("img_count");

                        }

                    } catch (Exception exp) {

                        String msg = exp.getMessage();
                        out.println(msg);

                    } finally {

                        try {
                            this.rst.close();
                            this.prt.close();
                            this.connect.conn.close();
                        } catch (Exception ex) {

                        }
                    }


                %>

                <div class="row text-center pt-4">
                    <div class='col'>
                    <!-- image carousel -->
                    <%  
                        
                         out.println("<div id='myCarousel' class='carousel slide ' data-ride='carousel'>"
                                    +"<div class='carousel-inner'>");
                         
                          out.println("<div class='carousel-item active data-interval='1500'>"
                                    + "<img class='d-block w-75 mx-auto' src='upload/"+mid+"/"+mid+"_0.jpg' class='monument-img'>"
                                    +"</div>");


                        for(int i=1; i<img_count; i++){
                            
                            out.println("<div class='carousel-item data-interval='1500 '>"
                                        + "<img class='d-block w-75 mx-auto' src='upload/"+mid+"/"+mid+"_"+i+".jpg'  class='monument-img' >"
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
                             +"</div>");
                        
                        
                        
                        
                        
                        
                        
                        //out.println("<img src='upload/" + mid + "/" + mid + "_0.jpg' width='60%' >");
                    %>
                    </div>
                </div>

                <div class="row">
                    <h3 class='text-center my-3'><% out.println(mname+", "+city);  %></h3>
                </div>


                <!--    LOGIC FOR DATE BOXES -->
                <div class='row py-3'>
                    <%

                        LocalDate todayDate = LocalDate.now();

                        String userArr[] = new String[6];
                        LocalDate DbArr[] = new LocalDate[6];
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MMM-yyy");

                        //CREATING DATE ARRAYS
                        for (int i = 0; i < 6; i++) {

                            DbArr[i] = todayDate.plusDays(i + 1);
                            userArr[i] = DbArr[i].format(formatter);
                        }

                        //LOGIC FOR DIPLAYING DATE BOXES
                        for (int i = 0; i < 6; i++) {

                            int avlSlots = slots_per_day;
                            
                            this.connect = new ConnectDB();
                            
                            try {
                                this.prt = connect.conn.prepareStatement(this.sql2);
                                this.prt.setString(1,mid);
                                this.prt.setString(2,DbArr[i].toString());
                                
                                this.rst = this.prt.executeQuery();
                                this.rst.next();

                                int bookedSlots = this.rst.getInt("booked");
                                
                                if(bookedSlots != 0){
                                    avlSlots = slots_per_day - bookedSlots;
                                }
                                
                                if(avlSlots > 0){
                                    
                                    out.println("<div class='col-sm-2'>"
                                            + "<a href='book-ticket.jsp?mid="+mid+"&date="+DbArr[i]+"'>"
                                             + "<div class='slotBox green'>"
                                                    + "<div>"+userArr[i]+"</div>"
                                                    + "<div>AVL "+avlSlots+"</div>"
                                             + "</div>"
                                            + "</a>"
                                            + "</div>");
                                    
                                }else{
                                    out.println("<div class='col-sm-2'>"
                                            + "<a href='#'>"
                                             + "<div class='slotBox red'>"
                                                    + "<div>"+userArr[i]+"</div>"
                                                    + "<div>AVL 00</div>"
                                             + "</div>"
                                            + "</a>"
                                            + "</div>");
                                }
                                
                                
                            } catch (Exception exp) {
                                String msg = exp.getMessage();
                                out.println(msg);
                                
                            }finally{
                                try{
                                    this.rst.close();
                                    this.prt.close();
                                    this.connect.conn.close();
                                    
                                }catch(Exception e){
                                    
                                }
                            }

                        }

                    %>
                </div>

                <div class='row py-3'>

                    <table class='table table-bordered table-striped text-center w-75 mx-auto'>
                        <tr>
                            <th>Monument Name : </th>
                            <td><% out.print(mname); %></td>
                        </tr>
                        <tr>
                            <th>Local Address : </th>
                            <td><% out.println(address); %></td>
                        </tr>
                        <tr>
                            <th>City : </th>
                            <td><%  out.println(city); %></td>
                        </tr>
                        <tr>
                            <th>State : </th>
                            <td><% out.println(state); %></td>
                        </tr>
                        <tr>
                            <th>Opening Time : </th>
                            <td><% out.print(o_time); %></td>
                        </tr>
                        <tr>
                            <th>Closing Time : </th>
                            <td><% out.print(c_time); %></td>
                        </tr>
                    </table>
                </div>

                <div class='row my-3 mx-auto' style="width:'80%'; text-align: justify;">
                    <h5>About : </h5>
                    <p><% out.println(description);%></p>
                </div>

            </div>



            <!-- INCLUDING FOOTER -->
            <%@include file="include/footer.jsp" %>

        </div>
        <script src="js/jquery-3.6.0.js"></script>
         <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/script.js">
        </script>

        <script>

            $(document).ready(function () {




            });

        </script>
    </body>

</html>