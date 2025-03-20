<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.StudentsDAO" %>
<%@page import = "model.Students" %>
<%@page import = "model.PaymentsDAO" %>
<%@page import = "model.Payments" %>
<%@page import = "java.sql.Date" %>
<%@page import = "java.util.*" %>
<%
    HttpSession studentSession = request.getSession(false);
    Students s = (Students) studentSession.getAttribute("student");
    String paymentID = request.getParameter("paymentID");
    String paymentMethod = request.getParameter("paymentMethod");
    PaymentsDAO p = new PaymentsDAO();
    Payments x = p.getPayment(paymentID);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Payment</title>
        <style>
            /* Basic Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body Styles */
            body {
                font-family: 'Arial', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background: linear-gradient(135deg, #fce3e3, #f7f2c9); /* Soft pastel gradient background */
                background-attachment: fixed;
            }

            /* Main Container */
            .payment-container {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
                border: 2px solid #f7a8a8; /* Floral-themed border */
                position: relative;
                overflow: hidden;
            }

            /* Decorative Flowers */
            .payment-container::before,
            .payment-container::after {
                content: '🌸';
                position: absolute;
                font-size: 50px;
                color: rgba(250, 188, 188, 0.4); /* Soft floral color */
            }
            .payment-container::before {
                top: -20px;
                left: -20px;
            }
            .payment-container::after {
                bottom: -20px;
                right: -20px;
            }

            /* Title Styles */
            h2 {
                color: #333;
                font-size: 18px;
                margin-bottom: 15px;
                font-weight: 500;
            }

            /* Amount Highlight */
            .amount {
                font-size: 24px;
                color: #d57272;
                font-weight: bold;
                margin: 10px 0;
            }

            /* Input Fields and Buttons */
            input[type="paymentMethod"],
            input[type="submit"],
            button {
                width: 100%;
                padding: 12px;
                margin-top: 10px;
                border-radius: 8px;
                border: 1px solid #d3a8a8;
                font-size: 16px;
            }

            input[type="paymentMethod"] {
                font-size: 14px;
                color: #333;
                background-color: #fff8f8; /* Light floral background */
            }

            /* Submit Button Styling */
            input[type="submit"] {
                background-color: #d57272;
                color: #fff;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            input[type="submit"]:hover {
                background-color: #b85a5a;
            }

            /* Back Button Styling */
            button {
                background-color: #e5e5e5;
                border: none;
                color: #333;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            button:hover {
                background-color: #dcdcdc;
            }

            /* QR Code Placeholder */
            .qr-placeholder {
                margin: 20px 0;
                height: 150px;
                background-color: #fff8f8;
                border: 2px dashed #f4c2c2;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                color: #b2a8a8;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>
        <div class="payment-container">
            <h2>Payment ID: <%= paymentID %> </h2>
            <h2>Room: <%= x.getRoomID() %> </h2>
            <h2>Service ID: 
                <% if(x.getAssignmentID()==null){ %>
                <%= x.getUsageID() %>
                <% } else{ %>
                <%= x.getAssignmentID() %>
                <% } %></h2>
            <h2 class="amount">Amount: <%= x.getAmount() %> VNĐ</h2>
            <h2>Payment Deadline: <%= x.getPaymentDeadLine() %> </h2>
            <h2>Status: <%= x.getStatus() %> </h2>
            <% if(paymentMethod==null){ %>
            <form action="finishPayment.jsp" method="post">
                <input type="hidden" name="paymentID" value="<%= x.getPaymentID() %>">
                Payment Method:<input type="paymentMethod" name="paymentMethod" required=>
                <input type="submit" value="Confirm">
            </form>
            <button onclick="window.location.href = 'studentPayment.jsp';">Turn Back</button>
            <% } else { %>
            <div class="qr-placeholder">
                <img src="https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=<%= x.getPaymentID() %>" alt="QR Code">
            </div>
            <form action="finishPayment" method="post">
                <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">
                <input type="hidden" name="paymentID" value="<%= x.getPaymentID() %>">
                <input type="submit" value="Confirm">   
            </form>
            <% } %>
    </body>
</html>
