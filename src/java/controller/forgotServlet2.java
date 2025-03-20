/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import model.*;

public class forgotServlet2 extends HttpServlet {
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
        String rePassword = request.getParameter("re-password");
        AccountsDAO a = new AccountsDAO();
        Accounts x = a.getAccount(email);
        if(!password.equals(rePassword)){
            request.setAttribute("errorMessage", "Password does not match.");
            request.getRequestDispatcher("forgot2.jsp").forward(request, response);
        }
        else {
            x.setPassword(password);
            a.update(email, x);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

