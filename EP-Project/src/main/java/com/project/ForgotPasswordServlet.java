package com.project;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot_password")
public class ForgotPasswordServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        // Here you can validate the username, e.g., check if it exists in the database
        // Assuming validation is successful, set the username as a session attribute
        request.getSession().setAttribute("forgotPasswordUsername", username);

        // Redirect to the reset_password.jsp page
        response.sendRedirect("reset_password.jsp");
    }
}
