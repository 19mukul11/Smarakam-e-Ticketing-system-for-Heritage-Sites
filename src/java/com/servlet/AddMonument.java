package com.servlet;

import java.io.*;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.*;
import java.util.*;

@MultipartConfig
public class AddMonument extends HttpServlet {

    private ConnectDB c;
    private PreparedStatement prt;
    private String sql;

    public AddMonument() {
        this.c = null;
        this.prt = null;
        this.sql = null;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        System.out.println("Servlet post executed");
        //FETCHING FORM DATA
        String monumentName = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String description = request.getParameter("description");
        int slots = Integer.parseInt(request.getParameter("slots"));
        String openingTime = request.getParameter("opening-time");
        String closingTime = request.getParameter("closing-time");

        //GENERATING MONUMENT ID
        Random rd = new Random();
        String mid = "M" + rd.nextInt(1000000000);

        //Part file = request.getPart("images");
        Collection<Part> file = new ArrayList<>(4);
        file = request.getParts();

        Iterator itr = file.iterator();
        int imgCount = 0;
        
        //CALCULTING TOTAL NUMBER OF IMAGES TO UPLOAD 
        while (itr.hasNext()) {
            Part pt = (Part) itr.next();
            if (pt.getName().equals("image")) {
                imgCount++;
            }
        }

        //ESTABLISH CONNECTION
        c = new ConnectDB();

        sql = "insert into monument values(?,?,?,?,?,?,?,?,?,?)";

        try {

            prt = c.conn.prepareStatement(sql);
            prt.setString(1, mid);
            prt.setString(2, monumentName);
            prt.setString(3, address);
            prt.setString(4, city);
            prt.setString(5, state);
            prt.setString(6, description);
            prt.setString(7, openingTime);
            prt.setString(8, closingTime);
            prt.setInt(9, slots);
            prt.setInt(10,imgCount);

            //EXECUTING QUERY
            prt.executeUpdate();
            
            
            //CODE FOR UPLOADING IMAGES TO SERVER
            
            itr = file.iterator();
            
            int i=0;
            
            while(itr.hasNext()){
                
                Part pt = (Part)itr.next();
                
                if(pt.getName().equals("image")){
                    
                    String filename = pt.getSubmittedFileName();
                    String path = request.getRealPath("upload")+File.separator+mid;
                    
                    //FOR CREATING DIRECTORY FOR INDIVIDUAL MONUMENTS
                    File f1 = new File(path);
                    f1.mkdir();
                    
                    //READING FILE DATA
                    InputStream fin = pt.getInputStream();
                    byte imgData[] = new byte[fin.available()];
                    fin.read(imgData);
                    
                    
                    //WRITING THE FILE DATA TO SERVER
                    FileOutputStream fout = new FileOutputStream(path+File.separator+mid+"_"+i+".jpg");
                    fout.write(imgData);
                    
                    
                    //CLOSING STREAMS   
                    fin.close();
                    fout.close();
                    
                    i++;
                    
                }
                
            }
            
            out.print("true");

        } catch (Exception exp) {

            String msg = exp.getMessage();
            if (msg.contains("Duplicate")) {
                out.print("Primary Key Error, Please try Again");
            } else {
                out.print("Internal Server Error, Please Try Again !! "+msg);
            }

        } finally {
            try {
                System.out.println("Resources Freed");
                this.prt.close();
                this.c.conn.close();

            } catch (Exception ex) {

            }
        }

//        while(itr.hasNext()){
//            
//            Part pt = (Part)itr.next();
//            
//            if(pt.getName().equals("image")){
//                
//                String filename = pt.getSubmittedFileName();
//                String path = request.getRealPath("upload")+File.separator+mid;
//                File f1 = new File(path);
//                f1.mkdir();
//                
//                FileOutputStream fout = new FileOutputStream(path+File.separator+"img_"+i+"_"+mid+".jpg");
//                InputStream in = pt.getInputStream();
//
//                //reading data
//                byte []data = new byte[in.available()];
//                in.read(data);
//                
//                fout.write(data);
//                in.close();
//                fout.close();
//                    i++;
//            }
//        
//        }
//
//        
//
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
