
package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail extends HttpServlet{
    
    public void doGet() throws ServletException, IOException{
        
        System.out.println("Hello World");
        
        String msg = "This is my First Mail via JAVA";
        String subject = "Java Mail API";
        String to = "archacademy192@gmail.com";
        String from = "mukulmahajan2000@gmail.com";
        
        if(sendMail(msg, subject, to, from)){
            System.out.println("Mail Sent Successfully");
        }else{
            System.out.println("Mail Not Sent");
        }
        
    }
    
      public static boolean sendMail(String msg, String subject, String to, String from){
        
        //HOST FOR GMAIL
            String host = "smtp.gmail.com";
            
        //GET SYSTEM PROPERTIES
        Properties properties = System.getProperties();
      
        //SETTING IMP PROPERTIES
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable","true");
        properties.put("mail.smtp.auth","true");
        
        //STEP 1: GET SESSION OBJECT
       Session session =  Session.getInstance(properties,new Authenticator(){
            
            
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication("mukulmahajan2000@gmail.com","stackisusedindfs");
            }
            
        });
       
       //session.setDebug(true);
       
       //STEP 2 : COMPOSE MSG
       MimeMessage mail = new MimeMessage(session);
       
       
       try{
           mail.setFrom(new InternetAddress(from));
           
           mail.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
           
           mail.setSubject(subject);
           
           mail.setText(msg);
           
           
           //STEP 3: SEND
           Transport.send(mail);
           
           return true;
        
           
       }catch(Exception ex){
           
           ex.printStackTrace();
           return false;
       }   
  }

}