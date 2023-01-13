/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 *
 * @author ASUS
 */
public class FilterBookings extends HttpServlet {

    //INSTANCE MEMBER VARIABLES
    private ConnectDB connect;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql = "";
    private String output = "";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        this.output = "";
        int status = Integer.parseInt((String) request.getParameter("filter-box"));
        
        if(status == 0){
             this.sql = "select *from booking inner join monument on booking.m_id = monument.m_id where u_id=? and status=? order by date";
        }else{
             this.sql = "select *from booking inner join monument on booking.m_id = monument.m_id where u_id=? and status=? order by date desc";
        }
       
       

        HttpSession session = request.getSession(false);
        String uid = (String) session.getAttribute("UID");

        boolean flag = false;

        this.connect = new ConnectDB();
        
        try {

            this.prt = this.connect.conn.prepareStatement(sql);
            this.prt.setString(1, uid);
            this.prt.setInt(2, status);

            this.rst = this.prt.executeQuery();

            if(status == 2){
                this.output += "<h6 class='text-success text-center my-3'>Completed Trips</h6>";
            }else{
                this.output += "<h6 class='text-success text-center my-3'>Cancelled Trips</h6>";
            }
          
  
            while (this.rst.next()) {
                
                String bid = this.rst.getString("b_id");
                String mname = this.rst.getString("m_name");
                String city = this.rst.getString("m_city");
                String date = this.rst.getString("date");
                String heads = this.rst.getString("no_of_heads");
                

                this.output += "<div class='row booking-box text-center my-2 rounded bg-light'>"
                                    + "<div class='col-sm-6'>"
                                            + "<div class='row '>"
                                            + "<div class='col text-danger'>ID : " + bid + "</div>"
                                            + "<div class='col '>" + mname + ", " + city + "</div>"
                                            + "</div>"
                                    + "</div>"
                                    + "<div class='col-sm-6'>"
                                            + "<div class='row'>"
                                            + "<div class='col'>" + date + "</div>";
                
                if(status == 2){
                    
                    this.output +=  "<div class='col'>Heads : " + heads + "&nbsp; &nbsp; <label class='text-success'>Completed<label></div>";
                }else{
                     this.output +=  "<div class='col'>Heads : " + heads + "&nbsp; &nbsp; <label class='text-danger'>CANCELLED<label></div>";
                }
                
                this.output += "</div>"
                                    + "</div>"
                        + "</div>";
                
                flag = true;
            }
            
            if(flag == true){
                out.println(this.output);
            }else{
                
                if(status == 2){
                    out.println("<h4 class='text-danger text-center'>No Previous Visits Found !</h4>");
                }else{
                    out.println("<h4 class='text-danger text-center'>No Cancelled Visits !</h4>");
                }
            }

        } catch (Exception e) {

            String msg = e.getMessage();
            out.println("Error : " + msg);
        } finally {

            try {
                this.rst.close();
                this.prt.close();
                this.connect.conn.close();

            } catch (Exception e) {

            }
        }
    }

}
