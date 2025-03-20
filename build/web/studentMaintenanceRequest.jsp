<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.MaintenanceRequestsDAO" %>
<%@page import = "model.MaintenanceRequests" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    MaintenanceRequestsDAO m = new MaintenanceRequestsDAO();
    List<MaintenanceRequests> x = new ArrayList<MaintenanceRequests>();
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> xx = a.getAssignmentsByStudents(s.getStudentID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maintenance Request</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            h2 {
                color: #333;
            }
            form {
                margin-bottom: 20px;
                padding: 15px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            input[type="text"], input[type="submit"] {
                padding: 8px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="text"] {
                width: calc(100% - 20px);
            }
            input[type="submit"], button {
                padding: 10px 15px;
                color: white;
                background-color: #007BFF;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"]:hover, button:hover {
                background-color: #0056b3;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }
            th {
                background-color: #007BFF;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            #warning-msg {
                color: black;
                font-weight: bold;
            }
            .button-container {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end;
            }
            .message {
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <h2>Request Information:</h2>
        <form action="studentMaintenanceRequest" method="post">
            Room: <input type="room" id="roomID" name="roomID" required>
            <br>
            Problem Detail: <input type="detail" id="description" name="description" required>
            <% 
                        String errorMessage = (String) request.getAttribute("errorMessage"); 
                        if (errorMessage != null) {
            %>
            <div id="warning-msg" class="warning">
                <%= errorMessage %>
            </div>
            <% } %>
            <% 
                String successfulMessage = (String) request.getAttribute("successfulMessage"); 
                if (successfulMessage != null) {
            %>
            <div id="warning-msg" class="warning">
                <%= successfulMessage %>
            </div>
            <% } %>
            <input type="submit" value="Confirm">
        </form>
        <h2>Your Request:</h2>
        <table>
            <tr>
                <th>Request ID</th>
                <th>Room</th>
                <th>Problem Description</th>
                <th>Request Date</th>
                <th>Completion Date</th>
                <th>Status</th>
            </tr>
            <%
                for(Assignments assignment : xx){
                    x = m.getRequestsByRooms(assignment.getRoomID());
                    if (xx != null && !xx.isEmpty()) {
                        for (MaintenanceRequests maintenanceRequest : x) {
            %>
            <tr>
                <td><%= maintenanceRequest.getRequestID() %></td>
                <td><%= maintenanceRequest.getRoomID() %></td>
                <td><%= maintenanceRequest.getProblemDescription() %></td>
                <td><%= maintenanceRequest.getRequestDate() %></td>
                <td><%= maintenanceRequest.getCompletionDate() %></td>
                <td><%= maintenanceRequest.getStatus() %></td>
            </tr>
            <%
                    }
                } else { %>
            <tr>
                <td colspan="8" class="message">No requests found.</td>
            </tr>
            <%
                }
            }
            %>
        </table>
        <form action="deleteRequest" method="post">
            <button type="submit" name="status" value="Completed">Delete Completed</button>
        </form>
        <div class="button-container">
            <button onclick="window.location.href = 'student.jsp';">Turn Back</button>
        </div>
    </body>
</html>

<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>