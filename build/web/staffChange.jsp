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
        <title>Staff Information</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(135deg, #6e7bff, #b0d4ff);
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .container {
                max-width: 600px;
                background: #fff;
                padding: 30px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                margin: 20px;
                width: 100%;
                text-align: left;
            }
            h1 {
                text-align: center;
                color: #007bff;
                font-size: 32px;
                margin-bottom: 20px;
            }
            label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                display: block;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-control {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                border-radius: 8px;
                border: 1px solid #ddd;
                font-size: 16px;
                transition: border-color 0.3s;
            }
            .form-control:focus {
                border-color: #007bff;
                outline: none;
            }
            .btn-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .btn {
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-secondary {
                background-color: #f1f1f1;
                color: #333;
            }
            .btn-secondary:hover {
                background-color: #ddd;
            }
            .form-group select {
                padding: 8px;
                border-radius: 8px;
                border: 1px solid #ddd;
                font-size: 16px;
                width: 32%;
            }
            .form-group select:focus {
                border-color: #007bff;
            }
            .d-flex {
                display: flex;
                gap: 8px;
            }
            .d-flex select {
                width: auto;
                padding: 8px;
                border-radius: 8px;
                font-size: 16px;
            }
            .form-group p {
                margin: 0;
                padding: 8px 0;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Staff Information Update</h1>
            <form action="staffChange" method="post">
                <input type="hidden" id="email" name="email" value="<%= email %>">
                <div class="form-group">
                    <label>Staff ID:</label>
                    <p><%= ID %></p>
                </div>
                <div class="form-group">
                    <label for="name">Staff Name:</label>
                    <input id="name" name="name" class="form-control" placeholder="<%= name %>">
                </div>
                <div class="form-group">
                    <label>Date Of Birth:</label>
                    <div class="d-flex">
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
                </div>
                <div class="form-group">
                    <label>Gender:</label>
                    <div>
                        <input type="radio" name="gender" value="Female" <%= "Female".equals(gender) ? "checked" : "" %>> Female
                        <input type="radio" name="gender" value="Male" <%= "Male".equals(gender) ? "checked" : "" %>> Male
                    </div>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <p><%= email %></p>
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input id="phone" name="phone" class="form-control" placeholder="<%= phone %>">
                </div>

                <div class="form-group">
                    <label>Position:</label>
                    <p><%= position %></p>
                </div>

                <div class="form-group">
                    <label>Building:</label>
                    <p><%= buildingID %></p>
                </div>
                <div class="btn-group">
                    <input type="submit" class="btn btn-primary" value="Confirm">
                    <p> <a href="staffInfor.jsp" class="btn btn-secondary"> Turn Back</a>
                </div>
            </form>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


<%
    if (staffSession == null || staffSession.getAttribute("staff") == null) {
        response.sendRedirect("index.html");  // Chuyển hướng đến trang login
        return;
    }
%>