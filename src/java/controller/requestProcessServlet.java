/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;

/**
 *
 * @author admin
 */
public class requestProcessServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String staffID = request.getParameter("staffID");
        String studentID = request.getParameter("studentID");
        String roomID = request.getParameter("roomID");
        String description = request.getParameter("description");
        String position = request.getParameter("position");
        String status = request.getParameter("status");
        String serviceID = request.getParameter("serviceID");
        RequestDAO r = new RequestDAO();
        Request x = new Request();
        x.setStudentID(studentID);
        x.setDescription(description);
        x.setPosition(position);
        x.setRoomID(roomID);
        x.setStatus(status);
        
        if(position.equals("Service")){
            x.setServiceID(serviceID);
            r.updateService(studentID, roomID, description, serviceID, x);
        }
        else{
            r.update(studentID, roomID, description, x);
        }
        
        Date currentDate = new Date(System.currentTimeMillis());
        
        if(status.equals("Accept")){
            if(position.equals("Assignment")){
                AssignmentsDAO a = new AssignmentsDAO();
                Assignments xx = new Assignments();
                xx.setAssignmentDate(currentDate);
                xx.setRoomID(roomID);
                xx.setStudentID(studentID);
                xx.setStaffID(staffID);
            
                a.insert(xx);
            }
            
            if(position.equals("Service")){
                ServiceUsageDAO s = new ServiceUsageDAO();
                ServiceUsage xx = new ServiceUsage();
                xx.setRoomID(roomID);
                xx.setServiceID(serviceID);
                xx.setStaffID(staffID);
                xx.setUsageDate(currentDate);
                
                s.insert(xx);
            }
            
            if(position.equals("Maintenance")){
                MaintenanceRequestsDAO m = new MaintenanceRequestsDAO();
                MaintenanceRequests xx = new MaintenanceRequests();
                xx.setRoomID(roomID);
                xx.setProblemDescription(description);
                xx.setStaffID(staffID);
                xx.setRequestDate(currentDate);
                
                m.insert(xx);
            }
        }
        
        response.sendRedirect("request.jsp");
        
    }
}
