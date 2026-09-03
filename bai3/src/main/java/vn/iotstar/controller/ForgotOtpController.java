package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;

@WebServlet(urlPatterns = {"/forgot-otp"})
public class ForgotOtpController extends HttpServlet {
    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String otpInput = req.getParameter("otp");
        HttpSession session = req.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("resetEmail");
        User user = email == null ? null : userDao.findByEmail(email);

        if (user != null && user.getCode() != null && user.getCode().equals(otpInput)) {
            user.setCode(null);
            userDao.update(user);
            resp.sendRedirect(req.getContextPath() + "/reset-password");
            return;
        }

        req.setAttribute("error", "Mã OTP không chính xác hoặc phiên đã hết hạn.");
        req.getRequestDispatcher("/views/forgot-otp.jsp").forward(req, resp);
    }
}
