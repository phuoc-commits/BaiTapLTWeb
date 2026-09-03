<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="text-primary">Danh Sách Danh Mục</h3>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-success">+ Thêm Danh Mục</a>
    </div>

    <table class="table table-bordered table-striped align-middle bg-white">
        <thead class="table-dark">
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên Danh Mục</th>
                <th>Trạng thái</th>
                <th class="text-center">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="cate" varStatus="STT">
                <tr>
                    <td>${STT.index + 1}</td>
                    <td>
                        <c:choose>
                            <c:when test="${cate.images != null && cate.images.startsWith('https')}">
                                <c:url value="${cate.images}" var="imgUrl"/>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                            </c:otherwise>
                        </c:choose>
                        <img height="80" width="100" src="${imgUrl}" class="rounded border" style="object-fit: cover;" alt="Image"/>
                    </td>
                    <td class="fw-bold">${cate.categoryname}</td>
                    <td>
                        <span class="badge ${cate.status == 1 ? 'bg-success' : 'bg-danger'}">
                            ${cate.status == 1 ? 'Hoạt động' : 'Khóa'}
                        </span>
                    </td>
                    <td class="text-center">
                        <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" 
                           onclick="return confirm('Bạn có muốn xóa danh mục này?');" 
                           class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>