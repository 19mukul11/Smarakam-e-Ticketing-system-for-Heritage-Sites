<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>




<%-- 
    Document   : EDit-monuments
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
        <title>Edit Monuments | Smarakam Admin Panel</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
        <style>

            #edit-monument-form{
                display: flex;
                width: 80%;
                padding: 10px;
                margin: 20px auto;
                border: 1px solid grey;
            }
            
            #edit-monument-form input,  #edit-monument-form select,  #edit-monument-form textarea{
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
                        <h3 class="text-center my-3">Update Monuments</h3>

                        <div class="col" id="">


                            <%!
                                private ConnectDB connect;
                                private PreparedStatement prt;
                                private ResultSet rst;
                                private String sql = null;
                            %>

                            <%
                                String mid = request.getParameter("mid");
                                this.connect = new ConnectDB();
                                this.sql = "select *from monument where m_id=?";

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

                                        out.println("<form id='edit-monument-form'>"
                                                + "<span id='form-response' class='text-center p-1 mx-auto d-block mt-3 rounded'></span>"
                                                 + "<input type='text' placeholder='' class='ro d-none' name='mid' required value='"+mid+"' >"
                                                + "<input type='text' placeholder='NEW MONUMENT' class='ro' name='name' required value='"+mname+"'>"
                                                 + "<input type='text' placeholder='NEW ADDRESS' class='ro' name='address' required value='"+address+"'>"
                                                + "<input type='text' placeholder='NEW CITY' class='ro' name='city' required value='"+city+"'>"
                                                + " <select name='state' id='state' value='"+state+"'>"
                                                + "<option value=''>-- Select State --</option>"
                                                + "<option value='Andhra Pradesh'>Andhra Pradesh</option>"
                                                + "<option value='Arunachal Pradesh'>Arunachal Pradesh</option>"
                                                + "<option value='Assam'>Assam</option>"
                                                + "<option value='Bihar'>Bihar</option>"
                                                + "<option value='Chhattisgarh'>Chhattisgarh</option>"
                                                + "<option value='Goa'>Goa</option>"
                                                + "<option value='Gujarat'>Gujarat</option>"
                                                + " <option value='Haryana'>Haryana</option>"
                                                + "<option value='Himachal Pradesh'>Himachal Pradesh</option>"
                                                + "<option value='Jharkhand'>Jharkhand</option>"
                                                + "<option value='Karnataka'>Karnataka</option>"
                                                + "<option value='Kerala'>Kerala</option>"
                                                + "<option value='Madhya Pradesh'>Madhya Pradesh</option>"
                                                + "<option value='Maharashtra'>Maharashtra</option>"
                                                + "<option value='Manipur'>Manipur</option>"
                                                + "<option value='Meghalaya'>Meghalaya</option>"
                                                + "<option value='Mizoram'>Mizoram</option>"
                                                + "<option value='Nagaland'>Nagaland</option>"
                                                + "<option value='Orrisa'>Orrisa</option>"
                                                + "<option value='Punjab'>Punjab</option>"
                                                + "<option value='Rajasthan'>Rajasthan</option>"
                                                + "<option value='Sikkim'>Sikkim</option>"
                                                + "<option value='Tamil Nadu'>Tamil Nadu</option>"
                                                + "<option value='Telangana'>Telangana</option>"
                                                + "<option value='Tripura'>Tripura</option>"
                                                + "<option value='Uttar Pradesh'>Uttar Pradesh</option>"
                                                + "<option value='Uttarakhand'>Uttarakhand</option>"
                                                + "<option value='West Bengal'>West Bengal</option>"
                                                + "<option value='Delhi'>Delhi</option>"
                                                + "<option value='Chandigarh'>Chandigarh</option>"
                                                + "<option value=Daman & Diu'>Daman & Diu</option>"
                                                + "<option value='Dadar & Nagar Haveli'>Dadar & Nagar Haveli</option>"
                                                + "<option value='Lakshadweep'>Lakshadweep</option>"
                                                + "<option value='Andaman & Nicobar'>Andaman & Nicobar</option>"
                                                + "<option value='J & K'>Jammu & Kashmir</option>"
                                                + "<option value='Pondicherry'>Pondicherry</option>"
                                                + " </select>"
                                                + "<textarea rows=5 cols=50 wrap placeholder='NEW DESCRIPTION' class='ro' name='description' required >"+description+"</textarea>"
                                                + " <input type='number' placeholder='Enter Slots/Day' class='ro' name='slots' required value='"+slots_per_day+"'>"
                                                + " <div class='row' align='start'>"
                                                + "<div class='col-2'>Opening Time:</div>"
                                                + "<div class='col-10'><input type='time' placeholder='EDIT TIME' class='ro' name='opening-time' required value='"+o_time+"'></div>"
                                                + " </div>"
                                                + " <div class='row' align='start'>"
                                                + "<div class='col-2'>Closing Time:</div>"
                                                + "<div class='col-10'><input type='time' placeholder='EDIT TIME' class='ro' name='closing-time' required value='"+c_time+"'></div>"
                                                + " </div>"
                                                + "<input type='submit' value='Submit' id='monument-btn' class='btn btn-primary w-75 mx-auto d-block'>"
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


               $("#edit-monument-form").submit(function(e){
                   
                   e.preventDefault();
                   
                   $.ajax({
                       
                       url:"../EditMonument",
                       type: "post",
                       data : $("#edit-monument-form").serialize(),
                       success : function(result){
                           if(result){
        
                               $("#form-response").show().html("Monument Updated Successfully !").addClass("alert-success").removeClass("alert-danger");
                               $("#edit-monument-form").trigger("reset");
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
