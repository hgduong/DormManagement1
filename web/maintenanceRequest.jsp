<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.MaintenanceRequestsDAO" %>
<%@page import = "model.MaintenanceRequests" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String email = s.getEmail();
    MaintenanceRequestsDAO a = new MaintenanceRequestsDAO();
    List<MaintenanceRequests> x = new ArrayList<MaintenanceRequests>();
    if(s.getPosition().equals("Dorm Manager"))
        x = a.getRequests(s.getBuildingID());
    else
        x = a.getRequestsByStaffs(s.getStaffID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maintenance Request Information</title>
        <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        /* Table Styles */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #4B8BBE;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Button Styles */
        input[type="submit"] {
            padding: 8px 12px;
            font-size: 14px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        /* Back Button */
        button.back {
            padding: 10px 15px;
            font-size: 16px;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin: 20px;
        }

        button.back:hover {
            background-color: rgba(255, 165, 0, 0.8);
        }

        /* Message Styles */
        .message {
            color: #d9534f;
            font-size: 18px;
            text-align: center;
            margin: 20px auto;
            width: 90%;
        }
    </style>
    </head>
    <body>
        <table>
            <thead>
            <tr>
                <th>Request ID</th>
                <th>Room</th>
                <th>Problem Description</th>
                <th>Request Date</th>
                <th>Completion Date</th>
                <th>Status</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
        <% 
            if (x != null && !x.isEmpty()) {
                for (MaintenanceRequests maintenanceRequest : x) {
        %>
            <tr>
                <td><%= maintenanceRequest.getRequestID() %></td>
                <td><%= maintenanceRequest.getRoomID() %></td>
                <td><%= maintenanceRequest.getProblemDescription() %></td>
                <td><%= maintenanceRequest.getRequestDate() %></td>
                <td><%= maintenanceRequest.getCompletionDate() %></td>
                <td><%= maintenanceRequest.getStatus() %></td>
                <% if(maintenanceRequest.getCompletionDate()==null){ %>
                <td>
                    <form action="completeRequest" method="post">
                        <input type="hidden" name="requestID" value="<%= maintenanceRequest.getRequestID() %>">
                        <input type="submit" value="Complete Request">
                    </form>
                </td>
                <% } %>
            </tr>
            <%      }
                } else {
            %>
            <tr>
                <td colspan="7" class="message">No maintenance requests found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
            <%
            if(s.getPosition().equals("Dorm Manager")){
        %>
            <button class="back" onclick="window.location.href = 'manager.jsp';">Turn Back</button>
        <%
            } else {
        %>
            <button class="back" onclick="window.location.href = 'staff.jsp';">Turn Back</button>
        <%
            }
        %>
    </body>
</html>

<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>