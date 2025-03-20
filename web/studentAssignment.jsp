<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String email = s.getEmail();
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> x = a.getAssignmentsByStudents(s.getStudentID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Assignments</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg')no-repeat center center fixed; /* Background image */
                background-size: cover;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: white;
                padding: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                width: 90%;
                max-width: 900px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
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
            }
            button, input[type="submit"] {
                padding: 10px 15px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover, input[type="submit"]:hover {
                background-color: orange;
            }
            
            .message {
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Student Assignments</h2>
        <table>
            <tr>
                <th>Assignment ID</th>
                <th>Room</th>
                <th>Assignment Date</th>
                <th>Assignment End</th>
                <th>Re-Assign</th>
            </tr>
        <% 
            if (x != null && !x.isEmpty()) {
                for (Assignments assignment : x) {
        %>
            <tr>
                <td><%= assignment.getAssignmentID() %></td>
                <td><%= assignment.getRoomID() %></td>
                <td><%= assignment.getAssignmentDate() %></td>
                <td><%= assignment.getAssignmentEnd() %></td>
                <td><%= assignment.getReAssign() %></td>
                <td>
                    <form action="updateReAssign" method="post">
                        <input type="hidden" name="assignmentID" value="<%= assignment.getAssignmentID() %>">
                        <input type="submit" value="Cancel Room">
                    </form>
                </td>
            </tr>
            <%      }
                } else {
            %>
            <tr>
                    <td colspan="6" class="message">No assignments found.</td>
                </tr>
                <% } %>
        </table>
            <button onclick="window.location.href = 'student.jsp'; ">Turn Back</button>
        </div>
    </body>
</html>

<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>