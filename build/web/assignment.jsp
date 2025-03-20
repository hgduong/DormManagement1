<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String email = s.getEmail();
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> x = new ArrayList<Assignments>();
    if(s.getPosition().equals("Dorm Manager"))
        x = a.getAssignments(s.getBuildingID());
    else
        x = a.getAssignmentsByStaffs(s.getStaffID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assignment Information</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Roboto', sans-serif;
                background-color: #f5f5f5;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
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
            button {
                padding: 10px 15px;
                font-size: 16px;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin: 10px;
            }

            button.update {
                background-color: #4CAF50;
            }

            button.update:hover {
                background-color: rgba(255, 165, 0, 0.8);
            }

            button.back {
                background-color: #007BFF;
            }

            button.back:hover {
                background-color: rgba(255, 165, 0, 0.8);
            }

            /* Message Styles */
            .message {
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <h1 style="text-align:center;">Assignment Information</h1>
        <table>
            <thead>
                <tr>
                    <th>Assignment ID</th>
                    <th>Student ID</th>
                    <th>Room</th>
                    <th>Assignment Date</th>
                    <th>Assignment End</th>
                    <th>Re-Assign</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (x != null && !x.isEmpty()) {
                        for (Assignments assignment : x) {
                %>
                <tr>
                    <td><%= assignment.getAssignmentID() %></td>
                    <td><%= assignment.getStudentID() %></td>
                    <td><%= assignment.getRoomID() %></td>
                    <td><%= assignment.getAssignmentDate() %></td>
                    <td><%= assignment.getAssignmentEnd() %></td>
                    <td><%= assignment.getReAssign() %></td>
                </tr>
                <%      }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="message">No assignments found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
            
        <form action="updateAssignment" method="post">
            <button type="submit" class="update" onclick="window.location.href = 'updateAssignment';">Update</button>
        </form>
            
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
        response.sendRedirect("index.html");
        return;
    }
%>