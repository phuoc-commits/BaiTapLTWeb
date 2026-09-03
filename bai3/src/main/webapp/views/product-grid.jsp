<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">SHOP ĐIỆN TỬ</a>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/profile">Hồ sơ</a>
            <a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </div>
    </div>
</nav>
<div class="container my-4">
    <h3 class="mb-4">Tất Cả Sản Phẩm</h3>
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <c:forEach items="${productList}" var="p">
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <img src="${pageContext.request.contextPath}/image?fname=${p.image}" class="card-img-top" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">${p.name}</h5>
                        <p class="card-text text-danger fw-bold fs-5">${p.price} VNĐ</p>
                        <p class="card-text text-muted small">Danh mục: ${p.category.categoryname}</p>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-primary w-100">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Thanh phân trang -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>
</body>
</html>