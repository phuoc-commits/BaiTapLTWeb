<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f4f6f9;
        }
        .form-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        .form-header {
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            color: white;
            padding: 28px 32px;
        }
        .image-preview-box {
            width: 100%;
            height: 220px;
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            overflow: hidden;
            position: relative;
            transition: all 0.3s ease;
        }
        .image-preview-box:hover {
            border-color: #3b82f6;
            background-color: #eff6ff;
        }
        .image-preview-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            display: none;
        }
        .form-control:focus, .form-select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
        }
        .btn-gradient {
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            color: white;
            border: none;
            font-weight: 600;
            padding: 12px 28px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
            color: white;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card form-card">
                <!-- Header -->
                <div class="form-header d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="fw-bold mb-1"><i class="bi bi-box-seam me-2"></i>Thêm Sản Phẩm Mới</h4>
                        <p class="mb-0 text-white-50" style="font-size: 0.9rem;">Nhập đầy đủ thông tin sản phẩm để thêm vào cửa hàng</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-sm btn-light text-dark fw-semibold px-3 py-2 rounded-3">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                </div>

                <!-- Form Body -->
                <div class="card-body p-4 p-md-5">
                    <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
                        
                        <div class="row g-4">
                            <!-- Tên sản phẩm -->
                            <div class="col-12">
                                <label for="productName" class="form-label fw-semibold text-dark">Tên sản phẩm <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-tag text-muted"></i></span>
                                    <input type="text" class="form-control border-start-0 ps-0" id="productName" name="name" placeholder="VD: Laptop Dell XPS 13" required>
                                </div>
                            </div>

                            <!-- Giá sản phẩm -->
                            <div class="col-md-6">
                                <label for="productPrice" class="form-label fw-semibold text-dark">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-currency-dollar text-muted"></i></span>
                                    <input type="number" class="form-control border-start-0 ps-0" id="productPrice" name="price" placeholder="VD: 15000000" required min="0">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="productQuantity" class="form-label fw-semibold text-dark">Số lượng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="productQuantity" name="quantity" min="0" value="0" required>
                            </div>

                            <div class="col-md-6">
                                <label for="categoryId" class="form-label fw-semibold text-dark">Danh mục <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="" selected disabled>Chọn danh mục</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Chọn hình ảnh -->
                            <div class="col-md-6">
                                <label for="productImage" class="form-label fw-semibold text-dark">Hình ảnh sản phẩm</label>
                                <input type="file" class="form-control" id="productImage" name="image" accept="image/*" onchange="previewImage(event)">
                            </div>

                            <!-- Khu vực xem trước ảnh -->
                            <div class="col-12">
                                <label class="form-label fw-semibold text-dark">Xem trước ảnh</label>
                                <div class="image-preview-box" id="previewContainer">
                                    <div class="text-center text-muted" id="placeholderText">
                                        <i class="bi bi-cloud-arrow-up display-5"></i>
                                        <p class="mt-2 mb-0 small">Chọn tệp hình ảnh để xem trước hiển thị tại đây</p>
                                    </div>
                                    <img id="imgPreview" alt="Xem trước sản phẩm">
                                </div>
                            </div>

                            <!-- Mô tả sản phẩm -->
                            <div class="col-12">
                                <label for="productDescription" class="form-label fw-semibold text-dark">Mô tả sản phẩm</label>
                                <textarea class="form-control" id="productDescription" name="description" rows="4" placeholder="Nhập thông tin chi tiết về sản phẩm..."></textarea>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-light px-4 py-2 border fw-semibold">Hủy bỏ</a>
                            <button type="submit" class="btn btn-gradient">
                                <i class="bi bi-plus-circle me-1"></i> Lưu Sản Phẩm
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function previewImage(event) {
        const input = event.target;
        const imgPreview = document.getElementById('imgPreview');
        const placeholderText = document.getElementById('placeholderText');

        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imgPreview.src = e.target.result;
                imgPreview.style.display = 'block';
                placeholderText.style.display = 'none';
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>