<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping Admin</div>
        <div><a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <h1 class="page-title">Admin Dashboard</h1>

        <% String msg = request.getParameter("msg");
           if (msg != null) { %>
            <div class="alert alert-success">
                <% if (msg.equals("added")) { %>Product added successfully.
                <% } else if (msg.equals("updated")) { %>Product updated successfully.
                <% } else if (msg.equals("deleted")) { %>Product deleted successfully.
                <% } %>
            </div>
        <% } %>

        <div class="dashboard-links">
            <a href="addProduct" class="btn">+ Add Product</a>
            <a href="viewUsers" class="btn btn-secondary">View Users</a>
            <a href="viewOrders" class="btn btn-secondary">View Orders</a>
        </div>

        <%@ include file="product-list.jspf" %>
    </div>
</body>
</html>