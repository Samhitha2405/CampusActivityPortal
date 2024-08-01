<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>My Events</title>
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

        .box p {
            color: #e0e0e0; /* Light text color */
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
        <h2>My Events</h2>
        <div class="box">
            <%
                javax.servlet.http.HttpSession ses = request.getSession(false);
                String username = (ses != null && ses.getAttribute("username") != null)
                                    ? (String) ses.getAttribute("username")
                                    : "Guest";

                if (!username.equals("Guest")) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
                    String dbUser = "root";
                    String dbPassword = "2005";
                    Connection connection = null;
                    PreparedStatement statement = null;
                    ResultSet resultSet = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        String sql = "SELECT e.title, e.date, e.location FROM events e " +
                                     "JOIN event_registrations er ON e.id = er.event_id " +
                                     "WHERE er.username = ?";
                        statement = connection.prepareStatement(sql);
                        statement.setString(1, username);
                        resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            String title = resultSet.getString("title");
                            String date = resultSet.getString("date");
                            String location = resultSet.getString("location");

                            out.println("<p><strong>" + title + "</strong> - " + date + "<br>");
                            out.println("<span><strong>Location:</strong> " + location + "</span></p>");
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
                } else {
                    out.println("<p>You must be logged in to view your events.</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
