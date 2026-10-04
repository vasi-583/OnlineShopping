<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.CartItem" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping</div>
        <div>
            <a href="products">Continue Shopping</a>
            <a href="logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <h1 class="page-title">Your Cart</h1>

        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) request.getAttribute("cart");
        %>
        <% if (cart == null || cart.isEmpty()) { %>
            <div class="card empty-msg">
                Your cart is empty. <a href="products">Browse products</a>
            </div>
        <% } else { %>
        <div class="card">
            <table>
                <thead>
                    <tr><th>Product</th><th>Price</th><th>Quantity</th><th>Subtotal</th><th></th></tr>
                </thead>
                <tbody>
                <% for (CartItem item : cart.values()) { %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td>Rs. <%= item.getProduct().getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs. <%= item.getSubtotal() %></td>
                        <td><a href="removeFromCart?productId=<%= item.getProduct().getId() %>" class="btn btn-danger">Remove</a></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <div class="total-row">Total: Rs. <%= request.getAttribute("total") %></div>
            <div style="text-align:right;">
                <a href="checkout" class="btn">Proceed to Checkout</a>
            </div>
        </div>
        <% } %>
    </div>
</body>
</html>