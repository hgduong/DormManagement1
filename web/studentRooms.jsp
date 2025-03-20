<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "model.RoomInformationDAO" %>
<%@page import = "model.RoomInformation" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String email = s.getEmail();
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> x = a.getAssignmentsByStudents(s.getStudentID());
    RoomInformationDAO r = new RoomInformationDAO();
    List<RoomInformation> xx = new ArrayList<RoomInformation>();
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Rooms</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed; /* Background image */
                background-size: cover;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .container {
                background-color: #ffffff;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                width: 90%;
                max-width: 1000px;
                text-align: center;
            }
            h2 {
                color: #333;
                margin-bottom: 10px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
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
            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: orange;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Student Room</h1>
            <% 
                for(Assignments assignment : x){
                    xx = r.getRoomInformation(assignment.getRoomID());
            %>
            <h2>Room <%= assignment.getRoomID() %></h2>
            <table border="1">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Room</th>
                    <th>Assignment End</th>
                </tr>
                <%
                    if (xx != null && !xx.isEmpty()) {
                            for (RoomInformation room : xx) {
                %>
                <tr>
                    <td><%= room.getStudentID() %></td>
                    <td><%= room.getStudentName() %></td>
                    <td><%= room.getRoomID() %></td>
                    <td><%= room.getAssignmentEnd() %></td>
                </tr>
                <%
                        }
                    } else { %>
                <tr>
                    <td colspan="4">No Room found.</td>
                </tr>
                <% } }%>
            </table>
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