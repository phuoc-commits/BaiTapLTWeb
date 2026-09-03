package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.util.EmailUtil;

@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email == null || email.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập email đăng ký.");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }
        User user = userDao.findByEmail(email);

        if (user == null) {
            req.setAttribute("error", "Email không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        String otp = String.format("%06d", new Random().nextInt(900000) + 100000);
        user.setCode(otp);
        userDao.update(user);

        if (!EmailUtil.sendEmail(email, "Cấp lại mật khẩu - OTP", "Mã OTP đặt lại mật khẩu của bạn là: " + otp)) {
            req.setAttribute("error", "Không thể gửi email OTP. Vui lòng cấu hình email SMTP rồi thử lại.");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }
        req.getSession().setAttribute("resetEmail", email);
        resp.sendRedirect(req.getContextPath() + "/forgot-otp");
    }
}