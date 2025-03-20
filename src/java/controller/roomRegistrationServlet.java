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

public class roomRegistrationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        response.sendRedirect("student.jsp");

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String studentID = request.getParameter("student");
        String room = request.getParameter("room");
        String buildingID = request.getParameter("buildingID");
        char b = buildingID.charAt(0);

        AssignmentsDAO a = new AssignmentsDAO();
        List<Assignments> x = a.getAssignmentsByStudents(studentID);
        RoomsDAO roomsDAO = new RoomsDAO();
        RequestDAO requestDAO = new RequestDAO();

        if (!isValidRoom(room, b, roomsDAO)) {
            request.setAttribute("errorMessage", "Invalid Room.");
            request.getRequestDispatcher("roomRegistration.jsp").forward(request, response);
            return;
        }

        if (isRoomAlreadyRegistered(room, studentID, a)) {
            request.setAttribute("errorMessage", "You have already registered for this room.");
            request.getRequestDispatcher("roomRegistration.jsp").forward(request, response);
            return;
        }

        RequestDAO r = new RequestDAO();
        Request xx = new Request();
        xx.setRoomID(room);
        xx.setStudentID(studentID);
        xx.setDescription("Room Registration");
        xx.setPosition("Assignment");
        xx.setBuildingID(b);
        r.insert(xx);
        request.setAttribute("successfulMessage", "Successful registered room " + room + ".");
        request.getRequestDispatcher("roomRegistration.jsp").forward(request, response);

    }

    private boolean isRoomAlreadyRegistered(String roomID, String studentID, AssignmentsDAO assignmentDAO) {
        List<Assignments> assignments = assignmentDAO.getAssignmentsByStudents(studentID);
        for (Assignments a : assignments) {
            if (roomID.equals(a.getRoomID())) {
                return true;
            }
        }
        return false;
    }

    private boolean isValidRoom(String roomID, char buildingID, RoomsDAO roomsDAO) {
        List<Rooms> rooms = roomsDAO.getRooms(buildingID);
        for (Rooms r : rooms) {
            if (roomID.equals(r.getRoomID())) {
                return true;
            }
        }
        return false;
    }
}
