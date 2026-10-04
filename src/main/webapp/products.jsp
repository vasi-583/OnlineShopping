<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping</div>
        <div>
            <span style="margin-right:10px;">Hi, <%= session.getAttribute("username") %></span>
            <a href="cart">Cart</a>
            <a href="logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <h1 class="page-title">Available Products</h1>

        <% if ("1".equals(request.getParameter("added"))) { %>
            <div class="alert alert-success">Item added to cart!</div>
        <% } %>

        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
        %>
        <% if (products == null || products.isEmpty()) { %>
            <div class="empty-msg">No products available right now.</div>
        <% } else { %>
        <div class="product-grid">
            <% for (Product p : products) { %>
                <div class="product-card">
                    <span class="cat-tag"><%= p.getCategory() %></span>
                    <img src="<%= p.getImagePath() %>" alt="<%= p.getName() %>" class="product-img"
     onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                    <h3><%= p.getName() %></h3>
                    <div class="desc"><%= p.getDescription() %></div>
                    <div class="price">Rs. <%= p.getPrice() %></div>
                    <div style="font-size:12px; color:#64748b; margin-bottom:10px;">
                        <%= p.getQuantity() > 0 ? p.getQuantity() + " in stock" : "Out of stock" %>
                    </div>
                    <% if (p.getQuantity() > 0) { %>
                        <form action="addToCart" method="get">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= p.getQuantity() %>"
                                   style="width:60px; padding:6px; margin-bottom:8px;">
                            <button type="submit" class="btn btn-full">Add to Cart</button>
                        </form>
                    <% } else { %>
                        <button class="btn btn-full" disabled style="background:#cbd5e1;">Out of Stock</button>
                    <% } %>
                </div>
            <% } %>
        </div>
        <% } %>
    </div>
</body>
</html>