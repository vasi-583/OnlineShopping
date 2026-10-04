<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.CartItem" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping</div>
        <div><a href="cart">Back to Cart</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <h1 class="page-title">Order Summary</h1>
        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) request.getAttribute("cart");
        %>
        <div class="card">
            <table>
                <thead><tr><th>Product</th><th>Qty</th><th>Subtotal</th></tr></thead>
                <tbody>
                <% for (CartItem item : cart.values()) { %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs. <%= item.getSubtotal() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <div class="total-row">Total: Rs. <%= request.getAttribute("total") %></div>
            <div style="text-align:right;">
                <a href="payment.jsp" class="btn">Proceed to Payment</a>
            </div>
        </div>
    </div>
</body>
</html>