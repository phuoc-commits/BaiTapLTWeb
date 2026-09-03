<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Lại Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-4 shadow-sm">
                <h4 class="text-center mb-3 text-warning">Đặt Lại Mật Khẩu</h4>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới:</label>
                        <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 fw-bold">Cập Nhật Mật Khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>