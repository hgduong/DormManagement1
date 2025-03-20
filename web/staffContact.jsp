<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String buildingID = request.getParameter("buildingID");
    char b = 'A';
    if(buildingID != null && !buildingID.isEmpty()){
        b = buildingID.charAt(0);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Contact</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            padding: 8px 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
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
        button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        button:hover {
            background-color: #218838;
        }
    </style>
    </head>
    <body>
        <h1>Staff Contact</h1>
        <form action="staffContact.jsp" method="post">
            Enter Building: <input type="text" name="buildingID">
            <input type="submit" value="Confirm">
        </form>
        <% if(buildingID != null && !buildingID.isEmpty()) { %>
        <table border="1">
            <tr>
                <th>Staff ID</th>
                <th>Staff Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Position</th>
            </tr>
        <%  
            StaffsDAO ss = new StaffsDAO();
            List<Staffs> x = ss.getStaffsList(b);
            if (x != null && !x.isEmpty()) {
                for (Staffs staff : x) {
        %>
            <tr>
                <td><%= staff.getStaffID() %></td>
                <td><%= staff.getStaffName() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getPhone() %></td>
                <td><%= staff.getPosition() %></td>
            </tr>
            <%      }
                }
            %>
        </table>
            <% } %>
        <button onclick="window.location.href = 'student.jsp';">Turn Back</button>
    </body>
</html>


<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>