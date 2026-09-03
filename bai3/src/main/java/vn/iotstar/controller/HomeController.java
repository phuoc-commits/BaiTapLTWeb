package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.iotstar.dao.impl.ProductDaoImpl;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private ProductDaoImpl productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("top10Products", productDao.findTop10());
        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}