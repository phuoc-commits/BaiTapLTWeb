package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;

@WebServlet(urlPatterns = {"/product/detail"})
public class ProductDetailController extends HttpServlet {
    private ProductDaoImpl productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productDao.findById(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);
    }
}