/*
    SERVLET FOR LOGOUT DESTROYING SESSION
 */
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class Logout extends HttpServlet {

    //method to destroy session and logout user
    public void logout(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false); //return existing session object

        if (session != null) {

            String role = (String) session.getAttribute("ROLE");

            session.invalidate();
            //System.out.println("Session Destroyed");
            try {
                if (role != null) {
                    if (role.equals("ADMIN")) {
                        response.sendRedirect("admin/login.jsp");
                    } else if (role.equals("USER")) {
                        response.sendRedirect("index.jsp");
                    } else if (role.equals("VALIDATOR")) {
                        response.sendRedirect("validator/login.jsp");
                    } else {

                    }
                }

            } catch (IOException exp) {
                System.out.println("" + exp);
            }
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.logout(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.logout(request, response);
    }
}
