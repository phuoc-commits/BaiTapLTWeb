package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;

@WebServlet(urlPatterns = {"/product"})
public class ProductListPublicController extends HttpServlet {
    private ProductDaoImpl productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 6; // Yêu cầu: Phân trang 6 sản phẩm
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        List<Product> list = productDao.findAll(page, pageSize);
        int totalProducts = productDao.count();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        req.setAttribute("productList", list);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        req.getRequestDispatcher("/views/product-grid.jsp").forward(req, resp);
    }
}