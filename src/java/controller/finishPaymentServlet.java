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


/**
 *
 * @author admin
 */
public class finishPaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String paymentID = request.getParameter("paymentID");
        String paymentMethod = request.getParameter("paymentMethod");
        
        PaymentsDAO p = new PaymentsDAO();
        Payments x = new Payments();
        
        x.setPaymentID(paymentID);
        x.setPaymentMethod(paymentMethod);
        
        p.update(x);
        
        request.setAttribute("successfulMessage", "Successful Pay " + paymentID + ".");
        request.getRequestDispatcher("studentPayment.jsp").forward(request, response);
    }

}
