<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác nhận OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-4 shadow-sm">
                <h4 class="text-center mb-3 text-primary">Xác nhận OTP</h4>
                <p class="text-muted small text-center">Nhập mã OTP đã gửi tới email của bạn.</p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/forgot-otp" method="post">
                    <input type="text" name="otp" class="form-control text-center mb-3" placeholder="Nhập mã 6 số" maxlength="6" required>
                    <button type="submit" class="btn btn-primary w-100">Xác nhận OTP</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
