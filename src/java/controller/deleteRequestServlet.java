/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.Date;
import java.util.List;

import model.*;

public class deleteRequestServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
         String status = request.getParameter("status");
         if(!status.equals("Completed")){
            RequestDAO r = new RequestDAO();
            r.delete(status);
            response.sendRedirect("studentRequest.jsp");
         }
         else{
             MaintenanceRequestsDAO m = new MaintenanceRequestsDAO();
             m.delete();
             response.sendRedirect("studentMaintenanceRequest.jsp");
         }
    }

}
