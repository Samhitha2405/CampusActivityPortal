<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LoginApp</title>
    <style>
        body {
             background: linear-gradient(rgba(18, 18, 18, 0.7), rgba(18, 18, 18, 0.7)), 
                        url('https://blogger.googleusercontent.com/img/a/AVvXsEhvpB5x5Nsv25xqB9V5-SMs8eVssu1LUUKazSpMv_wUAUIMJBSt2Yu-7YvPckT5TmYCSktxw2if7Bj0TvKjKl0ZN9m2FZzmMQsJPCWvSabZ9qo3XbCo8BKTPjLDaZJvd-DIZgNjV8vkV6WNUfGgLmaNIwSpqrGRQkYH7-JHXqs1a_S5-RqJ2ppWy0DhcO8U') no-repeat center center fixed;
            background-size: cover;
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
        }

        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
            margin: 0 0 20px 0;
        }

        a {
            color: #ff00ff; /* Neon pink color */
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
            padding: 10px;
            border: 2px solid #ff00ff; /* Neon pink border */
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        a:hover {
            background-color: #ff00ff; /* Neon pink background on hover */
            color: #121212; /* Dark text color on hover */
            text-shadow: 0 0 10px #ff00ff; /* Neon glow effect on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to CAP</h2>
        <a href="login.jsp">Login</a> | <a href="signup.jsp">Signup</a>
    </div>
</body>
</html>
