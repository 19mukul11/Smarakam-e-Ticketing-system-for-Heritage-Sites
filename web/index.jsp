<!-- Index Page-->

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SMARAKAM | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">

    </head>

    <body>
        <div id="outermost-container" class="container-fluid">

            <!-- Including Header-->
            <%@include file="include/header.jsp" %>

            <!-- CAROUSEL OF DEMO IMAGES ON HOME PAGE -->
            <div class="row" id="home-carousel">
                <div class="col mx-0 px-0">
                    <img src="img/banner.jpg" alt="" width="100%">
                </div>
            </div>

            <!-- DISPLAY SOME MONUMENTS ON HOME PAGE -->
            <div class="container" id="main-content">
                <div class="row">
                    <h3 class="text-center my-2">Places to Visit</h3>
                </div>
                <div class="row my-2">

                    <!-- FETCHING 4 MONUMENTS FROM DATABASE  -->
                    <%@page import="com.servlet.ConnectDB" %>
                    <%@page import="java.sql.*" %>

                    <%!         private ConnectDB c = null;
                                private PreparedStatement prt = null;
                                private ResultSet rst = null;
                    %>

                    <% c = new ConnectDB();
                        String sql = "select *from monument order by m_id limit 6";
                        try {
                            prt = c.conn.prepareStatement(sql);
                            rst = prt.executeQuery();
                            while (rst.next()) {
                                String mid = rst.getString("m_id");
                                String mname = rst.getString("m_name");
                                String desc = rst.getString("m_description");
                                if(desc.length() > 100){
                                    desc = desc.substring(0,100);
                                }
                                String imgpath = "upload/"+ mid + "/" + mid;
                                
                                
                                
                                out.print("<div class='col-md-4'>"
                                        + "<div class='p-2 m-2 card monument-card'>"
                                        + "<img src='" + imgpath + "_0.jpg' width='95%' height='200'class='d-block mx-auto mt-2'>"
                                        + "<h4 class='text-center mt-3'>" + mname + "</h4>"
                                        + "<p class='mt-2' style='text-align:justify'>" + desc + "</p>"
                                        + "<a href='monument.jsp?id="+mid+"' class='btn btn-success '>Book Now</a>"
                                        + "</div>"
                                        + "</div>");

                            }

                        } catch (Exception exp) {

                            String msg
                                    = exp.getMessage();
                            out.println("<h3 class='text-danger'>" + msg + "</h1>");

                        } finally {

                            try {
                                System.out.println("Resources Freed");
                                this.prt.close();
                                this.c.conn.close();

                            } catch (Exception ex) {

                            }
                        }


                    %>
                </div>

            </div>
            <!-- INCLUDING FOOTER -->
            <%@include file="include/footer.jsp" %>

        </div>
        <script src="js/jquery-3.6.0.js"></script>
        <script src="js/script.js">
        </script>
    </body>

</html>