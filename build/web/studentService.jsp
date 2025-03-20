<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "model.ServiceUsageDAO" %>
<%@page import = "model.ServiceUsage" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String email = s.getEmail();
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> x = a.getAssignmentsByStudents(s.getStudentID());
    ServiceUsageDAO r = new ServiceUsageDAO();
    List<ServiceUsage> xx = new ArrayList<ServiceUsage>();
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student's Room Service</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 800px;
                margin: auto;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
                color: #333;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .back-button {
                display: inline-block;
                padding: 10px 15px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                text-align: center;
                margin-top: 20px;
            }
            .back-button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <table>
                <tr>
                    <th>Service Registered ID</th>
                    <th>Service ID</th>
                    <th>Room</th>
                    <th>Service Start</th>
                    <th>Service End</th>
                </tr>
                <% 
                    for(Assignments assignment : x){
                        xx = r.getServiceUsageByRooms(assignment.getRoomID());
                        if (xx != null && !xx.isEmpty()) {
                            for (ServiceUsage room : xx) {
                %>
                <tr>
                    <td><%= room.getUsageID() %></td>
                    <td><%= room.getServiceID() %></td>
                    <td><%= room.getRoomID() %></td>
                    <td><%= room.getUsageDate() %></td>
                    <td><%= room.getUsageEnd() %></td>
                </tr>
                <%
                        }
                    } else { %>
                <tr>
                    <td colspan="5">No Service found.</td>
                </tr>    
                    <%
                } }
                %>
        </div>
    </table>
</body>
<button class="back-button" onclick="window.location.href = 'student.jsp';">Turn Back</button>
</html>

<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>