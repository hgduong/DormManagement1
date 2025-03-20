<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "model.ServicesDAO" %>
<%@page import = "model.Services" %>
<%@page import = "model.ServiceUsageDAO" %>
<%@page import = "model.ServiceUsage" %>
<%@page import = "java.util.*" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    ServicesDAO ser = new ServicesDAO();
    List<Services> x = ser.getServices();
    ServiceUsageDAO serDAO = new ServiceUsageDAO();
    List<ServiceUsage> xx = new ArrayList<ServiceUsage>();
    if(s.getPosition().equals("Dorm Manager")) xx = serDAO.getServices(s.getBuildingID());
    else xx = serDAO.getServiceUsageByStaffs(s.getStaffID());
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Building Service Information</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Arial', sans-serif;
                background-color: #f5f5f5;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            /* Table Styles */
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #4B8BBE;
                color: white;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Button Styles */
            button {
                padding: 10px 15px;
                font-size: 16px;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin: 20px;
            }

            button.back {
                background-color: #007BFF;
            }

            button.back:hover {
                background-color: rgba(255, 165, 0, 0.8);
            }

            /* Message Styles */
            .message {
                color: #d9534f;
                font-size: 18px;
                text-align: center;
                margin: 20px auto;
                width: 90%;
            }
        </style>
    </head>
    <body>
        <h2>Building Services:</h2>
        <table>
            <thead>
                <tr>
                    <th>Service ID</th>
                    <th>Service Name</th>
                    <th>Service Price</th>
                </tr>
            </thead>
            <tbody>
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
            </tbody>
        </table>
        <h2>Service Registration:</h2>
        <table>
            <thead>
                <tr>
                    <th>Service Registered ID</th>
                    <th>Service Registered Date</th>
                    <th>Service Registered End</th>
                    <th>Room</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (xx != null && !xx.isEmpty()) {
                        for (ServiceUsage serviceUsage : xx) {
                %>
                <tr>
                    <td><%= serviceUsage.getUsageID() %></td>
                    <td><%= serviceUsage.getUsageDate() %></td>
                    <td><%= serviceUsage.getUsageEnd() %></td>
                    <td><%= serviceUsage.getRoomID() %></td>
                </tr>
                <%      }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="message">No service registrations found.</td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
        <%
            if(s.getPosition().equals("Dorm Manager")){
        %>
        <button class="back" onclick="window.location.href = 'manager.jsp';">Turn Back</button>
        <%
            } else {
        %>
        <button class="back" onclick="window.location.href = 'staff.jsp';">Turn Back</button>
        <%
            }
        %>
    </body>
</html>

<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>