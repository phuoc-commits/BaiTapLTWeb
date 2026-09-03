<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="col-md-6 offset-md-3 bg-white p-4 rounded shadow-sm">
        <h4 class="mb-3 text-primary">Thêm Danh Mục Mới</h4>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label">Tên danh mục:</label>
                <input type="text" name="categoryname" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Link ảnh (URL):</label>
                <input type="text" name="images" class="form-control" placeholder="https://...">
            </div>
            <div class="mb-3">
                <label class="form-label">Hoặc tải ảnh lên từ máy:</label>
                <input type="file" name="images1" class="form-control" accept="image/*">
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái:</label><br>
                <div class="form-check form-check-inline">
                    <input type="radio" name="status" value="1" id="ston" class="form-check-input" checked>
                    <label for="ston" class="form-check-label">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="status" value="0" id="stoff" class="form-check-input">
                    <label for="stoff" class="form-check-label">Khóa</label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Thêm mới</button>
            <a href="<c:url value='/admin/categories'/>" class="btn btn-link w-100 mt-2 text-decoration-none">Hủy bỏ</a>
        </form>
    </div>
</div>
</body>
</html>