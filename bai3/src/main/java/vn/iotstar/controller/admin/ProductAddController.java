package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import vn.iotstar.dao.impl.CategoryDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {"/admin/product/add"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, 
    maxFileSize = 1024 * 1024 * 5, 
    maxRequestSize = 1024 * 1024 * 5 * 5
)
public class ProductAddController extends HttpServlet {
    private ProductDaoImpl productDao = new ProductDaoImpl();
    private CategoryDao categoryDao = new CategoryDao();

    private String getFileName(Part part) {
        if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().isBlank()) {
            return "default.png";
        }
        return Paths.get(part.getSubmittedFileName()).getFileName().toString();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", categoryDao.findAll());
        req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String description = req.getParameter("description");
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        Part filePart = req.getPart("image");
        String fileName = getFileName(filePart);
        
        File uploadDir = new File(Constant.UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        if (fileName != null && !fileName.isEmpty() && !fileName.equals("default.png")) {
            filePart.write(Constant.UPLOAD_DIR + File.separator + fileName);
        } else {
            fileName = "default.png";
        }

        Category category = categoryDao.findById(categoryId);
        Product product = new Product(0, name, description, price, quantity, fileName, category);
        productDao.insert(product);

        resp.sendRedirect(req.getContextPath() + "/admin/product/list");
    }
}