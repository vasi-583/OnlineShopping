<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.onlineshopping.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="brand">Online Shopping</div>
        <div><a href="checkout">Back</a> <a href="logout">Logout</a></div>
    </div>
    <div class="container">
        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            BigDecimal total = BigDecimal.ZERO;
            if (cart != null) {
                for (CartItem item : cart.values()) {
                    total = total.add(item.getSubtotal());
                }
            }
        %>
        <div class="form-box" style="margin-top:20px;">
            <h2>Payment Details</h2>
            <div class="total-row" style="text-align:left;">Amount to pay: Rs. <%= total %></div>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="payment" method="post">
                <div class="form-group">
                    <label>Cardholder Name</label>
                    <input type="text" name="cardHolderName" required>
                </div>
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" name="cardNumber" maxlength="19" placeholder="1234 5678 9012 3456" required>
                </div>
                <div style="display:flex; gap:12px;">
                    <div class="form-group" style="flex:1;">
                        <label>Expiry (MM/YY)</label>
                        <input type="text" name="expiry" placeholder="MM/YY" required>
                    </div>
                    <div class="form-group" style="flex:1;">
                        <label>CVV</label>
                        <input type="password" name="cvv" maxlength="4" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-full">Pay Now</button>
            </form>
            <p style="margin-top:10px; font-size:12px; color:#94a3b8;">
                This is a simulated payment for demo purposes. No real transaction occurs.
            </p>
        </div>
    </div>
</body>
</html>