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
        <title>Staff Information</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 500px;
                margin-top: 50px;
                padding: 20px;
                background: rgba(255, 255, 255, 0.9); /* semi-transparent for readability */
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            h1 {
                color: #007bff;
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
            }
            .info {
                margin: 10px 0;
                font-size: 16px;
                color: #333;
            }
            .info strong {
                color: #007bff;
            }
            .btn-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .btn {
                width: 48%;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Staff Information</h1>
            <p class="info"><strong>Staff ID:</strong> <%= ID %></p>
            <p class="info"><strong>Staff Name:</strong> <%= name %></p>
            <p class="info"><strong>Date Of Birth:</strong> <%= dob %></p>
            <p class="info"><strong>Gender:</strong> <%= gender %></p>
            <p class="info"><strong>Email:</strong> <%= email %></p>
            <p class="info"><strong>Phone:</strong> <%= phone %></p>
            <p class="info"><strong>Position:</strong> <%= position %></p>
            <p class="info"><strong>Building:</strong> <%= buildingID %></p>

            <div class="btn-group">
                <a href="staff.jsp" class="btn btn-secondary">Turn Back</a>
                <a href="staffChange.jsp" class="btn btn-primary">Change Information</a>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>