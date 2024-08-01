<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Invalidate the session
    HttpSession ses = request.getSession(false);
    if (ses != null) {
        ses.invalidate();
    }
    // Redirect to login page
    response.sendRedirect("login.jsp");
%>
