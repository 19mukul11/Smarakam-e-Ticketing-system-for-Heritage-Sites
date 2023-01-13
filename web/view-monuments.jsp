<!-- VIEW MONUMENTS  Page-->

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SMARAKAM | MONUMENTS |e-Ticketing System for Monuments & Heritage Sites</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            
            #main-container{
                margin-top: 30px;
                display: grid;
                grid-template-columns: 1fr 1fr 1fr 1fr;
                gap: 20px;
            }

            @media(max-width:991px){

                #main-container{
                    grid-template-columns: 1fr 1fr 1fr;
                    gap: 10px;
                }
                .grid-item img{
                    height: 150px;
                }
            }

            @media(max-width:767px){

                #main-container{
                    grid-template-columns: 1fr 1fr;
                    gap: 5px;
                }
                .grid-item img{
                    height: 120px;
                }
            }

            .grid-item:hover{
                box-shadow: 3px 3px 3px grey;
                background-color: rgb(198, 206, 215);
            }
            
            
        </style>
    </head>

    <body>
        <div id="outermost-container" class="container-fluid">

            <!-- Including Header-->
            <%@include file="include/header.jsp" %>

            
            <div class='row my-3'>
                <div class="col">
                    <form id="filter-sites-form" class="w-75 mx-auto p-3">
                        <select name="state-filter" id="" class="w-75 mx-auto" required>
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
                        <input type="submit" value="Apply Filter" class="btn btn-success w-75" />
                    </form>
                </div>
            </div>
            
            <!-- MAIN CONATINER -->
            <div class="container" id="main-container">
                
            </div>
            
            
            
            <!-- INCLUDING FOOTER -->
            <%@include file="include/footer.jsp" %>

        </div>
        <script src="js/jquery-3.6.0.js"></script>
        <script src="js/script.js">
        </script>

        <script>

            $(document).ready(function(){


                function loadMonuments(){

                    $.ajax({

                        
                        url : "viewMonumentsGrid",
                        type: "post",
                        success: function(result){

                            $("#main-container").html(result);
                        }

                    });

                }
                loadMonuments();


                $("#filter-sites-form").submit(function(e){

                    e.preventDefault();

                   $.ajax({
                       url : "monumentsByState",
                       type : "post",
                       data : $("#filter-sites-form").serialize(),
                       success: function(result){

                        $("#main-container").html(result);

                            if(result == ""){
                                $("#main-container").html("<h5 class='text-center alert-danger p-3 mx-auto'>No Results Found</h5>");
                            }
                       }
                   });
                });


            });

        </script>
    </body>

</html>