<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.Order" %>
<%@ page import="com.onlineshopping.model.OrderItem" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Orders</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping Admin</div>
        <div><a href="admin-dashboard.jsp">Dashboard</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <h1 class="page-title">All Orders</h1>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
        %>
        <% if (orders == null || orders.isEmpty()) { %>
            <div class="card empty-msg">No orders placed yet.</div>
        <% } else { %>
            <% for (Order o : orders) { %>
                <div class="card" style="margin-bottom:16px;">
                    <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
                        <div>
                            <strong>Order #<%= o.getId() %></strong> — <%= o.getUsername() %>
                            <div style="font-size:12px; color:#64748b;"><%= o.getOrderDate() %></div>
                        </div>
                        <div style="text-align:right;">
                            <div><strong>Rs. <%= o.getTotalAmount() %></strong></div>
                            <div style="font-size:12px; color:#16a34a;"><%= o.getPaymentStatus() %></div>
                        </div>
                    </div>
                    <table>
                        <thead><tr><th>Product</th><th>Qty</th><th>Price</th></tr></thead>
                        <tbody>
                        <% for (OrderItem item : o.getItems()) { %>
                            <tr>
                                <td><%= item.getProductName() %></td>
                                <td><%= item.getQuantity() %></td>
                                <td>Rs. <%= item.getPrice() %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        <% } %>
    </div>
</body>
</html>