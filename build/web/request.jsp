<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.RequestDAO" %>
<%@page import = "model.Request" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String staffID = s.getStaffID();
    String position = s.getPosition();
    char buildingID = s.getBuildingID();
    String p = null;
    switch(position){
        case "Assignment Manager": p="Assignment"; break;
        case "Service Manager": p="Service"; break;
        case "Dorm Technician": p="Maintenance"; break;
        default: p="Other"; break;
    }
    RequestDAO r = new RequestDAO();
    List<Request> x1 = r.getRequest(buildingID);
    List<Request> x2 = r.getRequestForStaff(p, buildingID);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Request</title>
        <style>
            html, body {
                height: 100%; /* Full height */
                margin: 0; /* Remove default margin */
                padding: 20px;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4; /* Light gray background */
            }
            h1 {
                color: #333; /* Dark text color */
                text-align: center; /* Center header */
            }
            table {
                border-collapse: collapse;
                width: 100%; /* Full width */
                background-color: #fff; /* White background */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                margin-top: 20px; /* Margin above table */
            }
            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd; /* Light gray border */
            }
            th {
                background-color: #4CAF50; /* Green background for header */
                color: white; /* White text in header */
            }
            tr:hover {
                background-color: #f2f2f2; /* Light gray on hover */
            }
            form {
                display: inline; /* Inline forms for buttons */
            }
            input[type="submit"] {
                padding: 6px 12px;
                margin: 2px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type="submit"][name="status"][value="Accept"] {
                background-color: #4CAF50; /* Green for accept */
                color: white; /* White text */
            }
            input[type="submit"][name="status"][value="Reject"] {
                background-color: #f44336; /* Red for reject */
                color: white; /* White text */
            }
            button {
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                background-color: #008CBA; /* Blue button */
                color: white; /* White text */
                cursor: pointer;
                margin-top: 20px;
                display: block; /* Center button */
                margin-left: auto;
                margin-right: auto;
            }
            button:hover {
                background-color: rgba(255, 165, 0, 0.8); /* Orange on hover */
            }

            .message {
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <h1>Student Request</h1>
        <input type="hidden" name="staffID" value="<%= staffID %>">
        <table>
            <tr>
                <th>Student ID</th>
                <th>Room ID</th>
                <th>Description</th>
                <th>Status</th>
                <th></th>
                <th></th>
            </tr>
            <% if(position.equals("Dorm Manager")){
                    if (x1 != null && !x1.isEmpty()) {
                    for (Request rq : x1) {
            %>
            <tr>
                <td><%= rq.getStudentID() %></td>
                <td><%= rq.getRoomID() %></td>
                <% if(rq.getDescription().equals("Service Registration")){ %>
                <td><%= rq.getDescription() %> <%= rq.getServiceID() %></td>
                <% } else{ %>
                <td><%= rq.getDescription() %></td>
                <% } %>
                <td><%= rq.getStatus() %></td>
                <td>
                    <form action="requestProcess" method="post">
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <input type="hidden" name="studentID" value="<%= rq.getStudentID() %>">
                        <input type="hidden" name="roomID" value="<%= rq.getRoomID() %>">
                        <input type="hidden" name="description" value="<%= rq.getDescription() %>">
                        <input type="hidden" name="position" value="<%= rq.getPosition() %>">
                        <input type="hidden" name="buildingID" value="<%= buildingID %>">
                        <input type="hidden" name="serviceID" value="<%= rq.getServiceID() %>">
                        <input type="submit" name="status" value="Accept">
                    </form>
                </td>
                <td>
                    <form action="requestProcess" method="post">
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <input type="hidden" name="studentID" value="<%= rq.getStudentID() %>">
                        <input type="hidden" name="roomID" value="<%= rq.getRoomID() %>">
                        <input type="hidden" name="description" value="<%= rq.getDescription() %>">
                        <input type="hidden" name="position" value="<%= rq.getPosition() %>">
                        <input type="hidden" name="buildingID" value="<%= buildingID %>">
                        <input type="hidden" name="serviceID" value="<%= rq.getServiceID() %>">
                        <input type="submit" name="status" value="Reject">
                    </form>
                </td>
            </tr>
            <%
                    }
            %>
            <%
                } else { %>
            <tr>
                <td colspan="6" class="message">No requests found.</td>
            </tr>
            <% }} else{
                    if (x2 != null && !x2.isEmpty()) {
                    for (Request rq : x2) {
            %>
            <tr>
                <td><%= rq.getStudentID() %></td>
                <td><%= rq.getRoomID() %></td>
                <% if(rq.getDescription().equals("Service Registration")){ %>
                <td><%= rq.getDescription() %> <%= rq.getServiceID() %></td>
                <% } else{ %>
                <td><%= rq.getDescription() %></td>
                <% } %>
                <td><%= rq.getStatus() %></td>
                <td>
                    <form action="requestProcess" method="post">
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <input type="hidden" name="studentID" value="<%= rq.getStudentID() %>">
                        <input type="hidden" name="roomID" value="<%= rq.getRoomID() %>">
                        <input type="hidden" name="description" value="<%= rq.getDescription() %>">
                        <input type="hidden" name="position" value="<%= rq.getPosition() %>">
                        <input type="hidden" name="serviceID" value="<%= rq.getServiceID() %>">
                        <input type="submit" name="status" value="Accept">
                    </form>
                </td>
                <td>
                    <form action="requestProcess" method="post">
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <input type="hidden" name="studentID" value="<%= rq.getStudentID() %>">
                        <input type="hidden" name="roomID" value="<%= rq.getRoomID() %>">
                        <input type="hidden" name="description" value="<%= rq.getDescription() %>">
                        <input type="hidden" name="description" value="<%= rq.getPosition() %>">
                        <input type="hidden" name="serviceID" value="<%= rq.getServiceID() %>">
                        <input type="submit" name="status" value="Reject">
                    </form>
                </td>
            </tr>
            <%
                    }
            %>
            <%
                } else { %>
            <tr>
                <td colspan="6" class="message">No requests found.</td>
            </tr>
            <%}}
            %>
        </table>
        <%
            if(s.getPosition().equals("Dorm Manager")){
        %>
        <button onclick="window.location.href = 'manager.jsp';">Turn Back</button>
        <%
            } else {
        %>
        <button onclick="window.location.href = 'staff.jsp';">Turn Back</button>
        <%
            }
        %>
    </body>
</html>
