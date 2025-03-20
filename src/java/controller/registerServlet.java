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

public class registerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("re-password");
        String role = request.getParameter("Role");
        AccountsDAO a = new AccountsDAO();
        Accounts x = a.getAccount(email);
        
        if(!password.equals(rePassword)){
            request.setAttribute("errorMessage", "Password does not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        else if(x != null){
            request.setAttribute("errorMessage", "Account already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        else {
            x = new Accounts();
            x.setEmail(email);
            x.setPassword(password);
            x.setRole(role);
            a.insert(x);
            request.setAttribute("email", email);
            if(role.equals("Student"))
                request.getRequestDispatcher("registerStudent.jsp").forward(request, response);
            else if(role.equals("Manager"))
                request.getRequestDispatcher("registerManager.jsp").forward(request, response);
            else
                request.getRequestDispatcher("registerStaff.jsp").forward(request, response);
        }
    }
}

