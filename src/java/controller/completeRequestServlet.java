package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.Date;
import java.util.List;
import model.*;

/**
 *
 * @author admin
 */
public class completeRequestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String requestID = request.getParameter("requestID");
        Date currentDate = new Date(System.currentTimeMillis());
        MaintenanceRequestsDAO m = new MaintenanceRequestsDAO();
        m.update(currentDate, requestID);
        response.sendRedirect("maintenanceRequest.jsp");
    }
    
}
