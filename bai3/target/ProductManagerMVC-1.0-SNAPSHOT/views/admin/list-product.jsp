<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .badge-outstock { background-color: #dc3545; }
        .badge-instock { background-color: #198754; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">
            <i class="bi bi-shop me-2"></i>Cửa Hàng Trực Tuyến
        </a>
        <div class="d-flex align-items-center text-white">
            <span class="me-3">Xin chào, <strong>${sessionScope.account.username}</strong> 
                <c:if test="${sessionScope.account.roleid == 1}"><span class="badge bg-danger ms-1">Admin</span></c:if>
                <c:if test="${sessionScope.account.roleid != 1}"><span class="badge bg-info ms-1">Khách hàng</span></c:if>
            </span>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-light btn-sm me-2"><i class="bi bi-person"></i> Hồ sơ</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm"><i class="bi bi-box-arrow-right"></i> Thoát</a>
        </div>
    </div>
</nav>

<div class="container mt-4 mb-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="m-0 font-weight-bold text-primary"><i class="bi bi-box-seam me-2"></i>Danh Sách Sản Phẩm</h5>
            <c:if test="${sessionScope.account.roleid == 1}">
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success btn-sm">
                    <i class="bi bi-plus-lg me-1"></i>Thêm sản phẩm mới
                </a>
            </c:if>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Mô tả</th>
                            <th>Giá bán</th>
                            <th>Kho hàng</th>
                            <th class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p" varStatus="STT">
                            <tr>
                                <td>${STT.index + 1}</td>
                                <td>
                                    <c:url value="/image?fname=${p.image}" var="imgUrl"/>
                                    <img src="${imgUrl}" class="rounded border" width="60" height="60" style="object-fit: cover;" alt="Product">
                                </td>
                                <td class="fw-semibold">${p.name}</td>
                                <td><small class="text-muted">${p.description}</small></td>
                                <td class="text-danger fw-bold">
                                    <fmt:formatNumber value="${p.price}" type="number"/> VNĐ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.quantity > 0}">
                                            <span class="badge badge-instock">Còn ${p.quantity} SP</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-outstock">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <!-- DÀNH CHO ADMIN -->
                                    <c:if test="${sessionScope.account.roleid == 1}">
                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}" class="btn btn-warning btn-sm me-1">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');" 
                                           class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </c:if>

                                    <!-- DÀNH CHO USER THƯỜNG -->
                                    <c:if test="${sessionScope.account.roleid != 1}">
                                        <c:choose>
                                            <c:when test="${p.quantity > 0}">
                                                <a href="${pageContext.request.contextPath}/user/product/buy?id=${p.id}" 
												   onclick="return confirm('Bạn muốn mua 1 sản phẩm ${p.name}?');" 
												   class="btn btn-primary btn-sm">
 												   <i class="bi bi-cart-plus"></i> Mua Ngay
												</a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary btn-sm" disabled>
                                                    <i class="bi bi-x-circle"></i> Tạm Hết Hàng
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>