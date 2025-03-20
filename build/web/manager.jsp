<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String email = s.getEmail();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dorm Management For Manager</title>
         <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }

            /* Header */
            .header {
                background-color: #6699CC;
                padding: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                color: white;
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .header h1 {
                margin: 0;
                font-size: 24px;
            }

            .header .actions {
                display: flex;
                gap: 15px;
            }

            .header button, .header a{
                background-color: #4CAF50; /* mau xanh nen*/
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
            }
            .header a:hover{
                background-color: rgba(255, 165, 0, 0.8);
            }
            .actions button:hover {
                background-color: rgba(255, 165, 0, 0.8);
            }


            /* Sidebar */
            .sidebar {
                background-color: #333333;
                width: 250px;
                height: 100vh;
                position: fixed;
                top: 60px;
                left: 0;
                padding-top: 20px;
                overflow-y: auto;
            }

            .sidebar a {
                display: block;
                color: white;
                padding: 15px;
                text-decoration: none;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .sidebar a:hover {
                background-color: #575757;
            }

            /* Main content */
            .content {
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center;
                background-size: cover; /* Làm cho ảnh bao phủ toàn bộ khung */
                margin-left: 250px;
                padding: 20px;
                height: 100vh; /* Đảm bảo content đủ chiều cao */
                width: calc(98% - 250px); /* Chiều rộng full trừ đi phần sidebar */
            }


            .content h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .content p {
                color: #666;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Manager</h1>
            <div class="actions">
                <a href="index.html">Logout</a>
                <form action="forgot2.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="email" value="<%= email %>">
                    <button type="submit">Change Password</button>
                </form>
            </div>
        </div>
                    
        <div class="sidebar">
            <a href="managerInfor.jsp">Manager Information</a>
            <a href="staffInBuilding.jsp">All Staff In Building Information</a>
            <a href="roomInfor.jsp">Room Information</a>
            <a href="assignment.jsp">Assignment Information</a>
            <a href="service.jsp">Building Service</a>
            <a href="maintenanceRequest.jsp">Maintenance Request</a>
            <a href="request.jsp">Student Request</a>
            <a href="payment.jsp">Payment Information</a>
        </div>
        
        <div class="content">
            <h2></h2>
        </div>
    </body>
</html>


<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>