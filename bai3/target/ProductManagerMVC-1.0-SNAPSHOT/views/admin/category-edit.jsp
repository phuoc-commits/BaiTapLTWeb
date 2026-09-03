<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="col-md-6 offset-md-3 bg-white p-4 rounded shadow-sm">
        <h4 class="mb-3 text-warning">Chỉnh Sửa Danh Mục</h4>
        <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryId}">

            <div class="mb-3">
                <label class="form-label">Tên danh mục:</label>
                <input type="text" name="categoryname" value="${cate.categoryname}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Link ảnh (URL):</label>
                <input type="text" name="images" value="${cate.images}" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Ảnh hiện tại:</label><br>
                <c:choose>
                    <c:when test="${cate.images != null && cate.images.startsWith('https')}">
                        <c:url value="${cate.images}" var="imgUrl"/>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                    </c:otherwise>
                </c:choose>
                <img height="100" width="120" src="${imgUrl}" class="rounded border mb-2" style="object-fit: cover;" alt="Current Image"/><br>
                <label class="form-label">Chọn ảnh mới (nếu muốn đổi):</label>
                <input type="file" name="images1" class="form-control" accept="image/*">
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái:</label><br>
                <div class="form-check form-check-inline">
                    <input type="radio" name="status" value="1" id="ston" class="form-check-input" ${cate.status == 1 ? 'checked' : ''}>
                    <label for="ston" class="form-check-label">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="status" value="0" id="stoff" class="form-check-input" ${cate.status != 1 ? 'checked' : ''}>
                    <label for="stoff" class="form-check-label">Khóa</label>
                </div>
            </div>
            <button type="submit" class="btn btn-warning text-white w-100 fw-bold">Lưu Thay Đổi</button>
            <a href="<c:url value='/admin/categories'/>" class="btn btn-link w-100 mt-2 text-decoration-none">Hủy bỏ</a>
        </form>
    </div>
</div>
</body>
</html>