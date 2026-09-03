<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f6f9; }
        .card-custom { border-radius: 15px; border: none; box-shadow: 0 5px 20px rgba(0,0,0,0.08); }
        .preview-img { width: 120px; height: 120px; object-fit: cover; border-radius: 10px; border: 2px dashed #0d6efd; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-custom p-4">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="m-0 fw-bold text-warning"><i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Sản Phẩm</h4>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${product.id}">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên sản phẩm</label>
                            <input type="text" name="name" value="${product.name}" class="form-control" placeholder="Nhập tên sản phẩm" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Giá bán (VNĐ)</label>
                                <div class="input-group">
                                    <input type="number" step="0.01" name="price" value="${product.price}" class="form-control" required>
                                    <span class="input-group-text">VNĐ</span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Số lượng trong kho</label>
                                <input type="number" name="quantity" value="${product.quantity}" class="form-control" min="0" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                            <textarea name="description" class="form-control" rows="3" placeholder="Mô tả chi tiết sản phẩm...">${product.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold" for="categoryId">Danh mục</label>
                            <select name="categoryId" id="categoryId" class="form-select" required>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryId}" ${category.categoryId == product.category.categoryId ? 'selected' : ''}>${category.categoryname}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Hình ảnh sản phẩm</label>
                            <div class="d-flex align-items-center gap-3 mb-2">
                                <c:url value="/image?fname=${product.image}" var="imgUrl"/>
                                <img id="imgPreview" src="${imgUrl}" class="preview-img" alt="Product Image">
                                <div>
                                    <input type="file" name="image" id="imageInput" class="form-control mb-1" accept="image/*" onchange="previewFile()">
                                    <small class="text-muted d-block">Để trống nếu không muốn đổi ảnh mới.</small>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-light">Hủy bỏ</a>
                            <button type="submit" class="btn btn-warning text-white px-4 fw-bold">
                                <i class="bi bi-check-circle me-1"></i>Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function previewFile() {
        const preview = document.getElementById('imgPreview');
        const file = document.getElementById('imageInput').files[0];
        const reader = new FileReader();

        reader.addEventListener("load", function () {
            preview.src = reader.result;
        }, false);

        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>