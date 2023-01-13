<div id="header" class="row bg-light">

    <div class="col-sm-3 text-center">
        <img src="img/logo.png" alt="logo" id="logo">
    </div>
    <div class="col-sm-7">
        <h2 class="text-center vcenter" id="title">Welcome To Incredible India</h2>
    </div>
    <div class="col-sm-2 text-center">
        
        <%            
            if (session.getAttribute("UID") == null) {
                //SESSION NONT EXISTS
                out.println("<a href='login.jsp' class='btn btn-sm btn-primary d-block vcenter' id='login-btn'>Login</a>");
            } else {

                //SESSION EXISTS  
                out.println("<img src='img/profile-user.png' id='profile-icon' width='50' class='vcenter'>");
            }

        %>
        <ul id="user-info">
            <li><b>
                <% 
                    
                    String name = (String)session.getAttribute("NAME");
                    if(name != null){
                         out.print("Welcome "+name.substring(0, name.indexOf(" "))+" !");
                    }
                   
                %></b>
            </li>
            <li>
                <%
                    out.println("<a href='logout' class='btn btn-sm btn-danger d-block m-2' id='logout-btn'>Logout</a>");
                %>
            </li>
        </ul>

    </div>

</div>
<div id="navbar" class="row">
    <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="view-monuments.jsp">View Monuments</a></li>
        <li><a href="my-bookings.jsp">My Bookings</a></li>
    </ul>
</div>