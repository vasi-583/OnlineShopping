package com.onlineshopping.controller;

import com.onlineshopping.dao.OrderDAO;
import com.onlineshopping.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/orderConfirmation")
public class OrderConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            resp.sendRedirect("products");
            return;
        }

        req.setAttribute("order", order);
        req.getRequestDispatcher("order-confirmation.jsp").forward(req, resp);
    }
}