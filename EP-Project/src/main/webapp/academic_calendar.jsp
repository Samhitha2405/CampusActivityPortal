<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<html>
<head>
    <title>Academic Calendar</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center; /* Center content horizontally */
            align-items: center; /* Center content vertically */
            height: 100vh; /* Full viewport height */
        }

        #calendar-container {
            width: 70%; /* Adjust the width to make it smaller */
            max-width: 800px; /* Maximum width */
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            display: flex;
            justify-content: center; /* Center the calendar within the container */
            margin-bottom: 20px;
        }

        #calendar {
            width: 100%;
        }

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
            margin-bottom: 20px;
        }

        #home-button {
            background-color: #00ff00; /* Neon green */
            border: none;
            color: #121212; /* Dark text color */
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            box-shadow: 0 0 10px #00ff00; /* Neon glow effect */
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        #home-button:hover {
            background-color: #121212;
            color: #00ff00;
        }
    </style>
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />

    <!-- FullCalendar JS -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                events: <%= getEventsFromDatabase() %> // Function to fetch events from the database
            });

            calendar.render();
        });
    </script>
</head>
<body>
    <div id="calendar-container">
        <div id="calendar"></div>
    </div>
    <button id="home-button" onclick="location.href='home.jsp'">Go to Home</button>
</body>
</html>

<%!
    public String getEventsFromDatabase() {
        String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
        String dbUser = "root";
        String dbPassword = "2005";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        JSONArray eventArray = new JSONArray();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "SELECT * FROM academic_calendar ORDER BY date";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                JSONObject event = new JSONObject();
                event.put("title", resultSet.getString("event"));
                event.put("start", resultSet.getString("date"));
                eventArray.put(event);
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

        return eventArray.toString();
    }
%>
