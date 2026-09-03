package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import vn.iotstar.dao.impl.CategoryDao;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = { "/admin/product/edit" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProductEditController extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.get(id);
        req.setAttribute("product", product);
        req.setAttribute("categories", categoryDao.findAll());
        req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            // Lấy sản phẩm cũ để giữ lại ảnh nếu không up ảnh mới
            Product oldProduct = productService.get(id);
            String fileName = oldProduct.getImage();

            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                fileName = System.currentTimeMillis() + "_" + originalFileName;
                
                File uploadDir = new File(Constant.UPLOAD_DIR);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                filePart.write(Constant.UPLOAD_DIR + File.separator + fileName);
            }

                Product product = new Product(id, name, description, price, quantity, fileName,
                    categoryDao.findById(categoryId));
            productService.edit(product);

            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}