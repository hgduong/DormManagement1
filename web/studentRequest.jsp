<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.RequestDAO" %>
<%@page import = "model.Request" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    RequestDAO r = new RequestDAO();
    List<Request> x = r.getRequestForStudent(s.getStudentID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Request</title>
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
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
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
            form {
                text-align: center;
                margin: 20px 0;
            }
            button {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            button:hover {
                background-color: #218838;
            }
            .delete-buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
            }
        </style>
    </head>
    <body>
        <h1>Student Request</h1>
        <table>
            <tr>
                <th>Room ID</th>
                <th>Description</th>
                <th>Status</th>
            </tr>
            <%
                if (x != null && !x.isEmpty()) {
                    for (Request rq : x) {
            %>
            <tr>
                <td><%= rq.getRoomID() %></td>
                <% if(rq.getDescription().equals("Service Registration")){ %>
                <td><%= rq.getDescription() %> <%= rq.getServiceID() %></td>
                <% } else{ %>
                <td><%= rq.getDescription() %></td>
                <% } %>
                <td><%= rq.getStatus() %></td>
            </tr>
            <%
                    }
                } else { %>
            <tr>
                <td colspan="3">No requests found.</td>
            </tr>
            <% } %>
        </table>
        <div class="delete-buttons">
        <form action="deleteRequest" method="post">
            <button type="submit" name="status" value="Accept" style="background-color: #007BFF; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">Delete Accept</button>
        </form>
        <form action="deleteRequest" method="post">
            <button type="submit" name="status" value="Reject" style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">Delete Reject</button>
        </form>
    </div>
        <button onclick="window.location.href = 'student.jsp';">Turn Back</button>
    </body>
</html>

<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>