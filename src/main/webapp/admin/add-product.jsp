<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping Admin</div>
        <div><a href="admin-dashboard.jsp">Dashboard</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <div class="form-box">
            <h2>Add New Product</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="addProduct" method="post">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="number" step="0.01" name="price" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <input type="text" name="category">
                </div>
                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" name="quantity" required>
                </div>
                <div class="form-group">
                    <label>Image filename (e.g. product.jpg)</label>
                    <input type="text" name="imagePath">
                </div>
                <button type="submit" class="btn btn-full">Add Product</button>
            </form>
        </div>
    </div>
</body>
</html>