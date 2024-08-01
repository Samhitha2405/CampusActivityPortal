<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Paid Event</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color for contrast */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            text-align: center;
        }

        .container {
            padding: 20px;
            border-radius: 10px;
            background-color: #1e1e1e; /* Slightly lighter dark background */
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            width: 300px; /* Fixed width for the form container */
        }

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
            margin: 0 0 20px 0;
        }

        label {
            display: block;
            color: #e0e0e0;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #00ff00; /* Neon green border */
            border-radius: 5px;
            background-color: #1e1e1e; /* Same background as container */
            color: #e0e0e0;
            box-sizing: border-box; /* Include padding and border in element's total width and height */
        }

        input[type="submit"] {
            background-color: #00ff00; /* Neon green background */
            color: #121212; /* Dark text color */
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #00cc00; /* Darker green on hover */
            box-shadow: 0 0 10px #00ff00; /* Neon glow effect on hover */
        }

        .message {
            color: #00ff00;
            margin-top: 20px;
        }

        .error {
            color: #ff0000;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Paid Event</h2>
        <form action="addPaidEvent" method="post">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required/>

            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required/>

            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required/>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" required/>

            <input type="submit" value="Add Event"/>
        </form>
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<p class='message'>" + message + "</p>");
            }
            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.println("<p class='error'>" + error + "</p>");
            }
        %>
    </div>
</body>
</html>
