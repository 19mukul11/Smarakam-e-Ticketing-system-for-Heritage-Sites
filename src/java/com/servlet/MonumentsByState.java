
package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MonumentsByState extends HttpServlet {

     //INSTANCE MEMBERS
    private ConnectDB c;
    private PreparedStatement prt;
    private ResultSet rst;
    private String sql;

    //CONSTRUCTOR
    public MonumentsByState() {
        
        this.prt = null;
        this.rst = null;
        this.sql = null;
    }
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        String state = request.getParameter("state-filter");
         this.c = new ConnectDB();
         
        this.sql = "select *from monument where m_state=?";
        
        try{
            
            prt = c.conn.prepareStatement(sql);
            prt.setString(1,state);
            
            rst = prt.executeQuery();
            String output = "";
            
             while (rst.next()) {
                
                String mid = rst.getString("m_id");
                String mname = rst.getString("m_name");
                String desc = rst.getString("m_description");
                String imgpath = "upload/"+ mid + "/" + mid;
                
               
                output = output + "<a href='monument.jsp?id="+mid+"' class='card grid-item p-2'>"
                        + "<img src='" + imgpath + "_0.jpg' width='95%' height='200'class='d-block mx-auto mt-2'>"
                        + "<h6  class='text-center mt-3 text-dark'>" + mname + "</h6>"
                        + "</a>";

            }
            
            out.print(output);
            
             
        }catch(Exception exp){
            
            String msg = exp.getMessage();
            System.out.println(msg);
            out.print("<h4 class='text-center'>"+msg+"</h4>");
            
        }finally {
            try {

                rst.close();
                prt.close();
                //c.conn.close();

            } catch (Exception e) {

            }
        }
        
        
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
