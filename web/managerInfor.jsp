<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%@page import = "java.sql.Date" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String ID = s.getStaffID();
    String name = s.getStaffName();
    Date dob = s.getDOB();
    String gender = s.getGender();
    String email = s.getEmail();
    String phone = s.getPhone();
    String position = s.getPosition();
    char buildingID = s.getBuildingID();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Information</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #333;
            }

            .container {
                max-width: 600px;
                margin: 100px auto;
                background-color: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #4CAF50;
                margin-bottom: 30px;
            }

            .info {
                margin-bottom: 15px;
                font-size: 18px;
            }

            .info span {
                font-weight: bold;
                color: #333;
            }

            .actions {
                text-align: center;
                margin-top: 20px;
            }

            .actions a {
                text-decoration: none;
                color: #fff;
                background-color: #4CAF50;
                padding: 10px 20px;
                border-radius: 5px;
                margin: 5px;
                display: inline-block;
            }

            .actions a:hover {
                background-color: rgba(255, 165, 0, 0.8); /* Màu cam nhạt */
            }

            .actions a.change {
                background-color: orange;
            }

            .actions a.change:hover {
                background-color: darkorange;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Manager Information</h1>
            <p class="info"><span>Manager ID:</span> <%= ID %></p>
            <p class="info"><span>Manager Name:</span> <%= name %></p>
            <p class="info"><span>Date Of Birth:</span> <%= dob %></p>
            <p class="info"><span>Gender:</span> <%= gender %></p>
            <p class="info"><span>Email:</span> <%= email %></p>
            <p class="info"><span>Phone:</span> <%= phone %></p>
            <p class="info"><span>Position:</span> <%= position %></p>
            <p class="info"><span>Building:</span> <%= buildingID %></p>

            <div class="actions">
                <p> <a href="manager.jsp"> Turn Back</a>
                    <a href="managerChange.jsp"> Change Information</a>
            </div>
        </div>
    </body>
</html>


<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>