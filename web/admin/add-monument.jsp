<!-- ADMIN PANEL HOME  -->
<%

    if(session.getAttribute("A_UID") == null){
        response.sendRedirect("login.jsp");
    }
%>



<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADD MONUMENT | SMARAKAM ADMIN PANEL | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
    </head>

    <body>
        <div class="container-fluid" id="outermost-container">

            <%@include file="../include/admin-header.jsp" %>

            <div class="row" id="main-content">

                <!--- INCLUDING SIDE PANEL -->
                <%@include file="../include/side-panel.jsp" %>


                <!--- MAIN PANEL -->
                <div class="col-10 " id="main-panel">

                    <h3 class="text-center my-5">ADD MONUMENT</h3>
                   
                    
                    <form id="add-monument-form" method="post" enctype="multipart/form-data">

                         <span class="text-center my-1 d-block w-50 mx-auto  py-2" id="form-response"></span>
                         
                        <input type="text" placeholder="Monument name" id="name" name="name">
                        <input type="text" placeholder="Loacal Address"  name="address"  >
                        <input type="text" placeholder="Enter City" id="city" name="city" >

                        <select name="state" id="state">
                            <option value="">-- Select State --</option>
                            <option value="Andhra Pradesh">Andhra Pradesh</option>
                            <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                            <option value="Assam">Assam</option>
                            <option value="Bihar">Bihar</option>
                            <option value="Chhattisgarh">Chhattisgarh</option>
                            <option value="Goa">Goa</option>
                            <option value="Gujarat">Gujarat</option>
                            <option value="Haryana">Haryana</option>
                            <option value="Himachal Pradesh">Himachal Pradesh</option>
                            <option value="Jharkhand">Jharkhand</option>
                            <option value="Karnataka">Karnataka</option>
                            <option value="Kerala">Kerala</option>
                            <option value="Madhya Pradesh">Madhya Pradesh</option>
                            <option value="Maharashtra">Maharashtra</option>
                            <option value="Manipur">Manipur</option>
                            <option value="Meghalaya">Meghalaya</option>
                            <option value="Mizoram">Mizoram</option>
                            <option value="Nagaland">Nagaland</option>
                            <option value="Orrisa">Orrisa</option>
                            <option value="Punjab">Punjab</option>
                            <option value="Rajasthan">Rajasthan</option>
                            <option value="Sikkim">Sikkim</option>
                            <option value="Tamil Nadu">Tamil Nadu</option>
                            <option value="Telangana">Telangana</option>
                            <option value="Tripura">Tripura</option>
                            <option value="Uttar Pradesh">Uttar Pradesh</option>
                            <option value="Uttarakhand">Uttarakhand</option>
                            <option value="West Bengal">West Bengal</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Chandigarh">Chandigarh</option>
                            <option value="Daman & Diu">Daman & Diu</option>
                            <option value="Dadar & Nagar Haveli">Dadar & Nagar Haveli</option>
                            <option value="Lakshadweep">Lakshadweep</option>
                            <option value="Andaman & Nicobar">Andaman & Nicobar</option>
                            <option value="J & K">Jammu & Kashmir</option>
                            <option value="Pondicherry">Pondicherry</option>
                        </select>

                        <textarea class='my-3' name="description" id="description" cols="100" rows="10" placeholder="Enter Brief Description"  ></textarea>
                        <input type="number" placeholder="Enter Max. Slots per Day" id="slots" name="slots" >
                        <input type="time" placeholder="Select Opening Time" id="opening-time" name="opening-time"  >
                        <input type="time" placeholder="Select Closing Time" id="closing-time" name="closing-time"  >

                        <label >
                            <b> Upload Images</b>
                        </label><input type="file"  name="image" id="" placeholder="Upload Images"  accept='image/*' multiple>

                        <input type="submit" value="Submit" class="btn-lg btn-primary w-50" id="submit-monument-form-btn">
                    </form>
                </div>

            </div>




        </div>

        <script src="../js/jquery-3.6.0.js"></script>
<!--        <script src="../js/script.js">  
        </script>-->
        <script>
            
              
            $(document).ready(function(){
                
                
                $("#add-monument-form").submit(function(e){
                    
                    e.preventDefault();
                    
                    //SINCE OUR FORM CONTAINS INPUT FILE ALOS, THATS WHY
                    var formData = new FormData(this);

                    $.ajax({
                        
                        url: "../addMonument",
                        type: "post",
                        data : formData,
                        processData: false,
                        contentType : false,
                        success : function(result){
                            
                            if(result == "true"){
                                
                                $("#form-response").show().addClass("alert-success").removeClass("alert-danger");
                                $("#add-monument-form").trigger("reset");
                                $("#form-response").html("Monument Added Successfully");
                            }else{
                                 $("#form-response").show().addClass("alert-danger").removeClass("alert-success").html(result);
                             }
                            
                        }
                    });
                });
            });
            
            
        </script>


    </body>

</html>