package com.onlineshopping.dao;

import com.onlineshopping.model.CartItem;
import com.onlineshopping.model.Order;
import com.onlineshopping.model.OrderItem;
import com.onlineshopping.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Creates the order + order_items in a single transaction and returns the new order id (-1 on failure)
    public int placeOrder(int userId, List<CartItem> cartItems, BigDecimal totalAmount,
                           String cardHolderName, String cardLastFour) {

        String orderSql = "INSERT INTO orders (user_id, total_amount, card_holder_name, card_last_four, payment_status) VALUES (?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) VALUES (?, ?, ?, ?, ?)";

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setBigDecimal(2, totalAmount);
                ps.setString(3, cardHolderName);
                ps.setString(4, cardLastFour);
                ps.setString(5, "SUCCESS");
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) orderId = keys.getInt(1);
                }
            }

            try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                for (CartItem item : cartItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getProduct().getId());
                    ps.setString(3, item.getProduct().getName());
                    ps.setInt(4, item.getQuantity());
                    ps.setBigDecimal(5, item.getProduct().getPrice());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit();
            return orderId;

        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return -1;
        } finally {
            if (con != null) {
                try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    // Admin: view all orders (with items) across all customers
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = mapRow(rs);
                o.setItems(getItemsForOrder(o.getId()));
                orders.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Single order (used for the order confirmation page)
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = mapRow(rs);
                    o.setItems(getItemsForOrder(orderId));
                    return o;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private List<OrderItem> getItemsForOrder(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem oi = new OrderItem();
                    oi.setId(rs.getInt("id"));
                    oi.setOrderId(rs.getInt("order_id"));
                    oi.setProductId(rs.getInt("product_id"));
                    oi.setProductName(rs.getString("product_name"));
                    oi.setQuantity(rs.getInt("quantity"));
                    oi.setPrice(rs.getBigDecimal("price"));
                    items.add(oi);
                }
            }
        }
        return items;
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setUsername(rs.getString("username"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setCardHolderName(rs.getString("card_holder_name"));
        o.setCardLastFour(rs.getString("card_last_four"));
        o.setPaymentStatus(rs.getString("payment_status"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        return o;
    }
}