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

public class studentMaintenanceRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession studentSession = request.getSession(false);
        Students s = (Students) studentSession.getAttribute("student");
        String roomID = request.getParameter("roomID");
        String description = request.getParameter("description");
        AssignmentsDAO rCheck = new AssignmentsDAO();
        List<Assignments> rooms = rCheck.getAssignmentsByStudents(s.getStudentID());
        boolean roomCheck = false;
        for (Assignments rx : rooms) {
            if (rx != null && rx.getRoomID().equals(roomID)) {
                roomCheck = true;
                break;
            } else {
                roomCheck = false;
            }
        }
        if (roomCheck == false) {
            request.setAttribute("errorMessage", "You are not in this room.");
            request.getRequestDispatcher("studentMaintenanceRequest.jsp").forward(request, response);
            return;
        }
        RoomsDAO rGetBuilding = new RoomsDAO();
        Rooms xBuilding = rGetBuilding.getRooms(roomID);
        RequestDAO r = new RequestDAO();
        Request xx = new Request();
        xx.setRoomID(roomID);
        xx.setStudentID(s.getStudentID());
        xx.setDescription(description);
        xx.setPosition("Maintenance");
        xx.setBuildingID(xBuilding.getBuildingID());
        r.insert(xx);
        request.setAttribute("successfulMessage", "Successful send Maintance Request.");
        request.getRequestDispatcher("studentMaintenanceRequest.jsp").forward(request, response);
    }
}
