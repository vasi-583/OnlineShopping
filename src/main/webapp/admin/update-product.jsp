<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping Admin</div>
        <div><a href="admin-dashboard.jsp">Dashboard</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <%
            Product product = (Product) request.getAttribute("product");
        %>
        <div class="form-box">
            <h2>Update Product</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="updateProduct" method="post">
                <input type="hidden" name="id" value="<%= product.getId() %>">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" value="<%= product.getName() %>" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"><%= product.getDescription() %></textarea>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <input type="text" name="category" value="<%= product.getCategory() %>">
                </div>
                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" name="quantity" value="<%= product.getQuantity() %>" required>
                </div>
                <div class="form-group">
                    <label>Image filename</label>
                    <input type="text" name="imagePath" value="<%= product.getImagePath() %>">
                </div>
                <button type="submit" class="btn btn-full">Update Product</button>
            </form>
        </div>
    </div>
</body>
</html>