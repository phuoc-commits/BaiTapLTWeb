package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;

@WebServlet(urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newPassword = req.getParameter("newPassword");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null || newPassword == null || newPassword.isBlank()) {
            req.setAttribute("error", "Phiên đặt lại mật khẩu đã hết hoặc dữ liệu chưa đầy đủ.");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        User user = userDao.findByEmail(email);
        if (user != null && user.getCode() == null) {
            user.setPassword(newPassword);
            userDao.update(user);
            session.removeAttribute("resetEmail");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Không thể đặt lại mật khẩu. Vui lòng thực hiện lại từ chức năng quên mật khẩu.");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}