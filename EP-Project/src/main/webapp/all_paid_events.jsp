<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>All Paid Events</title>
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

        .event-box {
            margin: 20px;
            padding: 20px;
            border: 1px solid #00ff00;
            border-radius: 10px;
            background-color: #1e1e1e;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            width: 80%;
            margin: 20px auto; /* Center the container */
            text-align: left;
        }

        .event-box h3 {
            margin: 0 0 10px 0;
        }

        .event-box p {
            margin: 0 0 10px 0;
        }

        .event-box form {
            margin-top: 10px;
        }

        .event-box input[type="submit"] {
            background-color: #00ff00; /* Neon green background */
            color: #121212; /* Dark text color */
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .event-box input[type="submit"]:hover {
            background-color: #00cc00; /* Darker green on hover */
            box-shadow: 0 0 10px #00ff00; /* Neon glow effect on hover */
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
    <h2>All Paid Events</h2>

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

            String sql = "SELECT * FROM paid_events ORDER BY date";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String date = resultSet.getString("date");
                String location = resultSet.getString("location");
                double price = resultSet.getDouble("price");

                out.println("<div class='event-box'>");
                out.println("<h3>" + title + "</h3>");
                out.println("<p><strong>Date:</strong> " + date + "</p>");
                out.println("<p><strong>Location:</strong> " + location + "</p>");
                
                out.println("<p><strong>Price:</strong> Rs." + price + "</p>");
                out.println("<form action='payment.jsp' method='get'>");
                out.println("<input type='hidden' name='event_id' value='" + id + "'/>");
                out.println("<input type='hidden' name='price' value='" + price + "'/>");
                out.println("<input type='submit' value='Register'/>");
                out.println("</form>");
                out.println("</div>");
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
</body>
</html>
