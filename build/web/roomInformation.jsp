<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.RoomInformationDAO" %>
<%@page import = "model.RoomInformation" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    List<RoomInformation> xr = (List<RoomInformation>) request.getAttribute("roomInformation");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            button {
                position: absolute;
                padding: 10px 15px;
                font-size: 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                left: 50%;
            }
            button:hover {
                background-color: #45a049;
            }
            .message {
                text-align: center;
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
            }
        </style>
    </head>
    <body> 
        <table>
            <thead>
                <tr>
                    <th scope="col">Student ID</th>
                    <th scope="col">Student Name</th>
                    <th scope="col">Room</th>
                    <th scope="col">Assignment End</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (xr != null && !xr.isEmpty()) {
                        for (RoomInformation room : xr) {
                %>
                <tr>
                    <td><%= room.getStudentID() %></td>
                    <td><%= room.getStudentName() %></td>
                    <td><%= room.getRoomID() %></td>
                    <td><%= room.getAssignmentEnd() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="message">No room information available.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <button onclick="window.location.href = 'roomInfor.jsp';">Turn Back</button>
    </body>
</html>

<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>