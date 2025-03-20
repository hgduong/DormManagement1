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


public class serviceRegistrationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession studentSession = request.getSession(false);
        
        if (studentSession == null || studentSession.getAttribute("student") == null) {
            request.setAttribute("errorMessage", "Session expired. Please log in again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        Students student = (Students) studentSession.getAttribute("student");
        String studentID = student.getStudentID();
        String roomID = request.getParameter("roomID");
        String serviceID = request.getParameter("serviceID");
        
        ServiceUsageDAO serviceUsageDAO = new ServiceUsageDAO();
        AssignmentsDAO assignmentsDAO = new AssignmentsDAO();
        ServicesDAO servicesDAO = new ServicesDAO();
        RoomsDAO roomsDAO = new RoomsDAO();
        RequestDAO requestDAO = new RequestDAO();

        if (!isStudentAssignedToRoom(studentID, roomID, assignmentsDAO)) {
            request.setAttribute("errorMessage", "You are not in this room.");
            request.getRequestDispatcher("serviceRegistration.jsp").forward(request, response);
            return;
        }

        if (!isServiceValid(serviceID, servicesDAO)) {
            request.setAttribute("errorMessage", "Invalid service.");
            request.getRequestDispatcher("serviceRegistration.jsp").forward(request, response);
            return;
        }

        if (isServiceAlreadyRegistered(roomID, serviceID, serviceUsageDAO)) {
            request.setAttribute("errorMessage", "You have already registered for this service.");
            request.getRequestDispatcher("serviceRegistration.jsp").forward(request, response);
            return;
        }

        Rooms room = roomsDAO.getRooms(roomID);
        Request newRequest = new Request();
        newRequest.setRoomID(roomID);
        newRequest.setStudentID(studentID);
        newRequest.setDescription("Service Registration");
        newRequest.setPosition("Service");
        newRequest.setBuildingID(room.getBuildingID());
        newRequest.setServiceID(serviceID);

        requestDAO.insertService(newRequest);

        request.setAttribute("successfulMessage", "Successfully registered service " + serviceID + ".");
        request.getRequestDispatcher("serviceRegistration.jsp").forward(request, response);
    }

    private boolean isStudentAssignedToRoom(String studentID, String roomID, AssignmentsDAO assignmentsDAO) {
        List<Assignments> assignments = assignmentsDAO.getAssignmentsByStudents(studentID);
        for (Assignments assignment : assignments) {
            if (assignment != null && roomID.equals(assignment.getRoomID())) {
                return true;
            }
        }
        return false;
    }

    private boolean isServiceValid(String serviceID, ServicesDAO servicesDAO) {
        List<Services> services = servicesDAO.getServices();
        for (Services service : services) {
            if (service != null && serviceID.equals(service.getServiceID())) {
                return true;
            }
        }
        return false;
    }

    private boolean isServiceAlreadyRegistered(String roomID, String serviceID, ServiceUsageDAO serviceUsageDAO) {
        List<ServiceUsage> serviceUsages = serviceUsageDAO.getServiceUsageByRooms(roomID);
        for (ServiceUsage usage : serviceUsages) {
            if (serviceID.equals(usage.getServiceID())) {
                return true;
            }
        }
        return false;
    }
}