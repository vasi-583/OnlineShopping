package com.onlineshopping.controller;

import com.onlineshopping.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet("/cart")
public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        BigDecimal total = BigDecimal.ZERO;
        if (cart != null) {
            for (CartItem item : cart.values()) {
                total = total.add(item.getSubtotal());
            }
        }

        req.setAttribute("cart", cart);
        req.setAttribute("total", total);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }
}