package com.onlineshopping.controller;

import com.onlineshopping.dao.ProductDAO;
import com.onlineshopping.model.CartItem;
import com.onlineshopping.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int qty = 1;
        String qtyParam = req.getParameter("quantity");
        if (qtyParam != null && !qtyParam.isEmpty()) {
            try { qty = Integer.parseInt(qtyParam); } catch (NumberFormatException ignored) {}
        }

        Product product = productDAO.getProductById(productId);
        if (product == null) {
            resp.sendRedirect("products");
            return;
        }

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
        }

        if (cart.containsKey(productId)) {
            CartItem existing = cart.get(productId);
            existing.setQuantity(existing.getQuantity() + qty);
        } else {
            cart.put(productId, new CartItem(product, qty));
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("products?added=1");
    }
}