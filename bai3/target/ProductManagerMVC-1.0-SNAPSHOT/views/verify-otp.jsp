<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Thực OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-4 shadow-sm">
                <h4 class="text-center mb-3 text-primary">Nhập Mã OTP</h4>
                <p class="text-muted small text-center">Mã OTP đã được gửi đến email của bạn.</p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                    <div class="mb-3">
                        <input type="text" name="otp" class="form-control text-center fs-4" placeholder="123456" required maxlength="6">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Xác Nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>