<!-- REGISTER PAGE-->

<!-- -->

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>REGISTER | SMARAKAM | e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
            .error {

                color: red;
                display: none;
                font-size: 12px;

            }
        </style>
    </head>
    <body>
        <div id="outermost-container" class="container-fluid">

            <div class="row">
                <div class="col text-center py-4">
                    <img src="img/logo.png" alt="" width=200>
                </div>
            </div>
            <div class="row">
                <form id="register-form">

                    <h4 class="text-center mx-auto">Register Here</h4>

                    <span class="text-center my-1" id="form-response"></span>

                    <input type="text" placeholder="Name" name="name" id="name" required>
                    <span id="name-error" class="error">*Name should contain only Upper/Lowercase Alphabets or spaces</span>
                    <input type="email" placeholder="Email" name="email" id="email" required>
                    <span id="email-error" class="error">*Invalid email Format</span>
                    <input type="text" placeholder="Phone no." name="phone" id="phone" required>
                    <span id="phone-error" class="error">*Invalid Phone no. format</span>
                    <input type="password" placeholder="Password" name="pwd" id="pwd" required>
                    <span id="pwd-error" class="error">*Passwords Length Should be between 8-16 chars</span>

                    <input type="submit" class="btn-sm btn-primary" value="Submit" id="register-btn">

                    <a href="login.jsp" class="text-center text-danger">Already have an account, Login here</a>

                </form>
            </div>
        </div>
        <script src="js/jquery-3.6.0.js"></script>
        <script>

            $(document).ready(function () {

                //SUBMITTING REGISTER FORM
                $("#register-form").submit(function (e) {

                    e.preventDefault();
                    //$("#register-btn").attr("disabled", "disabled").val("Submitting....");

                    // FETCHING INPUT FIELDS FROM FORM FOR VALIDATION
                    var name = $("#name").val();
                    var email = $("#email").val();
                    var phone = $("#phone").val();
                    var pwd = $("#pwd").val();

                    var nameRegex = /^[a-zA-Z ]+$/;
                    var emailRegex = /^([a-zA-Z0-9\.-]+)@([a-zA-Z0-9]+)\.([a-z]{2,8})$/;
                    var phoneRegex = /^[789][0-9]{9}$/;
                    var pwdRegex = /^[0-9a-zA-Z@_#$%*.]{8,16}$/;

                    if (nameRegex.test(name) == false) {

                        $("#name-error").show();
                        $("#email-error").hide();
                        $("#phone-error").hide();
                        $("#pwd-error").hide();

                    } else if (emailRegex.test(email) == false) {

                        $("#email-error").show();
                        $("#name-error").hide();
                        $("#phone-error").hide();
                        $("#pwd-error").hide();

                    } else if (phoneRegex.test(phone) == false) {

                        $("#phone-error").show();
                        $("#email-error").hide();
                        $("#name-error").hide();
                        $("#pwd-error").hide();

                    } else if (pwdRegex.test(pwd) == false) {
                        $("#phone-error").hide();
                        $("#email-error").hide();
                        $("#name-error").hide();
                        $("#pwd-error").show();

                    } else {

                        $("#phone-error").hide();
                        $("#email-error").hide();
                        $("#name-error").hide();
                        $("#pwd-error").hide();

                        $.ajax({

                            url: "register",
                            type: "post",
                            data: $("#register-form").serialize(),
                            success: function (result) {

                                if (result.localeCompare("true") == 0) {

                                    $("#register-form").trigger("reset");
                                    $("#form-response").show().addClass("alert-success").removeClass("alert-danger").html("Registered Successfully");

                                } else {

                                    if (result.includes("email")) {
                                        $("#form-response").html("Email already registered");
                                    } else if ("phone") {
                                        $("#form-response").html("Phone no. already registered");
                                    } else {
                                        $("#form-response").html("Server Error, Please Try Again");
                                    }
                                    $("#form-response").show().addClass("alert-danger").removeClass("alert-success");
                                }

                                $("#register-btn").removeAttr("disabled").val("Submit");
                            }
                        });
                    }



                });

            });

        </script>
    </body>
</html>
