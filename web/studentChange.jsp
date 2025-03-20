<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "java.util.*" %>
<%@page import = "java.sql.Date" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String ID = s.getStudentID();
    String name = s.getStudentName();
    Date dob = s.getDob();
    String gender = s.getGender();
    String email = s.getEmail();
    String phone = s.getPhone();
    String department = s.getDepartment();
    
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    
    int day = Integer.parseInt(dayFormat.format(dob));
    int month = Integer.parseInt(monthFormat.format(dob));
    int year = Integer.parseInt(yearFormat.format(dob));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Information</title>
        <style>
            body {
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed;
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                background-size: cover;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 700px;
                margin: 50px auto;
                background-color: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h2 {
                color: #333;
                margin-bottom: 10px;
            }
            label {
                font-weight: bold;
            }
            input[type="text"],
            input[type="tel"] {
                width: 97%;
                padding: 10px;
                margin: 10px 0 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            input[type="submit"],
            select {
                width: 100%;
                padding: 10px;
                margin: 10px 0 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            input[type="submit"] {
                background-color: #007bff;
                color: white;
                cursor: pointer;
                border: none;
            }
            input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .radio-group {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }
            .radio-group input[type="radio"] {
                width: auto;
            }
            .back-link {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
                margin-top: 20px;
                display: inline-block;
            }
            .back-link:hover {
                color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form action="studentChange" method="post">
                <input type="hidden" id="email" name="email" value="<%= email %>">
                <h2>Student ID: <%= ID %></h2>

                <div class="form-group">
                    <label for="name">Student Name:</label>
                    <input id="name" name="name" placeholder="<%= name %>" type="text">
                </div>
                <div class="form-group">
                    <label>Date of Birth:</label>
                    <div>
                        <select id="day" name="day" required>
                            <option value="">Date</option>
                            <% for (int i = 1; i <= 31; i++) { 
                                if(i == day){
                            %>
                            <option value="<%= i %>" selected> <%= i %></option>
                            <%} else{ %>
                            <option value="<%= i %>"> <%= i %></option>
                            <% 
                                  }
                                } %>
                        </select>
                        <select id="month" name="month" required>
                            <option value="">Month</option>
                            <% for (int i = 1; i <= 12; i++) { 
                                if(i == month){
                            %>
                            <option value="<%= i %>" selected> <%= i %></option>
                            <%} else{ %>
                            <option value="<%= i %>"> <%= i %></option>
                            <% 
                                  }
                                } %>
                        </select>
                        <select id="year" name="year" required>
                            <option value="">Year</option>
                            <% for (int i = 1900; i <= 2024; i++) { 
                                if(i == year){
                            %>
                            <option value="<%= i %>" selected> <%= i %></option>
                            <%} else{ %>
                            <option value="<%= i %>"> <%= i %></option>
                            <% 
                                  }
                                } %>
                        </select>
                    </div>
                </div>

                <div class="form-group radio-group">
                    <label>Gender:</label>
                    <label><input type="radio" name="gender" value="Female" <%= "Female".equals(gender) ? "checked" : "" %>> Female</label>
                    <label><input type="radio" name="gender" value="Male" <%= "Male".equals(gender) ? "checked" : "" %>> Male</label>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <p><%= email %></p>
                </div>

                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input id="phone" name="phone" placeholder="<%= phone %>" type="tel">
                </div>

                <div class="form-group">
                    <label>Department:</label>
                    <p><%= department %></p>
                </div>

                <input type="submit" value="Confirm">
                <a href="studentInfor.jsp" class="back-link">Turn Back</a>
            </form>
        </div>
    </body>
</html>


<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>