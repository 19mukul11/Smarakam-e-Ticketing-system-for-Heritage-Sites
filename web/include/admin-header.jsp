<div id="admin-header" class="row bg-light border border-bottom">
    <div class="col-3 text-center">
        <img src="../img/logo.png" width="60%" alt="logo" id="admin-logo">
    </div>

    <div class="col-7">
        <div id="admin-info">
            <% out.print("Admin : " + session.getAttribute("A_NAME"));%>
        </div>
        <h2 class="text-center vcenter"><b>SMARAKAM ADMIN PANEL</b></h2>
    </div>

    <div class="col-2 text-center ">
        <a href="../logout" class="btn btn-warning vcenter">Logout</a>
    </div>
</div>

