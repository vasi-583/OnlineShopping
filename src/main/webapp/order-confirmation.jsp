<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.Order" %>
<%@ page import="com.onlineshopping.model.OrderItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmed</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping</div>
        <div><a href="products">Continue Shopping</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <%
            Order order = (Order) request.getAttribute("order");
        %>
        <div class="card">
            <div class="alert alert-success">Payment successful! Your order has been placed.</div>
            <h2>Order #<%= order.getId() %></h2>
            <p style="margin:8px 0; color:#64748b;">Placed on <%= order.getOrderDate() %></p>
            <p style="margin-bottom:16px;">Paid with card ending in <%= order.getCardLastFour() %> (<%= order.getCardHolderName() %>)</p>

            <table>
                <thead><tr><th>Product</th><th>Qty</th><th>Price</th></tr></thead>
                <tbody>
                <% for (OrderItem item : order.getItems()) { %>
                    <tr>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs. <%= item.getPrice() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <div class="total-row">Total Paid: Rs. <%= order.getTotalAmount() %></div>
        </div>
    </div>
</body>
</html>