/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Random;

public class BookTicket extends HttpServlet {

    //INSTANCE MEMBBERS
    private ConnectDB connect = null;
    private PreparedStatement prt = null;
    private String sql1 = "insert into booking values(?,?,?,?,?,?)";
    private String sql2 = "insert into ticket_detail values(?,?,?,?)";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        //FETCHING SESSION INFO
        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("UID");

        //GENERATING UNIQUE BOOKING ID
        Random rd = new Random();
        String bid = "B" + rd.nextInt(1000000000);

        //FETCHING FORM DATA
        String mid = request.getParameter("mid");
        String date = request.getParameter("date");
        int heads = Integer.parseInt(request.getParameter("count"));

        String nameArr[] = new String[heads];
        int ageArr[] = new int[heads];
        String genderArr[] = new String[heads];

        for (int i = 0; i < heads; i++) {
            int num = i + 1;

            nameArr[i] = request.getParameter("name" + num);
            ageArr[i] = Integer.parseInt(request.getParameter("age" + num));
            genderArr[i] = request.getParameter("gender" + num);
        }

        //ESTABLISHING CONNECTION   
        this.connect = new ConnectDB();

        try {

            this.prt = this.connect.conn.prepareStatement(sql1);
            prt.setString(1, bid);
            prt.setString(2, mid);
            prt.setString(3, uid);
            prt.setString(4, date);
            prt.setInt(5, heads);
            prt.setInt(6, 1);

            if (this.prt.executeUpdate() > 0) {

                this.prt = this.connect.conn.prepareStatement(sql2);

                for (int i = 0; i < heads; i++) {

                    this.prt.setString(1, bid);
                    this.prt.setString(2, nameArr[i]);
                    this.prt.setInt(3, ageArr[i]);
                    this.prt.setString(4, genderArr[i]);
                    
                    this.prt.executeUpdate();
                }
                
                out.println(true);

            } else {
                out.println("false");
            }

        } catch (Exception exp) {

            String msg = exp.getMessage();
            out.println(msg);

        } finally {

            try{
                this.prt.close();
                this.connect.conn.close();
            }catch(Exception e){
                
            }
        }

    }
}
