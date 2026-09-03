<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ sơ cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f7fb; }
        .profile-card { max-width: 680px; margin: 48px auto; border: 0; border-radius: 16px; box-shadow: 0 12px 30px rgba(23,32,51,.1); }
        .avatar { width: 112px; height: 112px; object-fit: cover; border-radius: 50%; background: #e8edf4; }
    </style>
</head>
<body>
<div class="container">
    <div class="card profile-card">
        <div class="card-body p-4 p-md-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div><h2 class="mb-1">Hồ sơ cá nhân</h2><p class="text-muted mb-0">Cập nhật thông tin tài khoản của bạn</p></div>
                <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/home">Trang chủ</a>
            </div>
            <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
            <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
            <div class="text-center mb-4">
                <c:choose>
                    <c:when test="${not empty profile.images}"><img class="avatar" src="${pageContext.request.contextPath}/image?fname=${profile.images}" alt="Ảnh đại diện"></c:when>
                    <c:otherwise><div class="avatar d-inline-flex align-items-center justify-content-center text-muted">Chưa có ảnh</div></c:otherwise>
                </c:choose>
            </div>
            <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                <div class="mb-3"><label class="form-label">Tên đăng nhập</label><input class="form-control" value="${profile.username}" readonly></div>
                <div class="mb-3"><label class="form-label">Họ và tên</label><input class="form-control" name="fullname" value="${profile.fullname}" maxlength="100" required></div>
                <div class="mb-3"><label class="form-label">Số điện thoại</label><input class="form-control" name="phone" value="${profile.phone}" maxlength="20" pattern="[0-9+() -]{8,20}" required></div>
                <div class="mb-4"><label class="form-label">Ảnh đại diện</label><input class="form-control" type="file" name="images" accept="image/*"><div class="form-text">Dung lượng tối đa 5 MB.</div></div>
                <button class="btn btn-primary w-100" type="submit">Lưu thay đổi</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>