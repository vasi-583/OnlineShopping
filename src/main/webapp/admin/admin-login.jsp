<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="form-box">
        <h2>Admin Login</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="<%= request.getContextPath() %>/adminLogin" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-full">Login</button>
        </form>
        <p style="margin-top:14px; text-align:center; font-size:13px; color:#94a3b8;">
            Default: admin / admin123
        </p>
        <p> 
        <p style= "margin-top:10px; text-align:center; font-size:13px; color:#94a3b8;">
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn-secondary btn-full">Customer Login</a>
        </p>
    </div>
</body>
</html>