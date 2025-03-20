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


public class registerManagerServlet extends HttpServlet {
    public static Date convertStringToSqlDate(String dateStr) throws ParseException {
        // Định dạng ngày là DD/MM/YYYY
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        format.setLenient(false); // Kiểm tra ngày hợp lệ

        // Phân tích chuỗi và chuyển sang java.sql.Date
        java.util.Date utilDate = format.parse(dateStr); 
        return new Date(utilDate.getTime()); // Trả về java.sql.Date
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        response.sendRedirect("register.jsp");

    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String day = request.getParameter("day");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String gender = request.getParameter("gender");
        String position = request.getParameter("position");
        String building = request.getParameter("building");

        int d = Integer.parseInt(day);
        int m = Integer.parseInt(month);
        int y = Integer.parseInt(year);
        
        char b = building.charAt(0);
        
        int maxDays;
        if (m == 2) {
            maxDays = (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0) ? 29 : 28;
        } else if (m == 4 || m==6 || m==9 || m==11) {
            maxDays = 30; // Các tháng 4, 6, 9, 11 có 30 ngày
        } else {
            maxDays = 31; // Các tháng còn lại có 31 ngày
        }
        if (d > maxDays) {
            request.setAttribute("email", email);
            request.setAttribute("errorMessage", "Invalid Date.");
            request.getRequestDispatcher("registerManager.jsp").forward(request, response);
        }
        else{
            String dob = day + "/" + month + "/" + year;
            Date sqlDate = null;
            try {
                sqlDate = convertStringToSqlDate(dob);
            } catch (ParseException ex) {
            }
        
            StaffsDAO a = new StaffsDAO();
            Staffs x = new Staffs();
            
            Staffs xx = a.getStaffsByPhone(phone);
            if(xx != null){
                request.setAttribute("email", email);
                request.setAttribute("errorMessage", "Phone already exists.");
                request.getRequestDispatcher("registerManager.jsp").forward(request, response);
            }
            else{
                x.setEmail(email);
                x.setStaffName(name);
                x.setPhone(phone);
                x.setDOB(sqlDate);
                x.setGender(gender);
                x.setPosition(position);
                x.setBuildingID(b);
                a.insert(x);
                
                x = a.getStaffsByEmail(email);
                HttpSession staffSession = request.getSession();
                staffSession.setAttribute("staff", x);
                request.getRequestDispatcher("manager.jsp").forward(request, response);
            }
        }
    }
}

