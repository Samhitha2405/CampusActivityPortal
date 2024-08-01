<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>All Exam Schedules</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
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

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #1e1e1e;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
        }

        th, td {
            padding: 10px;
            border: 1px solid #00ff00; /* Neon green border */
        }

        th {
            background-color: #2a2a2a;
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        td {
            color: #e0e0e0; /* Light text color */
        }

        a {
            color: #00ff00; /* Neon green color */
            text-decoration: none;
        }

        a:hover {
            color: #00cc00; /* Darker green on hover */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="left">
            <span>CAP</span>
        </div>
        <div class="right">
            <a href="home.jsp">Back to Home</a>
        </div>
    </div>
    <h2>All Exam Schedules</h2>

    <table>
        <thead>
            <tr>
                <th>Subject</th>
                <th>Date</th>
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
                String dbUser = "root";
                String dbPassword = "2005";
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String sql = "SELECT * FROM exam_schedules ORDER BY exam_date";
                    statement = connection.prepareStatement(sql);
                    resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        String subject = resultSet.getString("subject");
                        String examDate = resultSet.getString("exam_date");
                        String location = resultSet.getString("location");

                        out.println("<tr>");
                        out.println("<td>" + subject + "</td>");
                        out.println("<td>" + examDate + "</td>");
                        out.println("<td>" + location + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
