<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.RoomsDAO" %>
<%@page import = "model.Rooms" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    RoomsDAO r = new RoomsDAO();
    List<Rooms> xr = r.getRooms(s.getBuildingID());
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #4CAF50;
                color: white;
                text-transform: uppercase;
            }

            tr:hover {
                background-color: #f1f1f1;
                transition: background-color 0.3s ease;
            }

            a {
                color: #4CAF50;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                color: orange;
                text-decoration: underline;
            }

            button {
                display: inline-block;
                padding: 12px 24px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
                margin-top: 20px;
            }

            button:hover {
                background-color: orange;
                transition: background-color 0.3s ease;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                table, th, td {
                    display: block;
                    width: 100%;
                }

                th {
                    text-align: left;
                }

                button {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body> 
        <h1>Room List </h1>
        <table>
            <tr>
                <th>Room ID</th>
                <th>Capacity</th>
                <th>Current Occupants</th>
                <th>Room Price</th>
            </tr>
            <%
                if (xr != null && !xr.isEmpty()) {
                    for (Rooms room : xr) {
            %>
                    <tr>
                        <td>
                            <a href="roomInformation?roomID=<%= room.getRoomID() %>">
                                <%= room.getRoomID() %>
                            </a>
                        </td>
                        <td><%= room.getCapacity() %></td>
                        <td><%= room.getCurrentOccupants() %></td>
                        <td><%= room.getRoomPrice() %></td>
                    </tr>
            <%
                    }
            %>
            <%
                }
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

<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>