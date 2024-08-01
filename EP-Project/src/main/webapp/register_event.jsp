<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <title>Register Event</title>
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

        p {
            color: #e0e0e0; /* Light text color for paragraph */
        }

        .message {
            margin: 20px;
            padding: 20px;
            border: 1px solid #00ff00;
            border-radius: 10px;
            background-color: #1e1e1e;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            width: 80%;
            margin: 20px auto; /* Center the container */
        }

        a {
            color: #00ff00; /* Neon green color */
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
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
            <%
                javax.servlet.http.HttpSession ses = request.getSession(false);
                String username = (ses != null && ses.getAttribute("username") != null)
                                    ? (String) ses.getAttribute("username")
                                    : "Guest";
            %>
            <span>Welcome, <%= username %></span>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
    <div class="message">
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
            String dbUser = "root";
            String dbPassword = "2005";
            Connection connection = null;
            PreparedStatement statement = null;

            String eventId = request.getParameter("event_id");

            if (!username.equals("Guest") && eventId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String sql = "INSERT INTO event_registrations (event_id, username) VALUES (?, ?)";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, Integer.parseInt(eventId));
                    statement.setString(2, username);
                    int rows = statement.executeUpdate();

                    if (rows > 0) {
                        out.println("<p>You have successfully registered for the event.</p>");
                    } else {
                        out.println("<p>Failed to register for the event.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>You must be logged in to register for an event.</p>");
            }
        %>
        <a href="home.jsp">Back to Home</a>
    </div>
</body>
</html>