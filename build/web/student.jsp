<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String email = s.getEmail();
    String studentID = s.getStudentID();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dorm Management For Student</title>
        <style>
            /* Basic Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body Styles */
            body {
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #333;
                display: flex;
                justify-content: center;
            }

            /* Main container for content */
            .container {
                background-color: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                width: 80%;
                max-width: 800px;
                margin-left: 200px; /* Push the container to the right */
            }

            /* Logout and Change Password buttons in the top-right */
            .top-right {
                position: absolute;
                top: 20px;
                right: 20px;
                text-align: right;
            }

            .top-right a,
            .top-right form {
                display: inline-block;
                margin-left: 10px;
            }

            /* Options on the left column pushed outside the main view */
            .left-column {
                position: fixed;
                left: 0;
                top: 0;
                width: 250px; /* Width of the options column */
                height: 100%;
                padding: 20px;
                background-color: rgba(255, 255, 255, 0.9);
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .left-column p {
                width: 100%;
                text-align:center;
            }

            .left-column a {
                display: block;
                margin: 10px 0;
                padding: 10px;
                color: #fff;
                background-color: #007bff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.2s ease, transform 0.2s ease;
            }

            .left-column a:hover {
                background-color: rgba(255, 165, 0, 0.8);
                transform: scale(1.05);
            }

            /* Button styles */
            input[type="submit"] {
                padding: 10px 20px;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.2s ease, transform 0.2s ease;
            }

            input[type="submit"]:hover {
                background-color: rgba(255, 165, 0, 0.8);
                transform: scale(1.05);
            }
            /* Login button styles */
            .top-right a {
                display: inline;
                width: 50%; /* Full width */
                padding: 12px; /* Inner padding */
                background-color: #4CAF50; /* Button color */
                border: none; /* No border */
                border-radius: 6px; /* Rounded corners */
                color: white; /* Text color */
                font-size: 16px; /* Font size */
                cursor: pointer; /* Pointer cursor */
                transition: background-color 0.3s; /* Smooth transition */
                text-align: center;
                margin-top: 10px; /* Space above button */

            }

            .top-right a:hover {
                background-color: rgba(255, 165, 0, 0.8); /* Orange on hover */
            }

        </style>
    </head>
    <body>
        <div class="top-right">
            <a href="index.html">Logout</a>
            <form action="forgot2.jsp" method="post" style="display:inline;">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="submit" value="Change Password">
            </form>
        </div>

        <div class="left-column">
            <h2>Options</h2>
            <p><a href="studentInfor.jsp">Student Information</a></p>
            <p><a href="roomRegistration.jsp">Room Registration</a></p>
            <p><a href="studentRooms.jsp">Your Room</a></p>
            <p><a href="studentAssignment.jsp">Your Assignment</a></p>
            <p><a href="serviceRegistration.jsp">Service Registration</a></p>
            <p><a href="studentService.jsp">Your Service</a></p>
            <p><a href="studentMaintenanceRequest.jsp">Maintenance Request</a></p>
            <p><a href="studentRequest.jsp">Your Request</a></p>
            <p><a href="studentPayment.jsp">Your Payment</a></p>
            <p><a href="staffContact.jsp">Staff Contact</a></p>
        </div>

        <div class="container">
            <h1>Dorm Management System</h1>
            <p>Welcome, <%= studentID %>!</p>
        </div>
    </body>
</html>


<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>