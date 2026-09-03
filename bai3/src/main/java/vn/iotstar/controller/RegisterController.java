package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.util.EmailUtil;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String repassword = req.getParameter("repassword");

        if (!password.equals(repassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userDao.checkExistUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Tạo mã OTP ngẫu nhiên 6 chữ số
        String otp = String.format("%06d", new Random().nextInt(900000) + 100000);
        User user = new User(username, password, email, 2, 0, otp); // roleid=2, status=0 (chưa kích hoạt)
        userDao.insert(user);

        // Gửi OTP qua email
        if (!EmailUtil.sendEmail(email, "Mã kích hoạt tài khoản", "Mã OTP kích hoạt tài khoản của bạn là: " + otp)) {
            req.setAttribute("error", "Không thể gửi email OTP. Vui lòng cấu hình email SMTP rồi thử lại.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("registeredEmail", email);
        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}