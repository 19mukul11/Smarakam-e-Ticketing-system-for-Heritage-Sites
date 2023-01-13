package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ViewMonumentsGrid extends HttpServlet {

    //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql;

    //CONSTRUCTOR
    public ViewMonumentsGrid() {
 
        this.prt = null;
        this.rst = null;
        this.sql = "select *from monument";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
         this.c = new ConnectDB();
        String output = "";

        try {

            this.prt = this.c.conn.prepareStatement(this.sql);

            this.rst = prt.executeQuery();

            while (rst.next()) {
                
                String mid = rst.getString("m_id");
                String mname = rst.getString("m_name");
                String desc = rst.getString("m_description");
                String imgpath = "upload/"+ mid + "/" + mid;
                
               
                output = output + "<a href='monument.jsp?id="+mid+"' class='card grid-item p-3'>"
                        + "<img src='" + imgpath + "_0.jpg' width='95%' height='150'class='d-block mx-auto mt-2'>"
                        + "<h6  class='text-center mt-3 text-dark btn btn-warning'>" + mname + "</h6>"
//                        + "<p class='text-justify mt-2'>" + desc + "</p>"
//                        + "<a href='#' class='btn-sm btn-warning '>Book Now</a>"
                        + "</a>";

            }
            
            out.print(output);

        } catch (Exception exp) {
            
            String msg = exp.getMessage();
            System.out.println(msg);
            out.print("<h4 class='text-center'>"+msg+"</h4>");

        } finally {
            try {

                rst.close();
                prt.close();
               // c.conn.close();

            } catch (Exception e) {

            }
        }

    }
}
