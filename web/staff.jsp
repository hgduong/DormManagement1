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
        <title>Dorm Management For Staff</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-image: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg');
                background-size: cover;
                background-position: center;
                color: #fff;
                height: 100vh;
                margin: 0;
            }
            .container {
                max-width: 500px;
                margin: 50px auto;
                padding: 30px;
                background: rgba(255, 255, 255, 0.9); /* Darker transparent background */
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            }
            h1 {
                color: #007bff;
                text-align: center;
                margin-bottom: 20px;
                font-size: 28px;
                font-weight: bold;
            }
            .link, .btn {
                display: block;
                width: 94%;
                margin-top: 10px;
                padding: 12px;
                font-size: 16px;
                text-align: center;
                border-radius: 5px;
                border: none;
                text-decoration: none;
                color: #fff;
                background-color: #007bff;
                transition: all 0.3s ease;
            }
            .link:hover, .btn:hover {
                background-color: #0056b3;
                color: #fff;
            }
            .btn-primary {
                background-color: #28a745;
            }
            .btn-primary:hover {
                background-color: #218838;
            }
            .logout-btn {
                background-color: #dc3545;
                border: none;
            }
            .logout-btn:hover {
                background-color: #c82333;
            }
            p {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Dorm Management For Staff</h1>
            <a href="index.html" class="link logout-btn">Logout</a>
            <form action="forgot2.jsp" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="submit" value="Change Password" class="btn btn-primary">
            </form>
            <a href="staffInfor.jsp" class="link">Staff Information</a>

            <%
                if(s.getPosition().equals("Assignment Manager")){
            %>
            <p> <a href="roomInfor.jsp" class="link"> Room Information </a>    
            <p> <a href="assignment.jsp" class="link"> Assignment Information</a>   
                <%
                    }
                %>    
                <%
                    if(s.getPosition().equals("Service Manager")){
                %>
            <p> <a href="service.jsp" class="link"> Building Service</a>
                <%
                    }
                %>   
                <%
                    if(s.getPosition().equals("Dorm Technician")){
                %>
            <p> <a href="maintenanceRequest.jsp" class="link"> Maintenance Request</a>  
                <%
                    }
                %>    
            <p> <a href="request.jsp" class="link"> Student Request</a> 
                <%
                    if(s.getPosition().equals("Assignment Manager") || s.getPosition().equals("Service Manager") || s.getPosition().equals("Dorm Technician")){
                %>
            <p> <a href="payment.jsp" class="link"> Payment Information</a> 
                <%
                    }
                %>
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