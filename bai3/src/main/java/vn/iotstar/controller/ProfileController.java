package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
public class ProfileController extends HttpServlet {
    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAccount(req.getSession(false));
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            req.setAttribute("profile", user);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Không thể mở hồ sơ: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = getAccount(session);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        if (fullname == null || fullname.isBlank() || phone == null || phone.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ họ tên và số điện thoại.");
            req.setAttribute("profile", user);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            return;
        }

        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());
        try {
            Part imagePart = req.getPart("images");
            if (imagePart != null && imagePart.getSize() > 0) {
                File uploadDir = new File(Constant.UPLOAD_DIR);
                if (!uploadDir.exists() && !uploadDir.mkdirs()) {
                    throw new IOException("Không thể tạo thư mục upload: " + Constant.UPLOAD_DIR);
                }
                String originalName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String extension = "";
                int dot = originalName.lastIndexOf('.');
                if (dot >= 0) extension = originalName.substring(dot).toLowerCase();
                String fileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + extension;
                imagePart.write(new File(uploadDir, fileName).getAbsolutePath());
                user.setImages(fileName);
            }

            userDao.update(user);
            session.setAttribute("account", user);
            req.setAttribute("success", "Cập nhật hồ sơ thành công.");
        } catch (Exception e) {
            req.setAttribute("error", "Không thể cập nhật hồ sơ: " + e.getMessage());
        }
        req.setAttribute("profile", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    private User getAccount(HttpSession session) {
        return session == null ? null : (User) session.getAttribute("account");
    }
}