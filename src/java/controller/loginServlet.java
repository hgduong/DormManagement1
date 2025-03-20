/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import model.*;

public class loginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        response.sendRedirect("login.jsp");

    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("Role");
        AccountsDAO a = new AccountsDAO();
        Accounts x = a.getAccount(email);
        
        if(x == null || (!password.equals(x.getPassword()) || !role.equals(x.getRole()))){
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        else{
            if(role.equals("Manager")){
                StaffsDAO s = new StaffsDAO();
                Staffs xx = s.getStaffsByEmail(email);
                if(xx == null){
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("registerManager.jsp").forward(request, response);
                }
                else{
                    HttpSession staffSession = request.getSession();
                    staffSession.setAttribute("staff", xx);
                    response.sendRedirect("manager.jsp");
                }
            }
            if(role.equals("Student")){
                StudentsDAO s = new StudentsDAO();
                Students xx = s.getStudentsByEmail(email);
                if(xx == null){
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("registerStudent.jsp").forward(request, response);
                }
                else{
                    HttpSession studentSession = request.getSession();
                    studentSession.setAttribute("student", xx);
                    response.sendRedirect("student.jsp");
                }
            }
            if(role.equals("Staff")){
                StaffsDAO s = new StaffsDAO();
                Staffs xx = s.getStaffsByEmail(email);
                if(xx == null){
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("registerStaff.jsp").forward(request, response);
                }
                else{
                    HttpSession staffSession = request.getSession();
                    staffSession.setAttribute("staff", xx);
                    response.sendRedirect("staff.jsp");
                }
            }
        }
    }
}

