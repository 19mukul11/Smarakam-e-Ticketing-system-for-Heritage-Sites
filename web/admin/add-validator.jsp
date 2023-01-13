<!-- ADMIN PANEL ADD VALIDATOR  -->
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
        <title>ADD VALIDATOR | SMARAKAM ADMIN PANEL | e-Ticketing System for Monuments & Heritage Sites</title>
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

                    <h3 class="text-center my-5">ADD VALIDATOR</h3>
                   
                    
                    <form id="add-validator-form" method="post">

                        <span class="text-center my-1 d-block w-50 mx-auto  py-2" id="form-response"></span>
                        
                        <input type="text" placeholder="Enter Name" name='name' required>
                        <input type="email" placeholder="Enter Email" name='email' required>
                        <input type="text" placeholder="Create Password" name='pwd' required>
                        <input type="submit" value="Submit" class="btn btn-success" id="add-validator-btn">
    
                    </form>
                </div>

            </div>




        </div>

        <script src="../js/jquery-3.6.0.js"></script>
<!--        <script src="../js/script.js">  
        </script>-->
        <script>
            
              
            $(document).ready(function(){
                
                
                $("#add-validator-form").submit(function(e){
                    
                    e.preventDefault();
                    $("#add-validator-btn").attr("disabled","disabled").value("Submitting.....");
                    

                    $.ajax({
                        
                        url: "../AddValidator",
                        type: "post",
                        data : $("#add-validator-form").serialize(),
                        success : function(result){
                            
                            if(result == "true"){
                                
                                $("#form-response").show().addClass("alert-success").removeClass("alert-danger");
                                $("#add-validator-form").trigger("reset");
                                $("#form-response").html("Validator Added Successfully");
                            }else{
                                 $("#form-response").show().addClass("alert-danger").removeClass("alert-success").html(result);
                             }

                             $("#add-validator-btn").removeAttr("disabled").value("Submit");
                            
                        }
                    });
                });
            });
            
            
        </script>


    </body>

</html>