<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "java.util.*" %>
<%@page import = "model.ServicesDAO" %>
<%@page import = "model.Services" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    ServicesDAO ser = new ServicesDAO();
    List<Services> x = ser.getServices();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Building Service Information</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }
        h2 {
            color: #333;
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .warning {
            color: red;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"], button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }
        input[type="submit"]:hover, button:hover {
            background-color: orange;
        }
    </style>
    </head>
    <body>
        <h2>Building Services:</h2>
        <table border="1">
            <tr>
                <th>Service ID</th>
                <th>Service Name</th>
                <th>Service Price</th>
            </tr>
        <% 
            if (x != null && !x.isEmpty()) {
                for (Services service : x) {
        %>
            <tr>
                <td><%= service.getServiceID() %></td>
                <td><%= service.getServiceName() %></td>
                <td><%= service.getCost() %></td>
            </tr>
            <%      }
                }
            %>
        </table>
        <br>
        <h2>Choose Service:</h2>
        <form action="serviceRegistration" method="post">
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
                    <div id="warning-msg" class="warning">
                    &#9888; <%= successfulMessage %>
                    </div>
                <% } %>
            <div>
            <label for="serviceID">Service:</label>
            <input type="text" id="serviceID" name="serviceID" required>
        </div>
        <div>
            <label for="roomID">Room:</label>
            <input type="text" id="roomID" name="roomID" required>
        </div>
        <input type="submit" value="Confirm">
        </form>
        <button onclick="window.location.href = 'student.jsp';">Turn Back</button>
    </body>
</html>

<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>