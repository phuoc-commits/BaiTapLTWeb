<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shop điện tử - Sản phẩm mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f7fb; color: #172033; }
        .navbar { background: #172033; }
        .hero { background: linear-gradient(120deg, #172033, #315c83); color: white; border-radius: 0 0 28px 28px; }
        .product-card { border: 0; border-radius: 14px; overflow: hidden; transition: transform .2s, box-shadow .2s; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 12px 28px rgba(23,32,51,.14) !important; }
        .product-image { height: 190px; object-fit: cover; background: #e8edf4; }
        .price { color: #d84b3e; font-weight: 700; }
    </style>
</head>
<body>
<nav class="navbar navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">SHOP ĐIỆN TỬ</a>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/profile">Hồ sơ</a>
            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a>
            <a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </div>
    </div>
</nav>
<header class="hero py-5">
    <div class="container py-3">
        <p class="text-uppercase small mb-2 opacity-75">Bộ sưu tập mới nhất</p>
        <h1 class="display-6 fw-bold">10 sản phẩm mới nhất</h1>
        <p class="mb-0 opacity-75">Khám phá những sản phẩm vừa được cập nhật trong cửa hàng.</p>
    </div>
</header>
<main class="container py-5">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-5 g-4">
        <c:forEach items="${top10Products}" var="p">
            <div class="col">
                <div class="card product-card h-100 shadow-sm">
                    <img src="${pageContext.request.contextPath}/image?fname=${p.image}" class="card-img-top product-image" alt="${p.name}">
                    <div class="card-body d-flex flex-column">
                        <small class="text-muted mb-2">${p.category.categoryname}</small>
                        <h6 class="card-title">${p.name}</h6>
                        <p class="price mt-auto mb-3">${p.price} VNĐ</p>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-outline-dark btn-sm w-100">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty top10Products}">
        <div class="text-center py-5 text-muted">Chưa có sản phẩm nào.</div>
    </c:if>
</main>
</body>
</html>