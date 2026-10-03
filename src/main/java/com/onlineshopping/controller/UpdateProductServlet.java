package com.onlineshopping.controller;

import com.onlineshopping.dao.ProductDAO;
import com.onlineshopping.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/updateProduct")
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productDAO.getProductById(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("admin/update-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Product p = new Product();
            p.setId(Integer.parseInt(req.getParameter("id")));
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(new BigDecimal(req.getParameter("price")));
            p.setCategory(req.getParameter("category"));
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setImagePath(req.getParameter("imagePath"));

            productDAO.updateProduct(p);
            resp.sendRedirect("admin-dashboard.jsp?msg=updated");
        } catch (Exception e) {
            req.setAttribute("error", "Invalid product data: " + e.getMessage());
            req.getRequestDispatcher("admin/update-product.jsp").forward(req, resp);
        }
    }
}