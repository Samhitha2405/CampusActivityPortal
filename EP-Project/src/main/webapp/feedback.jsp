<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<html>
<head>
    <title>Feedback</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333; /* Dark background for navbar */
            padding: 10px;
            color: #e0e0e0; /* Light text color */
            box-shadow: 0 0 10px rgba(0, 255, 0, 0.5); /* Neon green shadow */
        }

        .navbar .left {
            margin-left: 20px;
            color: #00ff00; /* Neon green color */
            font-size: 24px;
        }

        .navbar .right {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: #ff00ff; /* Neon pink color */
            text-decoration: none;
            padding: 0 10px;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #ff66ff; /* Lighter pink on hover */
            text-shadow: 0 0 10px #ff00ff; /* Neon glow effect */
        }

        .content {
            padding: 20px;
            overflow-y: auto;
        }

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        .box {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #00ff00;
            border-radius: 10px;
            background-color: #1e1e1e;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            width: 80%;
            margin: 20px auto; /* Center the container */
            text-align: left;
        }

        .box h2 {
            margin: 0 0 10px 0;
        }

        .box form {
            display: flex;
            flex-direction: column;
        }

        .box input[type="text"], .box textarea {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #00ff00;
            border-radius: 5px;
            background-color: #333;
            color: #e0e0e0;
        }

        .box input[type="submit"] {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #00ff00;
            color: #121212;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .box input[type="submit"]:hover {
            background-color: #00cc00;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="left">
            <span>CAP</span>
        </div>
        <div class="right">
            <a href="home.jsp">Home</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <div class="content">
        <h2>Feedback</h2>
        <div class="box">
            <form method="post" action="feedback.jsp">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required>
                
                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="4" required></textarea>
                
                <input type="submit" value="Submit">
            </form>
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
                    String dbUser = "root";
                    String dbPassword = "2005";
                    Connection connection = null;
                    PreparedStatement statement = null;

                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String message = request.getParameter("message");

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        String sql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";
                        statement = connection.prepareStatement(sql);
                        statement.setString(1, name);
                        statement.setString(2, email);
                        statement.setString(3, message);
                        int rows = statement.executeUpdate();

                        if (rows > 0) {
                            out.println("<p>Thank you for your feedback!</p>");
                        } else {
                            out.println("<p>Failed to submit feedback.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
