<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Paid Events</title>
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .navbar {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            padding: 10px;
            color: #e0e0e0;
            box-shadow: 0 0 10px rgba(0, 255, 0, 0.5);
        }

        .navbar .left {
            display: flex;
            align-items: center;
            margin-left: 20px;
            color: #00ff00;
            font-size: 24px;
        }

        .navbar .hamburger {
            display: block;
            font-size: 24px;
            cursor: pointer;
            margin-right: 20px;
            color: #00ff00;
        }

        .navbar .right {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: #ff00ff;
            text-decoration: none;
            padding: 0 10px;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #ff66ff;
            text-shadow: 0 0 10px #ff00ff;
        }

        .sidebar {
            width: 200px;
            background-color: #1e1e1e;
            padding: 20px;
            height: 100vh;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5);
            position: fixed;
            top: 0;
            left: -200px;
            transition: left 0.3s ease;
            z-index: 1000;
        }

        .sidebar h3 {
            color: #00ff00;
            text-shadow: 0 0 10px #00ff00;
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
            color: #00ff00;
            text-shadow: 0 0 10px #00ff00;
        }

        .sidebar.active {
            left: 0;
        }

        .content {
            padding: 20px;
            overflow-y: auto;
            margin-left: 0;
            transition: margin-left 0.3s ease;
            text-align: center;
        }

        h2, p {
            margin: 20px 0;
        }

        h2 {
            color: #00ff00;
            text-shadow: 0 0 10px #00ff00;
        }

        .box {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #00ff00;
            border-radius: 10px;
            background-color: #1e1e1e;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5);
            width: 80%;
            margin: 20px auto;
            text-align: left;
        }

        .box h2 {
            margin: 0 0 10px 0;
        }

        .box a {
            color: #00ff00;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .box a:hover {
            color: #00cc00;
            text-shadow: 0 0 10px #00ff00;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #00ff00;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #333;
            color: #00ff00;
        }

        td {
            background-color: #1e1e1e;
            color: #e0e0e0;
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
        <h2>Paid Events</h2>
        <div class="box">
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

                    // Fetching the next 5 paid events
                    String sql = "SELECT * FROM events WHERE is_paid = 1 ORDER BY date LIMIT 5";
                    statement = connection.prepareStatement(sql);
                    resultSet = statement.executeQuery();

                    out.println("<table>");
                    out.println("<tr><th>Title</th><th>Date</th><th>Location</th><th>Price</th></tr>");
                    while (resultSet.next()) {
                        String title = resultSet.getString("title");
                        String date = resultSet.getString("date");
                        String location = resultSet.getString("location");
                        double price = resultSet.getDouble("price");

                        out.println("<tr><td>" + title + "</td><td>" + date + "</td><td>" + location + "</td><td>$" + price + "</td></tr>");
                    }
                    out.println("</table>");
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
            <a href="all_paid_events.jsp" class="arrow">→ View All Paid Events</a>
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
