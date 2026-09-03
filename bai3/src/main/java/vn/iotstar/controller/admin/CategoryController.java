package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig()
@WebServlet(urlPatterns = { 
    "/admin/categories", 
    "/admin/category/add", 
    "/admin/category/insert",
    "/admin/category/edit", 
    "/admin/category/update", 
    "/admin/category/delete" 
})
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
            
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
            
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = cateService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
            
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusValue = req.getParameter("status");
            String images = req.getParameter("images");

            if (categoryname == null || categoryname.isBlank() || statusValue == null) {
                req.setAttribute("error", "Vui lòng nhập tên và chọn trạng thái danh mục.");
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }
            int status = Integer.parseInt(statusValue);

            if (cateService.findByCategoryname(categoryname.trim()) != null) {
                req.setAttribute("error", "Tên danh mục đã tồn tại.");
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index >= 0 ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages("avatar.png");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Không thể xử lý ảnh danh mục: " + e.getMessage());
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            try {
                cateService.insert(category);
            } catch (Exception e) {
                req.setAttribute("error", "Không thể tạo danh mục: " + e.getMessage());
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryid);
            String fileold = category.getImages();

            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    // Xóa file cũ nếu không phải đường dẫn link https
                    if (fileold != null && !fileold.startsWith("https")) {
                        deleteFile(uploadPath + File.separator + fileold);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    category.setImages(fname);
                } else if (images != null && !images.isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}