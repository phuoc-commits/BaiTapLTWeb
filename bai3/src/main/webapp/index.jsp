<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Tự động chuyển hướng về trang đăng nhập /login khi người dùng vào trang chủ
    response.sendRedirect(request.getContextPath() + "/login");
%>