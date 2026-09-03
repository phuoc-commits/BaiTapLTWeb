package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Paths;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.isBlank()) return;
        fileName = Paths.get(fileName).getFileName().toString();

        File file = new File(Constant.DIR, fileName);
        if (file.exists()) {
            String contentType = getServletContext().getMimeType(file.getName());
            resp.setContentType(contentType == null ? "application/octet-stream" : contentType);
            try (FileInputStream in = new FileInputStream(file); OutputStream out = resp.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        }
    }
}