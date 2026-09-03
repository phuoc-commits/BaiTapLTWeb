<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <div class="row">
        <div class="col-md-5">
            <img src="${pageContext.request.contextPath}/image?fname=${product.image}" class="img-fluid rounded border shadow-sm">
        </div>
        <div class="col-md-7">
            <h2>${product.name}</h2>
            <h3 class="text-danger my-3">${product.price} VNĐ</h3>
            <p><strong>Danh mục:</strong> ${product.category.categoryname}</p>
            <p><strong>Số lượng còn:</strong> ${product.quantity}</p>
            <hr>
            <p><strong>Mô tả sản phẩm:</strong></p>
            <p>${product.description}</p>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary mt-3">Quay lại danh sách</a>
        </div>
    </div>
</div>
</body>
</html>