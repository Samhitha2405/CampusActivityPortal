<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Home</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* Prevent horizontal scrolling */
        }

        .navbar {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333; /* Dark background for navbar */
            padding: 10px;
            color: #e0e0e0; /* Light text color */
            box-shadow: 0 0 10px rgba(0, 255, 0, 0.5); /* Neon green shadow */
        }

        .navbar .left {
            display: flex;
            align-items: center;
            margin-left: 20px;
            color: #00ff00; /* Neon green color */
            font-size: 24px;
        }

        .navbar .hamburger {
            display: block;
            font-size: 24px;
            cursor: pointer;
            margin-right: 20px;
            color: #00ff00; /* Neon green color */
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

        .sidebar {
            width: 200px;
            background-color: #1e1e1e;
            padding: 20px;
            height: 100vh;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            position: fixed;
            top: 0;
            left: -200px; /* Hide sidebar initially */
            transition: left 0.3s ease;
            z-index: 1000; /* Ensure it stays above other elements */
        }

        .sidebar h3 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
            margin-bottom: 20px;
        }

        .sidebar a {
            display: block;
            color: #e0e0e0;
            text-decoration: none;
            padding: 10px 0;
            transition: color 0.3s ease;
        }

        .sidebar a:hover {
            color: #00ff00; /* Neon green on hover */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        .sidebar.active {
            left: 0; /* Show sidebar */
        }
        .content {
            padding: 20px;
            overflow-y: auto;
            margin-left: 0; /* No margin when sidebar is hidden */
            transition: margin-left 0.3s ease;
            text-align: center; /* Center text inside content */
        }

        h2, p {
            margin: 20px 0;
        }

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        .content.shifted {
            margin-left: 200px; /* Space for sidebar */
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

        .box a {
            color: #00ff00; /* Neon green color */
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .box a:hover {
            color: #00cc00; /* Darker green on hover */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }

        .arrow {
            font-size: 24px;
            color: #00ff00;
            text-shadow: 0 0 10px #00ff00;
        }

        @media screen and (max-width: 768px) {
            .content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="left">
            <span class="hamburger" onclick="toggleSidebar()">☰</span>
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

    <div class="sidebar" id="sidebar">
        <h3>Menu</h3>
        <a href="my_events.jsp">My Events</a>
        <a href="feedback.jsp">Feedback</a>
        <a href="academic_calendar.jsp">Academic Calendar</a>
        <a href="paid_events.jsp">Paid Events</a>
    </div>

    <div class="content" id="content">
        <h2>Welcome to the Campus Activity Portal</h2>
        <p>You have successfully logged in!</p>

        <div class="box">
            <h2>Upcoming Events</h2>
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

                    // Fetching the next 5 upcoming events
                    String sql = "SELECT * FROM events ORDER BY date LIMIT 5";
                    statement = connection.prepareStatement(sql);
                    resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
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
            %>
            <br>
            <a href="view_events.jsp" class="arrow">→ View All Events</a>
        </div>

        <div class="box">
            <h2>View Exam Schedules</h2>
            <%
                String jdbcURL2 = "jdbc:mysql://localhost:3306/ep_project";
                String dbUser2 = "root";
                String dbPassword2 = "2005";
                Connection connection2 = null;
                PreparedStatement statement2 = null;
                ResultSet resultSet2 = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection2 = DriverManager.getConnection(jdbcURL2, dbUser2, dbPassword2);

                    // Fetching the next 5 upcoming exams
                    String sql2 = "SELECT * FROM exam_schedules ORDER BY exam_date LIMIT 5";
                    statement2 = connection2.prepareStatement(sql2);
                    resultSet2 = statement2.executeQuery();

                    out.println("<table>");
                    out.println("<tr><th>Subject</th><th>Date</th><th>Location</th></tr>");
                    while (resultSet2.next()) {
                        int id = resultSet2.getInt("id");
                        String subject = resultSet2.getString("subject");
                        String examDate = resultSet2.getString("exam_date");
                        String location = resultSet2.getString("location");

                        out.println("<tr><td>" + subject + "</td><td>" + examDate + "</td><td>" + location + "</td></tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet2 != null) resultSet2.close();
                        if (statement2 != null) statement2.close();
                        if (connection2 != null) connection2.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            <br>
            <a href="all_exams.jsp" class="arrow">→ View All Exam Schedules</a>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.getElementById('content');
            const isActive = sidebar.classList.contains('active');
            sidebar.classList.toggle('active');
            content.classList.toggle('shifted', !isActive);

            // Add event listener to close sidebar when clicking outside
            if (!isActive) {
                document.addEventListener('click', outsideClickListener);
            }
        }

        function outsideClickListener(event) {
            const sidebar = document.getElementById('sidebar');
            const content = document.getElementById('content');
            if (!sidebar.contains(event.target) && !document.querySelector('.hamburger').contains(event.target)) {
                sidebar.classList.remove('active');
                content.classList.remove('shifted');
                document.removeEventListener('click', outsideClickListener);
            }
        }
    </script>
</body>
</html>
