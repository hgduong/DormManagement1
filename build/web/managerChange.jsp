<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StaffsDAO" %>
<%@page import = "model.Staffs" %>
<%@page import = "java.util.*" %>
<%@page import = "java.sql.Date" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%
    HttpSession staffSession = request.getSession(false);
    Staffs s = (Staffs) staffSession.getAttribute("staff");
    String ID = s.getStaffID();
    String name = s.getStaffName();
    Date dob = s.getDOB();
    String gender = s.getGender();
    String email = s.getEmail();
    String phone = s.getPhone();
    String position = s.getPosition();
    char buildingID = s.getBuildingID();
    
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    
    int day = Integer.parseInt(dayFormat.format(dob));
    int month = Integer.parseInt(monthFormat.format(dob));
    int year = Integer.parseInt(yearFormat.format(dob));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Information</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #333;
            }

            .container {
                max-width: 600px;
                margin: 100px auto;
                background-color: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            h2 {
                color: #4CAF50;
                margin-bottom: 10px;
            }

            input[type="text"], select {
                width: calc(100% - 20px);
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            input[type="radio"] {
                margin: 0 10px 0 0;
            }

            .actions {
                text-align: center;
                margin-top: 20px;
            }

            .actions a {
                text-decoration: none;
                color: #fff;
                background-color: #4CAF50;
                padding: 10px 20px;
                border-radius: 5px;
                margin: 5px;
                display: inline-block;
            }

            .actions a:hover {
                background-color: rgba(255, 165, 0, 0.8); /* Light orange */
            }

            .actions input[type="submit"] {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 10px 20px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .actions input[type="submit"]:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }
            .dob{
                display: flex;
            }

            .dob select {
                width: 33.3%; /* Full width */
                padding: 10px; /* Inner padding */
                margin-bottom: 20px; /* Space below select box */
                border: 1px solid #ccc; /* Border style */
                border-radius: 6px; /* Rounded corners */
                font-size: 14px; /* Font size */
            }
            
            .fixed{
                background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
                width: calc(100% - 20px); /* Full width */
                padding: 10px; /* Inner padding */
                margin-bottom: 15px; /* Space below fields */
                border: 1px solid #ccc; /* Border style */
                border-radius: 6px; /* Rounded corners */
                font-size: 14px; /* Font size */
                text-align: left; /* Căn chỉnh văn bản bên trái */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form action="managerChange" method="post">
                <input type="hidden" id="email" name="email" value="<%= email %>">
                <h2>Manager ID:</h2>
                <div class="fixed"> <%= ID %> </div>
                <h2>Manager Name: </h2><input type="text" id="name" name="name" placeholder="<%= name %>" >
                <h2>Date Of Birth: </h2>
                <div class="dob">
                    <select id="day" name="day" required>
                        <option value="">Date</option>
                        <% for (int i = 1; i <= 31; i++) { 
                            if(i == day){
                        %>
                        <option value="<%= i %>" selected> <%= i %></option>
                        <%} else{ %>
                        <option value="<%= i %>"> <%= i %></option>
                        <% 
                              }
                            } %>
                    </select>
                    <select id="month" name="month" required>
                        <option value="">Month</option>
                        <% for (int i = 1; i <= 12; i++) { 
                            if(i == month){
                        %>
                        <option value="<%= i %>" selected> <%= i %></option>
                        <%} else{ %>
                        <option value="<%= i %>"> <%= i %></option>
                        <% 
                              }
                            } %>
                    </select>
                    <select id="year" name="year" required>
                        <option value="">Year</option>
                        <% for (int i = 1900; i <= 2024; i++) { 
                            if(i == year){
                        %>
                        <option value="<%= i %>" selected> <%= i %></option>
                        <%} else{ %>
                        <option value="<%= i %>"> <%= i %></option>
                        <% 
                              }
                            } %>
                    </select>
                </div>
                <h2>Gender: </h2>
                <label>
                    <input type="radio" name="gender" value="Female" <%= gender.equals("Female") ? "checked" : "" %>> Female
                </label>
                <label>
                    <input type="radio" name="gender" value="Male" <%= gender.equals("Male") ? "checked" : "" %>> Male
                </label>
                <h2>Email:</h2>
                <div class="fixed"> <%= email %> </div>
                <h2>Phone: </h2><input type="text" id="phone" name="phone" placeholder="<%= phone %>">
                <h2>Position:</h2>
                <div class="fixed"> <%= position %> </div>
                <h2>Building:</h2>
                <div class="fixed"> <%= buildingID %> </div>

                <div class="actions">
                    <a href="managerInfor.jsp">Turn Back</a>
                    <input type="submit" value="Confirm">
                </div>
            </form>
        </div>
    </body>
</html>


<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>