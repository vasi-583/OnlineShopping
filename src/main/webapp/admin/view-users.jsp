<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Users</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping Admin</div>
        <div><a href="admin-dashboard.jsp">Dashboard</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <h1 class="page-title">Registered Customers</h1>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
        %>
        <div class="card">
            <% if (users == null || users.isEmpty()) { %>
                <div class="empty-msg">No customers registered yet.</div>
            <% } else { %>
            <table>
                <thead><tr><th>ID</th><th>Full Name</th><th>Username</th><th>Email</th></tr></thead>
                <tbody>
                <% for (User u : users) { %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getFullName() %></td>
                        <td><%= u.getUsername() %></td>
                        <td><%= u.getEmail() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </div>
</body>
</html>