<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding: 20px; }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body p-5">
                    <h2 class="text-center mb-4">Đăng Nhập</h2>
                    
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger">${alert}</div>
                        <div class="text-center mb-3">
                            <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control" placeholder="Nhập username" required autofocus>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" placeholder="Nhập password" required>
                        </div>
                        
                        <div class="mb-3">
                            <input type="checkbox" class="form-check-input" id="remember" name="remember">
                            <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
                    </form>
                    
                    <hr>
                    <p class="text-center">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>