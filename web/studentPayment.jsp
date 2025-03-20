<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.AssignmentsDAO" %>
<%@page import = "model.Assignments" %>
<%@page import = "model.PaymentsDAO" %>
<%@page import = "model.Payments" %>
<%@page import = "java.sql.Date" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    AssignmentsDAO a = new AssignmentsDAO();
    List<Assignments> x = a.getAssignmentsByStudents(s.getStudentID());
    PaymentsDAO p = new PaymentsDAO();
    List<Payments> xx = new ArrayList<Payments>();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Payment</title>
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
                margin: 20px 0;
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
                padding: 8px 16px;
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
            .warning {
                background-color: #ffcc00;
                padding: 10px;
                text-align: center;
                margin: 20px 0;
                border-radius: 5px;
                color: #333;
            }

            .message {
                color: #d9534f;
                font-size: 18px;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <table border="1">
            <tr>
                <th>Payment ID</th>
                <th>Room</th>
                <th>Service ID</th>
                <th>Amount</th>
                <th>Payment Deadline</th>
                <th>Status<th>
                <th></th>
            </tr>
            <%  
                for(Assignments assignment : x){
                    xx = p.getPaymentsByRooms(assignment.getRoomID());
                    if (xx != null && !xx.isEmpty()) {
                        for (Payments payment : xx) {
            %>
            <tr>
                <td><%= payment.getPaymentID() %></td>
                <td><%= payment.getRoomID() %></td>
                <td>
                    <% if(payment.getAssignmentID()==null){ %>
                    <%= payment.getUsageID() %>
                    <% } else{ %>
                    <%= payment.getAssignmentID() %>
                    <% }%>
                </td>
                <td><%= payment.getAmount() %></td>
                <td><%= payment.getPaymentDeadLine() %></td>
                <td><%= payment.getStatus() %></td>
                <td>
                    <% if(payment.getStatus().equals("Pending")){ %>
                    <button onclick="window.location.href = 'finishPayment.jsp?paymentID=<%= payment.getPaymentID() %>';">Pay</button>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="8" class="message">No requests found.</td>
            </tr>    
            <% }
            }
            %>
        </table>
        <% 
                        String errorMessage = (String) request.getAttribute("errorMessage"); 
                        if (errorMessage != null) {
        %>
        <div id="warning-msg" class="warning">
            <%= errorMessage %>
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
        <button onclick="window.location.href = 'student.jsp';">Turn Back</button>
    </body>
</html>


<%
    if (studentSession == null || studentSession.getAttribute("student") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>