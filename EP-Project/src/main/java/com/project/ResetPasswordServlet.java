package com.project;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/reset_password")
public class ResetPasswordServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String username = (String) request.getSession().getAttribute("forgotPasswordUsername");

        if (username != null && newPassword != null) {
            try {
                // Load the MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to the database
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ep_project", "root", "2005");

                // Update the user's password in the database
                String sql = "UPDATE users SET password = ? WHERE username = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, newPassword);
                statement.setString(2, username);
                statement.executeUpdate();

                // Close the connection
                statement.close();
                connection.close();

                // Redirect to the login page with a success message
                response.sendRedirect("login.jsp?message=Password+reset+successfully");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("reset_password.jsp?error=An+error+occurred");
            }
        } else {
            response.sendRedirect("reset_password.jsp?error=Invalid+request");
        }
    }
}
