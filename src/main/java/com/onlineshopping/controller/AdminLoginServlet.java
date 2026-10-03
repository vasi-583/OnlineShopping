package com.onlineshopping.controller;

import com.onlineshopping.dao.UserDAO;
import com.onlineshopping.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("admin/admin-login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User admin = userDAO.validateLogin(username, password, "ADMIN");

        if (admin != null) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", admin);
            resp.sendRedirect("admin/admin-dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid admin credentials.");
            req.getRequestDispatcher("admin/admin-login.jsp").forward(req, resp);
        }
    }
}