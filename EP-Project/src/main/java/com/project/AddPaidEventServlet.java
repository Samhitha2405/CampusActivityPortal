package com.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addPaidEvent")
public class AddPaidEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String price = request.getParameter("price");

        String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
        String dbUser = "root";
        String dbPassword = "2005";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
                String sql = "INSERT INTO paid_events (title, date, location, price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, title);
                    statement.setString(2, date);
                    statement.setString(3, location);
                    statement.setDouble(4, Double.parseDouble(price));

                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                        request.setAttribute("message", "Event added successfully!");
                    } else {
                        request.setAttribute("error", "Failed to add event. Please try again.");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("error", "Error adding event: " + e.getMessage());
        }

        request.getRequestDispatcher("/add_paid_events.jsp").forward(request, response);
    }
}
