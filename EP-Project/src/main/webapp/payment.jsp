<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.WriterException" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="java.awt.Color" %>
<%@ page import="java.util.Base64" %>
<html>
<head>
    <title>Payment Page</title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .container {
            padding: 20px;
            border-radius: 10px;
            background-color: #1e1e1e; /* Slightly lighter dark background */
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.5); /* Neon green shadow */
            width: 300px;
        }
        h2 {
            color: #00ff00; /* Neon green color */
            text-shadow: 0 0 10px #00ff00; /* Neon glow effect */
        }
        .qr-code img {
            width: 200px;
            height: 200px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Payment</h2>
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/ep_project";
            String dbUser = "root";
            String dbPassword = "2005";
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            int eventId = Integer.parseInt(request.getParameter("event_id"));
            double price = Double.parseDouble(request.getParameter("price"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                String sql = "SELECT * FROM paid_events WHERE id = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, eventId);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    String title = resultSet.getString("title");
                    
                    String date = resultSet.getString("date");
                    String location = resultSet.getString("location");

                    out.println("<p><strong>Title:</strong> " + title + "</p>");
                    out.println("<p><strong>Date:</strong> " + date + "</p>");
                    out.println("<p><strong>Location:</strong> " + location + "</p>");
                   

                    try {
                        QRCodeWriter qrCodeWriter = new QRCodeWriter();
                        BitMatrix bitMatrix = qrCodeWriter.encode("Event ID: " + eventId + ", Price: " + price, BarcodeFormat.QR_CODE, 200, 200);
                        BufferedImage bufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_INT_RGB);
                        for (int x = 0; x < 200; x++) {
                            for (int y = 0; y < 200; y++) {
                                bufferedImage.setRGB(x, y, bitMatrix.get(x, y) ? Color.BLACK.getRGB() : Color.WHITE.getRGB());
                            }
                        }

                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        ImageIO.write(bufferedImage, "png", baos);
                        byte[] qrCodeBytes = baos.toByteArray();
                        String qrCodeBase64 = Base64.getEncoder().encodeToString(qrCodeBytes);
                        %>
                        <div class="qr-code">
                            <img src="data:image/png;base64,<%= qrCodeBase64 %>" alt="QR Code"/>
                        </div>
                        <p>Scan the QR code to complete your payment of $<%= price %> for Event ID: <%= eventId %></p>
                        <p><a href="all_paid_events.jsp">Back to Events</a></p>
                        <%
                    } catch (WriterException | IOException e) {
                        out.println("<p>Error generating QR Code: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>Event not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    out.println("<p>Database connection error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
