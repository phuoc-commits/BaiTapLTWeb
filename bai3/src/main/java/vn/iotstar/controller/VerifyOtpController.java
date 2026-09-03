package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController extends HttpServlet {
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String otpInput = req.getParameter("otp");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("registeredEmail");

        User user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otpInput)) {
            user.setStatus(1); // Kích hoạt tài khoản thành công
            user.setCode(null);
            userDao.update(user);
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Mã OTP không đúng!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}