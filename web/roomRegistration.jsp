<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.BuildingDAO" %>
<%@page import = "model.Building" %>
<%@page import = "model.RoomsDAO" %>
<%@page import = "model.Rooms" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    BuildingDAO b = new BuildingDAO();
    List<Building> xb = b.getBuilding(); 
    String x = request.getParameter("buildingid");
    RoomsDAO r = new RoomsDAO();
    List<Rooms> xr = null;
    char buildingID = '\u0000';
    if (x != null && !x.isEmpty()) {
        buildingID = x.charAt(0);
        xr = r.getFreeRooms(buildingID);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Registration</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed; /* Background image */
                background-size: cover;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .container {
                background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent background */
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                width: 90%;
                max-width: 800px;
                text-align: center;
            }

            h1 {
                color: #333;
                margin-bottom: 20px;
            }

            form, table {
                margin-bottom: 20px;
                width: 100%;
            }

            select, input[type="submit"], button, input[type="text"] {
                display: inline-block;
                padding: 10px;
                font-size: 16px;
                margin: 10px 0;
                width: 100%;
                box-sizing: border-box;
            }

            select {
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #fff;
                cursor: pointer;
            }

            input[type="submit"], button {
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover, button:hover {
                background-color: orange;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            }

            .warning {
                color: red;
                font-weight: bold;
                margin-top: 10px;
            }

            #warning-msg {
                background-color: #ffdddd;
                padding: 10px;
                border-left: 6px solid #f44336;
                margin-top: 10px;
            }

            @media (max-width: 768px) {
                input[type="submit"], button, select, input[type="text"] {
                    width: 100%;
                }

                table, th, td {
                    display: block;
                    width: 100%;
                }
            }

            .scroll-table-container {
                max-height: 400px; /* Bạn có thể điều chỉnh chiều cao của khung theo ý muốn */
                overflow-y: auto; /* Thêm cuộn dọc nếu danh sách quá dài */
                border: 1px solid #ddd;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Room Registration</h1>
            <form action="roomRegistration.jsp" method="post">
                <label for="building-option">Choose Building: </label>
                <select id="building-option" name="buildingid">
                    <%  
                        for (Building building : xb) {
                    %>
                    <option value="<%= building.getBuildingID() %>"><%= building.getBuildingID() %></option>
                    <% 
                        }
                    %>
                </select>
                <button onclick="window.location.href = 'roomRegistration.jsp';">Confirm</button>
            </form>
            <% if (x != null) { %>
            <h2>Current Room Available: </h2>
            <div class="scroll-table-container">
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
                        <td><%= room.getRoomID() %></td>
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
            </div>

            <form action="roomRegistration" method="post">
                <input type="hidden" name="student" value="<%= s.getStudentID() %>">
                <input type="hidden" name="buildingID" value="<%= buildingID %>">
                <label for="room">Choose Room: </label>
                <input type="text" id="room" name="room" required>
                <input type="submit" value="Confirm">
            </form>
            <% } %>
            <% 
                        String errorMessage = (String) request.getAttribute("errorMessage"); 
                        if (errorMessage != null) {
                %>
                <div id="warning-msg" class="warning">
                    &#9888; <%= errorMessage %>
                </div>
                <% } %>
                <% 
                        String successfulMessage = (String) request.getAttribute("successfulMessage"); 
                        if (successfulMessage != null) {
                %>
                <div>
                    <%= successfulMessage %>
                </div>
                <% } %>
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