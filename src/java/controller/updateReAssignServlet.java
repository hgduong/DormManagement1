/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;
import model.*;

/**
 *
 * @author admin
 */
public class updateReAssignServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String assignment = request.getParameter("assignmentID");
        AssignmentsDAO a = new AssignmentsDAO();
        Assignments x = new Assignments();
        x.setAssignmentID(assignment);
        a.update_ReAssign(assignment, x);
        response.sendRedirect("studentAssignment.jsp");
    }
    
}
