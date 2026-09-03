<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-4 shadow-sm">
                <h4 class="text-center mb-3 text-danger">Quên Mật Khẩu</h4>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="mb-3">
                        <label class="form-label">Nhập Email đăng ký:</label>
                        <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                    </div>
                    <button type="submit" class="btn btn-danger w-100">Gửi Mã OTP</button>
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small">Quay lại đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>