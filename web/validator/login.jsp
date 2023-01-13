<!-- VALIDATOR Login Page-->

<%

    if(session.getAttribute("VID") != null){
        response.sendRedirect("index.jsp");
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VALIDATOR LOGIN | SMARAKAM | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/style.css">

        <style>
           
        </style>
    </head>
    <body>
       <div id="outermost-container" class="container-fluid">

          <div class="row">
              <div class="col text-center py-4">
                
                <img src="../img/logo.png" alt="" width=200>
              </div>
          </div>
          <div class="row">

            <form id="login-form">
                <h4 class="text-center mx-auto">Validator Login</h4>
                <span class="text-center my-1" id="form-response">

                </span>
                <input type="email" placeholder="Email" name="email" required>
                <input type="password" placeholder="Password" name="pwd" required>
                <input type="submit" class="btn-sm btn-primary" value="Login" id="login-btn">
            </form>

          </div>
       </div>

       <script src="../js/jquery-3.6.0.js"></script>
       <script>

            $(document).ready(function(){

                //SUBMITTING LOGIN FORM
                $("#login-form").submit(function(e){
                    
                    e.preventDefault();
                    $("#login-btn").attr("disabled","disabled").val("Logging in....");


                    $.ajax({
                        
                        url : "../ValidatorLogin",
                        type:"post",
                        data : $("#login-form").serialize(),
                        success : function(result){
                            
                            if(result.localeCompare("true") == 0){
                                
                                $("#login-form").trigger("reset");
                                $("#form-response").show().addClass("alert-success").removeClass("alert-danger").html("Logged In Successfully");
                                $(location).attr("href", "index.jsp");

                            }else{
                                 $("#form-response").show().addClass("alert-danger").removeClass("alert-success").html("Invalid Credentials");
                            }
                            $("#login-btn").removeAttr("disabled").val("Login");
                        }
                    });
                    
                });

            });

       </script>
    </body>
</html>
