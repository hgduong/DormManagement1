<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.PaymentsDAO" %>
<%@page import = "model.Payments" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    PaymentsDAO a = new PaymentsDAO();
    List<Payments> x = new ArrayList<Payments>();
    if(s.getPosition().equals("Dorm Manager"))
        x = a.getPayments(s.getBuildingID());
    else
        x = a.getPaymentsByStaffs(s.getStaffID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Information</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                max-width: 100%; /* Ensure full-width */
                margin: 20px auto; /* Center the table */
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:hover {
                background-color: #f2f2f2;
            }
            button {
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                background-color: #008CBA;
                color: white;
                cursor: pointer;
                margin-top: 20px;
                display: block; /* Block display to center */
                margin-left: auto;
                margin-right: auto; /* Center the button */
            }
            button:hover {
                background-color: rgba(255, 165, 0, 0.8);
            }
        </style>
    </head>
    <body>
        <h1 style="text-align: center;">Payment Information</h1>
        <table>
            <tr>
                <th>Payment ID</th>
                <th>Room</th>
                <th>Service ID</th>
                <th>Amount</th>
                <th>Payment Deadline</th>
                <th>Status<th>
            </tr>
            <% 
                if (x != null && !x.isEmpty()) {
                    for (Payments payment : x) {
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
            </tr>
            <%      }
                } else {
            %>
            <tr>
                <td colspan="6">No payment records found.</td>
            </tr>
            <% } %>
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