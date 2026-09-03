package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/user/product/buy" })
public class BuyProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.get(id);

            // Kiểm tra nếu sản phẩm còn hàng thì trừ 1
            if (product != null && product.getQuantity() > 0) {
                product.setQuantity(product.getQuantity() - 1);
                productService.edit(product); // Cập nhật lại vào MySQL
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Quay lại trang danh sách sản phẩm
        resp.sendRedirect(req.getContextPath() + "/admin/product/list");
    }
}