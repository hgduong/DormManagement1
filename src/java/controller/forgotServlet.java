/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import model.*;

public class forgotServlet extends HttpServlet {
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
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String role = request.getParameter("Role");
        AccountsDAO a = new AccountsDAO();
        Accounts x = a.getAccount(email); 
        if(x == null){
            request.setAttribute("errorMessage", "Account does not exist.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        }
        else {
            if(role.equals("Manager") || role.equals("Staff")){
                StaffsDAO s = new StaffsDAO();
                Staffs xx = s.getStaffsByEmail(email);
                if(!name.equals(xx.getStaffName()) || !phone.equals(xx.getPhone())){
                    request.setAttribute("errorMessage", "Wrong information.");
                    request.getRequestDispatcher("forgot.jsp").forward(request, response);
                }
                else{
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("forgot2.jsp").forward(request, response);
                }
            }
            else{
                StudentsDAO s = new StudentsDAO();
                Students xx = s.getStudentsByEmail(email);
                if(!name.equals(xx.getStudentName()) || !phone.equals(xx.getPhone())){
                    request.setAttribute("errorMessage", "Wrong information.");
                    request.getRequestDispatcher("forgot.jsp").forward(request, response);
                }
                else{
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("forgot2.jsp").forward(request, response);
                }
            }
        }
    }
}

