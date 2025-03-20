<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.BuildingDAO" %>
<%@page import = "model.Building" %>
<%@page import = "java.util.*" %>
 <!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="style.css" type="text/css"/>
        <title>Register</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            /* Body Styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                height: 100vh; /* Full viewport height */
                display: flex;
                justify-content: center;
                align-items: center;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed; /* Background image */
                background-size: cover; /* Cover the entire viewport */
            }

            /* Main container for the login form */
            .register-container {
                background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
                padding: 30px;
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Shadow effect */
                width: 350px; /* Fixed width */
                display: flex; /* Sử dụng flexbox */
                flex-direction: column; /* Căn chỉnh theo chiều dọc */
                align-items: stretch; /* Kéo dài các phần tử con */
                position: relative; /* Position relative for z-index */
                z-index: 1; /* Above the background */
            }

            h2 {
                font-size: 24px; /* Heading size */
                margin-bottom: 20px; /* Space below heading */
                color: #333; /* Heading color */
            }

            /* Form label styles */
            label {
                display: block; /* Block display for labels */
                font-size: 14px; /* Font size */
                margin-bottom: 8px; /* Space below labels */
                text-align: left; /* Align text to the left */
            }

            /* Input field styles */
            input[type="name"],
            input[type="phone"] {
                width: 94%; /* Full width */
                padding: 10px; /* Inner padding */
                margin-bottom: 15px; /* Space below fields */
                border: 1px solid #ccc; /* Border style */
                border-radius: 6px; /* Rounded corners */
                font-size: 14px; /* Font size */
            }
            
            /* Select box styles */
            select {
                width: 100%; /* Full width */
                padding: 10px; /* Inner padding */
                margin-bottom: 20px; /* Space below select box */
                border: 1px solid #ccc; /* Border style */
                border-radius: 6px; /* Rounded corners */
                font-size: 14px; /* Font size */
            }
            
            /*Warning*/
            .warning {
                width: 100%;
                padding: 10px;
                color: red;
                font-size: 16px;
                margin-bottom: 10px;
                border-radius: 6px;
                text-align: left;
            }

            /* Submit button styles */
            input[type="submit"] {
                width: 100%; /* Full width */
                padding: 12px; /* Inner padding */
                background-color: #007bff; /* Button color */
                border: none; /* No border */
                border-radius: 6px; /* Rounded corners */
                color: white; /* Text color */
                font-size: 16px; /* Font size */
                cursor: pointer; /* Pointer cursor */
                margin-bottom: 10px; /* Space below button */
            }

            input[type="submit"]:hover {
                background-color: #0056b3; /* Darker color on hover */
            }

            /* Flex container for options */
            .options-container {
                display: flex; /* Flexbox for alignment */
                justify-content: space-between; /* Space between items */
                margin-top: 15px; /* Space above options */
                font-size: 14px; /* Font size */
            }

            /* Link styles */
            .options-container a {
                color: #007bff; /* Link color */
                text-decoration: none; /* No underline */
            }

            .options-container a:hover {
                text-decoration: underline; /* Underline on hover */
            }

            /* Register button styles */
            .register-btn {
                display: inline-block; /* Inline block for layout */
                padding: 10px 20px; /* Inner padding */
                background-color: transparent;
                color: #007bff; /* Text color */
                border-radius: 6px; /* Rounded corners */
                cursor: pointer; /* Pointer cursor */
                text-decoration: none; /* No underline */
                margin-top: 5px; /* Space above button */
            }

            .register-btn:hover {
                background-color:#FFFFCC; /* Change color on hover */
            }

            /* Forgot password button styles */
            .forgot-password {
                background-color: transparent;
                display: inline-block; /* Inline block for layout */
                padding: 10px 20px; /* Inner padding */
                color: #007bff; /* Text color */
                border-radius: 6px; /* Rounded corners */
                cursor: pointer; /* Pointer cursor */
                text-decoration: none; /* No underline */
                margin-top: 5px; /* Space above button */
                border: none;
            }

            .forgot-password:hover {
                text-decoration: underline; /* Underline on hover */
                background-color:#FFFFCC; /* Change color on hover */
            }
            .gender {
                display: flex;
                gap: 20px; /* Khoảng cách giữa các nút */
            }

            .gender label {
                
                font-size: 16px;
                cursor: pointer;
            }

            .gender input[type="radio"] {
                margin-right: 5px; /* Khoảng cách giữa nút radio và nhãn */
            }

            .gender input[type="radio"]:checked + label {
                color: blue; /* Màu sắc khi nút được chọn */
            }
            
            .dob{
                display: flex;
            }
            
            .dob select {
                width: 30%; /* Full width */
                padding: 10px; /* Inner padding */
                margin-bottom: 20px; /* Space below select box */
                border: 1px solid #ccc; /* Border style */
                border-radius: 6px; /* Rounded corners */
                font-size: 14px; /* Font size */
            }
            
            .email{
                background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
                width: 94%; /* Full width */
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
        <!-- Login form container -->
        <div class="register-container">
            <h2>Enter Your Information</h2>
            <form action="registerManager" method="post">
                <label for="name">Manager Name:</label>
                <input type="name" id="name" name="name" required>
                
                <label for="dob">Date Of Birth:</label>

                <div class="dob">
                <select id="day" name="day" required>
                    <option value="">Date</option>
                    <% for (int i = 1; i <= 31; i++) { %>
                        <option value="<%= i %>"> <%= i %></option>
                    <% } %>
                </select>
                <select id="month" name="month" required>
                    <option value="">Month</option>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"> <%= i %></option>
                    <% } %>
                </select>
                <select id="year" name="year" required>
                    <option value="">Year</option>
                    <% for (int i = 1900; i <= 2024; i++) { %>
                        <option value="<%= i %>"> <%= i %></option>
                    <% } %>
                </select>
                </div>
                <label for="gender">Gender:</label>
                <div class="gender">
                    <label>
                        <input type="radio" name="gender" value="Female" required>
                        Female
                    </label>
                    <label>
                        <input type="radio" name="gender" value="Male">
                        Male
                    </label>
                </div>
                
                <% 
                    String email = (String) request.getAttribute("email");
                %>
                <label for="email">Email:</label>
                <input type="hidden" name="email" value="<%= email %>">
                <div class="email"> <%= email %> </div>
                
                <label for="phone">Phone:</label>
                <input type="phone" id="phone" name="phone" required>
                
                <label for="position">Position:</label>
                <input type="hidden" name="position" value="Dorm Manager">
                <div class="email">Dorm Manager</div>
                
                <% 
                    BuildingDAO b = new BuildingDAO();
                    List<Building> x = b.getBuilding();
                    
                %>
                <label for="building-option">Building</label>
                <select id="building-option" name="building">
                <%  
                    for (Building building : x) {
                %>
                    <option value="<%= building.getBuildingID() %>"><%= building.getBuildingID() %></option>
                <% } %>
                </select>
                
                <!-- Warning message -->
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage"); 
                    if (errorMessage != null) {
                %>
                    <div id="warning-msg" class="warning">
                    &#9888; <%= errorMessage %>
                    </div>
                <% } %>
                
                <input type="submit" value="Register">
            </form>
        </div>
    </body>
</html>

