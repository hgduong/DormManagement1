<%@page contentType="text/html" pageEncoding="UTF-8"%>

 <!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="style.css" type="text/css"/>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            /* Body Styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                height: 100vh; /* Full viewport height */
                display:flex;
                justify-content: center;
                align-items: center;
                background: url('https://toquoc.mediacdn.vn/280518851207290880/2021/5/12/avatar1620835712801-16208357132931948044466.jpg') no-repeat center center fixed; /* Background image */
                background-size: cover; /* Cover the entire viewport */
            }

            /* Main container for the login form */
            .login-container {
                background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
                padding: 30px;
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Shadow effect */
                width: 350px; /* Fixed width */
                text-align: center; /* Center text */
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
            input[type="email"],
            input[type="password"] {
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
            /* Container to hold the moving text */
        /* Container to hold the moving text */
        .marquee-container {
            width: 100%; /* Full screen width */
            overflow: hidden; /* Hide overflowing content */
            white-space: nowrap; /* Prevent text wrapping */
            position: absolute; /* Position fixed on the screen */
            top: 0; /* Position at the top of the screen */
            background-color: rgba(0, 0, 0, 0.7); /* Background color */
            padding: 10px 0; /* Padding for the container */
            z-index: 1000; /* On top of other content */
            text-align: center; /* Center align text */
        }

        /* Text style and animation */
        .marquee-text {
            font-family: 'Poppins', sans-serif; /* Use Poppins font */
            font-style: italic;
            font-size: 32px; /* Text size */
            color: red; /* Initial color */
            display: inline-block; /* Ensure inline display */
            animation: blink 1s infinite, move 5s linear infinite, colorChange 1.5s infinite; /* Blinking, moving, and color change animations */
        }

        /* Blinking animation */
        @keyframes blink {
            0%, 100% { opacity: 1; } /* Fully visible at start and end */
            50% { opacity: 0; } /* Invisible at midpoint */
        }

        /* Moving text animation */
        @keyframes move {
            0% { transform: translateX(100%); } /* Start from right */
            100% { transform: translateX(-100%); } /* Move completely to the left */
        }

        /* Color change animation */
        @keyframes colorChange {
            
            0% { color: red; }/* Start with red */
            25% { color: yellow; } /* Change to yellow */
            50% { color: orange; } /* Change to green */
            75% { color: white; } /* Change to blue */
            100% { color: red; } /* Back to red */
        }
        </style>
    </head>
    <body>
        <div class="marquee-container">
            <span class="marquee-text">Chào mừng em đến với nhà của bọn anh!</span>
        </div>
        <!-- Login form container -->
        <div class="login-container">
            <h2>Login to Your Account</h2>
            <form action="login" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <!-- Role Selection -->
                <label for="role-option">Login with:</label>
                <select id="role-option" name="Role">
                    <option value="Manager">Manager</option>
                    <option value="Staff">Staff</option>
                    <option value="Student">Student</option>
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
                
                <input type="submit" value="Login">
            </form>

            <!-- Options for Forgot Password and Register -->
            <div class="options-container">
                <button class="forgot-password" onclick="window.location.href = 'forgot.jsp';">Forgot Password?</button>
                <a class="register-btn" href="register.jsp">Register</a>
            </div>
        </div>

    </body>
</html>