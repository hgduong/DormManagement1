<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    StaffsDAO ss = new StaffsDAO();
    List<Staffs> x = ss.getStaffsList(s.getBuildingID());
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Staff In Building Information</title>
        <style>
            /* Reset một số phong cách mặc định */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table th, table td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 12px;
            }

            table th {
                background-color: #4CAF50;
                color: white;
                text-transform: uppercase;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #f1f1f1;
                transition: background-color 0.2s ease-in-out;
            }

            button {
                display: block;
                width: 200px;
                margin: 0 auto;
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
            }

            button:hover {
                background-color: orange;
                transition: background-color 0.3s ease;
            }

            /* Media query để responsive */
            @media (max-width: 768px) {
                table, th, td {
                    display: block;
                    width: 100%;
                    text-align: left;
                }

                table th {
                    text-align: left;
                }

                table tr {
                    margin-bottom: 10px;
                }

                button {
                    width: 100%;
                }
            }

        </style>
    </head>
    <body>
        <h1>All Staff In Building Information</h1>
        <table>
            <tr>
                <th>Staff ID</th>
                <th>Staff Name</th>
                <th>Date Of Birth</th>
                <th>Gender</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Position</th>
            </tr>
        <% 
            if (x != null && !x.isEmpty()) {
                for (Staffs staff : x) {
        %>
            <tr>
                <td><%= staff.getStaffID() %></td>
                <td><%= staff.getStaffName() %></td>
                <td><%= staff.getDOB() %></td>
                <td><%= staff.getGender() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getPhone() %></td>
                <td><%= staff.getPosition() %></td>
            </tr>
            <%      }
                }
            %>
        </table>
        <button onclick="window.location.href = 'manager.jsp';">Turn Back</button>
    </body>
</html>

<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>