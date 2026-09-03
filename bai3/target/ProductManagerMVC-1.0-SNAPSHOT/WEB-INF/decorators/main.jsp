<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shop điện tử</title>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">SHOP ĐIỆN TỬ</a>
            <div class="d-flex gap-2">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>
        </div>
    </nav>
</body>
</html>