package com.onlineshopping.controller;

import com.onlineshopping.dao.OrderDAO;
import com.onlineshopping.dao.ProductDAO;
import com.onlineshopping.model.CartItem;
import com.onlineshopping.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Map;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.isEmpty() || user == null) {
            resp.sendRedirect("cart");
            return;
        }

        String cardNumber = req.getParameter("cardNumber");
        String cvv = req.getParameter("cvv");
        String expiry = req.getParameter("expiry");
        String cardHolderName = req.getParameter("cardHolderName");

        // ---- Basic payment field validation (this is a simulated payment, no real gateway) ----
        String digitsOnly = cardNumber == null ? "" : cardNumber.replaceAll("\\s+", "");
        if (digitsOnly.length() < 12 || digitsOnly.length() > 19 || !digitsOnly.matches("\\d+")) {
            req.setAttribute("error", "Please enter a valid card number.");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }
        if (cvv == null || !cvv.matches("\\d{3,4}")) {
            req.setAttribute("error", "Please enter a valid CVV.");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }
        if (expiry == null || expiry.trim().isEmpty()) {
            req.setAttribute("error", "Please enter the card expiry date.");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }
        if (cardHolderName == null || cardHolderName.trim().isEmpty()) {
            req.setAttribute("error", "Please enter the cardholder name.");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            total = total.add(item.getSubtotal());
        }

        // Never persist the full card number or CVV - only the last 4 digits are stored, for the order record.
        String lastFour = digitsOnly.substring(digitsOnly.length() - 4);

        int orderId = orderDAO.placeOrder(user.getId(), new ArrayList<>(cart.values()),
                total, cardHolderName.trim(), lastFour);

        if (orderId == -1) {
            req.setAttribute("error", "Payment could not be processed. Please try again.");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }

        // Reduce stock for each purchased product
        for (CartItem item : cart.values()) {
            productDAO.reduceStock(item.getProduct().getId(), item.getQuantity());
        }

        // Clear the cart after a successful order
        session.removeAttribute("cart");

        resp.sendRedirect("orderConfirmation?orderId=" + orderId);
    }
}